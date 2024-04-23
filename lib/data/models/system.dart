import 'package:help_my_truck/data/models/child_problem.dart';
import 'package:help_my_truck/data/models/contentfull_entnities.dart';

enum ChildrenSystemType {
  standart,
  warningLight,
  search;
}

class ChildrenComponent {
  final String id;
  final String name;
  final IDPIcon? image;
  final ChildrenSystemType type;

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
      type: ChildrenSystemType.standart,
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

  System({
    required this.id,
    required this.name,
    required this.icon,
    required this.imageView,
    required this.children,
    required this.problems,
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
    );
  }
}
