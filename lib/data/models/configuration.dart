import 'package:help_my_truck/data/models/contentfull_entnities.dart';

class ChildrenUnit {
  final String id;
  final String name;
  final IDPIcon? image;

  ChildrenUnit({
    required this.id,
    required this.name,
    required this.image,
  });

  factory ChildrenUnit.fromJson(Map<String, dynamic> json) {
    return ChildrenUnit(
      id: json['sys']['id'],
      name: json['name'],
      image: json['icon'] != null ? IDPIcon.fromJson(json['icon']) : null,
    );
  }
}

class Configuration {
  final String name;
  final IDPImageView imageView;
  final List<ChildrenUnit> children;

  Configuration({
    required this.name,
    required this.imageView,
    required this.children,
  });

  factory Configuration.fromJson(Map<String, dynamic> json) {
    final List<dynamic> children = json['childrenCollection']['items'];

    return Configuration(
      name: json['name'],
      imageView: IDPImageView.fromJson(json['imageView']),
      children: children.map((child) => ChildrenUnit.fromJson(child)).toList(),
    );
  }
}
