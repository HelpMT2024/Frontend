import 'package:help_my_truck/data/models/child_problem.dart';
import 'package:help_my_truck/data/models/contentfull_entnities.dart';
import 'package:help_my_truck/data/models/fault.dart';

class ChildSubpart {
  final String id;
  final String name;
  final IDPIcon? image;

  ChildSubpart({
    required this.id,
    required this.name,
    required this.image,
  });

  factory ChildSubpart.fromJson(Map<String, dynamic> json) {
    return ChildSubpart(
      id: json['sys']['id'],
      name: json['name'],
      image: json['icon'] != null ? IDPIcon.fromJson(json['icon']) : null,
    );
  }
}

class Part {
  final String name;
  final IDPIcon? icon;
  final List<ChildFault> faults;
  final Map<String, dynamic>? description;
  final IDPImageView? imageView;
  final PdfFilesCollection pdfFilesCollection;
  final VideosCollection videosCollection;
  final List<ChildProblem> problems;
  final List<ChildWarningLight> warningLights;
  final List<ChildSubpart> subparts;

  Part({
    required this.name,
    required this.icon,
    required this.description,
    required this.imageView,
    required this.pdfFilesCollection,
    required this.videosCollection,
    required this.faults,
    required this.problems,
    required this.warningLights,
    required this.subparts,
  });

  factory Part.fromJson(Map<String, dynamic> json) {
    return Part(
      name: json['name'],
      icon: json['icon'] != null ? IDPIcon.fromJson(json['icon']) : null,
      description: json['description']?['json'],
      imageView: json['imageView'] != null
          ? IDPImageView.fromJson(json['imageView'])
          : null,
      pdfFilesCollection:
          PdfFilesCollection.fromJson(json['pdfFilesCollection']),
      videosCollection: VideosCollection.fromJson(json['videosCollection']),
      faults: json['faultCodesCollection']?['items']
              .map<ChildFault>((e) => ChildFault.fromJson(e))
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
      subparts: json['childrenCollection']?['items']
              ?.map<ChildSubpart>((e) => ChildSubpart.fromJson(e))
              .toList() ??
          [],
    );
  }
}
