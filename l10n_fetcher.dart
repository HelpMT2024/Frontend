import 'package:gsheets/gsheets.dart';
import 'dart:io';
import 'dart:convert';

const _credentials = r'''
{
  "type": "service_account",
  "project_id": "helpmytruck",
  "private_key_id": "fa24dea1fac94f79e798a3b2eac9e58eab9cd065",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQCG3hXpkOOgM2j0\n9FtUEWXGDKk5GQiv6qD9+DQMRIAEqAGNGMrv1d9o9g4JVXiVLciAA/WUJK6cFFPM\nu9Z4PzT76JXiyqij1Oi/sazrVMi7UIU2Loivudx3Y74ZOjJOWK/6h6UCFZ4y3ZjX\n68zBJzrZ3zgPYVaKQvicYLULEgYMSEbZgVh56fxbfm7nJ7e881KdEOydq8h/BH5K\n/N3TNdKUWgElp/UJOfte7QTkN6+gg728p9YorNwvv2gys3qKqWV6JoVBKIVidlIy\nA3aRQ0tePoAXeAZIxAHl1nY+VQGtfqcmdbbZWvo4w4JG237bHQ0Zyhz40PmSe5dY\nSlOkCwWXAgMBAAECggEAI7d0/iIM5kQ3K4f7F8xzs3tu5Vwn3M66TAgLYKRTcug7\nYO6L7/An9lgTZ41nHbq+OojR5KXCSDtp5fJo3fd/RKdX6nPZLWoZKYsYTEprzo+I\nd8zjDgaeyE917KBo6i66jBKYNHEdMENXUvdzhkOpZkGjSw9wJ7WMuX0y9PeU+nNX\nQy5N3jrGOsTN4qkyE9NNjr5jkv0oHlTbNaPcTaKZJQNWDu/G1unGtwV5P1HEQGNF\ny4SxAcRzPrwzxOulw+l2VcNTe+OJ/YjJpL/6edpe4TuXklLnNvBDZ6wEjbO/8Vmf\njtWEHCME62biO76Xs6uNv6X3T/43qPWLqpN31kf7YQKBgQC8HuMnp/kQL0QpAD7g\nRuoV73NRrm1L+rAavFteDUlDYfoBAXw4Tb05k8XIRaAunEJHdNB+3x8+UoocyKgD\n8LVylqiFBacLxJ/V8ISpfZoSTqAdV9IZ+IewdXM+zAn+jsDoKB1DmmuG2lixTfmn\ndd3wYgVJKyoiIASPzAoJonvG2wKBgQC3iBdNQAZzYKI4k3A8N7ZDUKH++lNEeYSv\n3bRKl6AdGNItxgoFrOfCMd58cg/Ad/YWTktiwYmH3oOrGGXPspE1gsRehpFglbbB\ncJy5sqclp+ttdVS3e0EQAlyL2YnDgIoquGo5hQo4kb/842TjVs11K5bw3H9CA0qn\nBb6SbpgC9QKBgQChdnlNfjSdmZQNBPLymKsuLJl0EBwrTH1+VRCuxwSM2zkzR80Q\nnli9ZIIrhOcZWnDg1/hkDKnKWhnE3sympSF3uqvlkJZx2U++1nNm7jEhaW6wAMKK\nG/CKmiRST9p8LJaSLGwBrDaCRkI93EldXCMjwV38ERpWs9h2e5BZ+KX4ZQKBgEkL\n3VpdtTOOroIeDHmrItu/5/n339RNGUZ10yAtIQjzrBOT0sFXhBaCiq61JxfPpx5R\noyd3KCnvojAi0cLMq4bEuSt2G755V/e9vmMae/Q81TMHk+RDJi4dAoCW4IHzUwqV\nw5GJJfxF5kfcqXbiQXv1EWpkGDJJ5Rh87NCTO+VRAoGBAJv3C7DZg1awfEDulaKB\n0ovjBzpx4IF6ooBBlSfYkpZ3h5qIYTAdYQvurP1MDdAVXSeccWdoeLdG5/Rbp32o\nM3Iomg1T/ISZ6KZV36d82BlP5RS3fcaAx72T1Br6p9sv7dtY6MWreTnfbeIPlM/F\n3nDpaFa+TY3kjlG2S7SjDMb7\n-----END PRIVATE KEY-----\n",
  "client_email": "helpmytruck@helpmytruck.iam.gserviceaccount.com",
  "client_id": "112355401027349763525",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/helpmytruck%40helpmytruck.iam.gserviceaccount.com",
  "universe_domain": "googleapis.com",
  "oauthScopes": ["https://www.googleapis.com/auth/spreadsheets.readonly"]
}
''';

void main() async {
  final gsheets = GSheets(_credentials);
  const spreadsheetId = '1Eg0OSaMRUu1AgFFwGyHvNOPG-0EtKZOh881hQYRueRU';
  final ss = await gsheets.spreadsheet(spreadsheetId);

  var sheet = ss.worksheetByTitle('translations');
  var keys = await sheet?.values.column(1, fromRow: 2);
  var keysCount = keys?.length ?? 0;
  var locales = await sheet?.values.row(1, fromColumn: 3);
  var localesCount = locales?.length ?? 0;

  for (var i = 0; i < localesCount; i++) {
    var values = await sheet?.values.column(i + 3, fromRow: 2);
    var locale = locales?[i];
    var map = {};

    for (var j = 0; j < keysCount; j++) {
      map[keys?[j]] = values?[j];
    }

    File file = File('lib/l10n/app_$locale.arb'); //load the json file

    file.writeAsStringSync(
      json.encode(map),
    ); //write
  }
}
