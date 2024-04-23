// ignore_for_file: constant_identifier_names
// ignore: depend_on_referenced_packages
import 'package:help_my_truck/data/models/child_problem.dart';
import 'package:help_my_truck/data/models/contentfull_entnities.dart';

class ChildrenSystem {
  final String id;
  final String name;
  final IDPIcon image;
  final List<ChildrenSystemType> types;

  bool get isDriverDisplay =>
      types.contains(ChildrenSystemType.search) &&
      types.contains(ChildrenSystemType.warningLight);

  ChildrenSystem({
    required this.id,
    required this.name,
    required this.image,
    required this.types,
  });

  factory ChildrenSystem.fromJson(Map<String, dynamic> json) {
    return ChildrenSystem(
      id: json['sys']['id'],
      name: json['name'],
      image: IDPIcon.fromJson(json['icon']),
      types: json['childrenCollection']['items'].map<ChildrenSystemType>((e) {
        switch (e['type']) {
          case 'WarningLight':
            return ChildrenSystemType.warningLight;
          case 'Search':
            return ChildrenSystemType.search;
          default:
            return ChildrenSystemType.standart;
        }
      }).toList(),
    );
  }
}

class Unit {
  final String name;
  final IDPImage? icon;
  final IDPImageView? imageView;
  final List<ChildrenSystem> children;
  final List<ChildProblem> problems;

  Unit({
    required this.name,
    required this.icon,
    required this.imageView,
    required this.children,
    required this.problems,
  });

  factory Unit.fromJson(Map<String, dynamic> json) {
    return Unit(
      name: json['name'],
      icon: json['icon'] != null ? IDPImage.fromJson(json['icon']) : null,
      imageView: json['imageView'] != null
          ? IDPImageView.fromJson(json['imageView'])
          : null,
      children: List<ChildrenSystem>.from(
        json['childrenCollection']['items'].map(
          (childrenCollection) => ChildrenSystem.fromJson(childrenCollection),
        ),
      ),
      problems: json['problemCasesCollection']['items']
              .map<ChildProblem>((e) => ChildProblem.fromJson(e))
              .toList() ??
          [],
    );
  }
}
