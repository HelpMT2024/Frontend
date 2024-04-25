import 'package:help_my_truck/data/models/contentfull_entnities.dart';
import 'package:help_my_truck/data/models/warning.dart';

class Fault {
  String id;
  String spnCode;
  List<String> fmiCodes;
  bool showAsPdf;
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
    required this.showAsPdf,
  });

  factory Fault.fromJson(Map<String, dynamic> json) {
    return Fault(
      id: json['sys']['id'],
      spnCode: json['spnCode'],
      fmiCodes: List<String>.from(json['fmiCodes']),
      image: json['image'] != null ? IDPImage.fromJson(json['image']) : null,
      description: json['description']?['json'],
      pdfFilesCollection:
          PdfFilesCollection.fromJson(json['pdfFilesCollection']),
      videosCollection: VideosCollection.fromJson(json['videosCollection']),
      showAsPdf: json['showAsPdf'],
    );
  }
}

class ChildFault {
  String id;
  String spnCode;
  List<String> fmiCodes;
  bool showAsPdf;

  String get text => 'SPN $spnCode, FMI ${fmiCodes.join(', ')}';

  ChildFault({
    required this.id,
    required this.spnCode,
    required this.fmiCodes,
    required this.showAsPdf,
  });

  factory ChildFault.fromJson(Map<String, dynamic> json) {
    return ChildFault(
      id: json['sys']['id'],
      spnCode: json['spnCode'],
      fmiCodes: List<String>.from(json['fmiCodes']),
      showAsPdf: json['showAsPdf'],
    );
  }
}

enum SearchFaultDetailType { component, part, problemCase, warningLight }

class SearchFaultDetail {
  final String id;
  final String name;
  final SearchFaultDetailType type;

  SearchFaultDetail({
    required this.id,
    required this.name,
    required this.type,
  });

  factory SearchFaultDetail.fromJson(Map<String, dynamic> json) {
    return SearchFaultDetail(
      id: json['sys']['id'],
      name: json['name'],
      type: json['type'] == 'WarningLight'
          ? SearchFaultDetailType.warningLight
          : json['__typename'] == 'Component'
              ? SearchFaultDetailType.component
              : json['__typename'] == 'Part'
                  ? SearchFaultDetailType.part
                  : SearchFaultDetailType.problemCase,
    );
  }
}

class SearchFault {
  final String? id;
  final String? spnCode;
  final bool showAsPdf;
  final List<String>? fmiCodes;
  final List<SearchFaultDetail> linkedFrom;

  SearchFault({
    required this.id,
    required this.spnCode,
    required this.fmiCodes,
    required this.linkedFrom,
    required this.showAsPdf,
  });

  factory SearchFault.fromWarning(Warning warning) {
    return SearchFault(
      id: null,
      spnCode: null,
      fmiCodes: null,
      linkedFrom: warning.linkedFrom,
      showAsPdf: false,
    );
  }

  factory SearchFault.fromJson(Map<String, dynamic> json) {
    return SearchFault(
      id: json['sys']['id'],
      spnCode: json['spnCode'],
      fmiCodes: List<String>.from(json['fmiCodes']),
      linkedFrom: json['linkedFrom']['entryCollection']['items']
          .map<SearchFaultDetail>((e) => SearchFaultDetail.fromJson(e))
          .toList(),
      showAsPdf: json['showAsPdf'],
    );
  }
}
