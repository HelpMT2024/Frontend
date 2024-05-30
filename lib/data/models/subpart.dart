import 'package:help_my_truck/data/models/child_problem.dart';
import 'package:help_my_truck/data/models/contentfull_entnities.dart';
import 'package:help_my_truck/data/models/fault.dart';

class SubPart {
  final String name;
  final IDPIcon? icon;
  final List<ChildFault> faults;
  final Map<String, dynamic>? description;
  final IDPPartImageView? imageView;
  final PdfFilesCollection? pdfFilesCollection;
  final VideosCollection? videosCollection;
  final List<ChildProblem> problems;
  final List<ChildWarningLight> warningLights;

  SubPart({
    required this.name,
    required this.icon,
    required this.description,
    required this.imageView,
    required this.pdfFilesCollection,
    required this.videosCollection,
    required this.faults,
    required this.problems,
    required this.warningLights,
  });

  factory SubPart.fromJson(Map<String, dynamic> json) {
    return SubPart(
      name: json['name'],
      icon: json['icon'] != null ? IDPIcon.fromJson(json['icon']) : null,
      description: json['description']?['json'],
      imageView: json['imageView'] != null
          ? IDPPartImageView.fromJson(json['imageView'])
          : null,
      pdfFilesCollection: json['pdfFilesCollection'] == null
          ? null
          : PdfFilesCollection.fromJson(json['pdfFilesCollection']),
      videosCollection: json['videosCollection'] == null
          ? null
          : VideosCollection.fromJson(json['videosCollection']),
      faults: json['faultsCollection']?['items'] == null
          ? []
          : json['faultsCollection']?['items']
                  ?.map<ChildFault>((e) => ChildFault.fromJson(e))
                  .toList() ??
              [],
      problems: json['problemCasesCollection']?['items']
              .map<ChildProblem>((e) => ChildProblem.fromJson(e))
              .toList() ??
          [],
      warningLights: json['warningLightsCollection']?['items']
              .map<ChildWarningLight>((e) => ChildWarningLight.fromJson(e))
              .toList() ??
          [],
    );
  }
}
