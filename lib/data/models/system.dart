import 'package:help_my_truck/data/models/child_problem.dart';
import 'package:help_my_truck/data/models/child_type.dart';
import 'package:help_my_truck/data/models/contentfull_entnities.dart';

class ChildrenComponent {
  final String id;
  final String name;
  final IDPIcon? image;
  final ChildType type;

  ChildrenComponent({
    required this.id,
    required this.name,
    required this.image,
    required this.type,
  });

  factory ChildrenComponent.fromJson(Map<String, dynamic> json) {
    return ChildrenComponent(
      id: json['sys']['id'],
      name: json['name'],
      image: json['icon'] != null ? IDPIcon.fromJson(json['icon']) : null,
      type: childTypeFromJson(json['type']),
    );
  }
}

class System {
  final String id;
  final String name;
  final IDPImage icon;
  final IDPImageView? imageView;
  final List<ChildrenComponent> children;
  final List<ChildProblem> problems;
  final List<IDPVideo>? videos;

  System({
    required this.id,
    required this.name,
    required this.icon,
    required this.imageView,
    required this.children,
    required this.problems,
    required this.videos,
  });

  factory System.fromJson(Map<String, dynamic> json) {
    final List<dynamic> children = json['childrenCollection']['items'];

    return System(
      id: json['sys']['id'],
      name: json['name'],
      icon: IDPImage.fromJson(json['icon']),
      imageView: json['imageView'] != null
          ? IDPImageView.fromJson(json['imageView'])
          : null,
      children:
          children.map((child) => ChildrenComponent.fromJson(child)).toList(),
      problems: json['problemCasesCollection']['items']
              .map<ChildProblem>((e) => ChildProblem.fromJson(e))
              .toList() ??
          [],
      videos: json['videosCollection']?['items']
              .map<IDPVideo>((e) => IDPVideo.fromJson(e))
              .toList() ??
          [],
    );
  }
}
