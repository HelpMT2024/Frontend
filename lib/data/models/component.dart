import 'package:help_my_truck/data/models/child_problem.dart';
import 'package:help_my_truck/data/models/contentfull_entnities.dart';
import 'package:help_my_truck/data/models/fault.dart';

class ChildrenPart {
  final String id;
  final String name;
  final IDPIcon? image;

  ChildrenPart({
    required this.id,
    required this.name,
    required this.image,
  });

  factory ChildrenPart.fromJson(Map<String, dynamic> json) {
    return ChildrenPart(
      id: json['sys']['id'],
      name: json['name'],
      image: json['icon'] != null ? IDPIcon.fromJson(json['icon']) : null,
    );
  }
}

class Component {
  final String name;
  final IDPImage? icon;
  final IDPImageView? imageView;
  final List<ChildrenPart> children;
  final List<ChildFault> faults;
  final List<IDPVideo> videos;
  final List<ChildProblem> problems;
  final List<ChildWarningLight> warningLights;

  Component({
    required this.name,
    required this.icon,
    required this.imageView,
    required this.children,
    required this.faults,
    required this.videos,
    required this.problems,
    required this.warningLights,
  });

  factory Component.fromJson(Map<String, dynamic> json) {
    return Component(
      name: json['name'],
      icon: json['icon'] != null ? IDPImage.fromJson(json['icon']) : null,
      imageView: json['imageView'] != null
          ? IDPImageView.fromJson(json['imageView'])
          : null,
      children: List<ChildrenPart>.from(
        json['childrenCollection']['items'].map(
          (childrenCollection) => ChildrenPart.fromJson(childrenCollection),
        ),
      ),
      videos: json['videosCollection']?['items']
              .map<IDPVideo>((e) => IDPVideo.fromJson(e))
              .toList() ??
          [],
      faults: json['faultCodesCollection']?['items']
              .map<ChildFault>((e) => ChildFault.fromJson(e))
              .toList() ??
          [],
      problems: json['problemCasesCollection']['items']
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
