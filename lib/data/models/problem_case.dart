import 'package:help_my_truck/data/models/child_problem.dart';
import 'package:help_my_truck/data/models/contentfull_entnities.dart';
import 'package:help_my_truck/data/models/fault.dart';

class ProblemCase {
  final String name;
  final Map<String, dynamic>? description;
  final List<IDPVideo> videos;
  final PdfFilesCollection pdfFilesCollection;
  final List<ChildWarningLight> warningLights;
  final IDPImage? image;
  final List<ChildFault> faults;

  ProblemCase({
    required this.name,
    required this.description,
    required this.videos,
    required this.pdfFilesCollection,
    required this.warningLights,
    required this.image,
    required this.faults,
  });

  factory ProblemCase.fromJson(Map<String, dynamic> json) {
    return ProblemCase(
      name: json['name'],
      description: json['description']?['json'],
      pdfFilesCollection:
          PdfFilesCollection.fromJson(json['pdfFilesCollection']),
      videos: json['videosCollection']?['items']
              .map<IDPVideo>((e) => IDPVideo.fromJson(e))
              .toList() ??
          [],
      warningLights: json['warningLightsCollection']?['items']
              .map<ChildWarningLight>((e) => ChildWarningLight.fromJson(e))
              .toList() ??
          [],
      image: json['image'] != null ? IDPImage.fromJson(json['image']) : null,
      faults: json['faultCodesCollection']?['items']
              .map<ChildFault>((e) => ChildFault.fromJson(e))
              .toList() ??
          [],
    );
  }
}
