import 'package:help_my_truck/extensions/widget_error.dart';
import 'package:help_my_truck/services/API/auth_provider.dart';
import 'package:rxdart/rxdart.dart';

class PrivacyPolicyScreenViewModel with ErrorHandable {
  final AuthProvider provider;

  late final text = BehaviorSubject<String?>.seeded(null)
    ..addStream(Stream.fromFuture(
      // ignore: body_might_complete_normally_catch_error
      provider.policy().catchError((error) {
        showAlertDialog(null, error);
      }),
    ));

  PrivacyPolicyScreenViewModel({required this.provider});
}
