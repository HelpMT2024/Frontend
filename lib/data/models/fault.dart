import 'package:help_my_truck/data/models/contentfull_entnities.dart';

class Fault {
  String id;
  String spnCode;
  List<String> fmiCodes;
  final IDPImage? image;
  final Map<String, dynamic>? description;
  final PdfFilesCollection pdfFilesCollection;
  final VideosCollection videosCollection;

  String get text => 'SPN $spnCode, FMI ${fmiCodes.join(', ')}';

  Fault({
    required this.id,
    required this.spnCode,
    required this.fmiCodes,
    required this.image,
    required this.description,
    required this.pdfFilesCollection,
    required this.videosCollection,
  });

  factory Fault.fromJson(Map<String, dynamic> json) {
    return Fault(
      id: json['sys']['id'],
      spnCode: json['spnCode'],
      fmiCodes: List<String>.from(json['fmiCodes']),
      image: json['image'] != null ? IDPImage.fromJson(json['image']) : null,
      description: json['description']['json'],
      pdfFilesCollection:
          PdfFilesCollection.fromJson(json['pdfFilesCollection']),
      videosCollection: VideosCollection.fromJson(json['videosCollection']),
    );
  }
}

class ChildFault {
  String id;
  String spnCode;
  List<String> fmiCodes;

  String get text => 'SPN $spnCode, FMI ${fmiCodes.join(', ')}';

  ChildFault({
    required this.id,
    required this.spnCode,
    required this.fmiCodes,
  });

  factory ChildFault.fromJson(Map<String, dynamic> json) {
    return ChildFault(
      id: json['sys']['id'],
      spnCode: json['spnCode'],
      fmiCodes: List<String>.from(json['fmiCodes']),
    );
  }
}

enum SearcFaultDetailType {
  component,
  part,
}

class SearcFaultDetail {
  final String id;
  final String name;
  final SearcFaultDetailType type;

  SearcFaultDetail({
    required this.id,
    required this.name,
    required this.type,
  });

  factory SearcFaultDetail.fromJson(Map<String, dynamic> json) {
    return SearcFaultDetail(
      id: json['sys']['id'],
      name: json['name'],
      type: json['__typename'] == 'Part'
          ? SearcFaultDetailType.part
          : SearcFaultDetailType.component,
    );
  }
}

class SearchFault {
  final String id;
  final String spnCode;
  final List<String> fmiCodes;
  final List<SearcFaultDetail> linkedFrom;

  SearchFault({
    required this.id,
    required this.spnCode,
    required this.fmiCodes,
    required this.linkedFrom,
  });

  factory SearchFault.fromJson(Map<String, dynamic> json) {
    return SearchFault(
      id: json['sys']['id'],
      spnCode: json['spnCode'],
      fmiCodes: List<String>.from(json['fmiCodes']),
      linkedFrom: json['linkedFrom']['entryCollection']['items']
          .map<SearcFaultDetail>((e) => SearcFaultDetail.fromJson(e))
          .toList(),
    );
  }
}
