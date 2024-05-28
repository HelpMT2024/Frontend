import 'package:help_my_truck/data/models/contentfull_entnities.dart';

enum ConfigurationChildType {
  unit,
  system,
}

class ConfigurationChild {
  final String id;
  final String name;
  final IDPIcon? image;
  final ConfigurationChildType type;

  ConfigurationChild({
    required this.id,
    required this.name,
    required this.image,
    required this.type,
  });

  factory ConfigurationChild.fromJson(Map<String, dynamic> json) {
    return ConfigurationChild(
      id: json['sys']['id'],
      name: json['name'],
      image: json['icon'] != null ? IDPIcon.fromJson(json['icon']) : null,
      type: json['__typename'] == 'Unit'
          ? ConfigurationChildType.unit
          : ConfigurationChildType.system,
    );
  }
}

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
  final List<ConfigurationChild> children;

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
      children:
          children.map((child) => ConfigurationChild.fromJson(child)).toList(),
    );
  }
}

class ChildrenCollection {
  List<ConfigurationChild> items;

  ChildrenCollection({
    required this.items,
  });

  factory ChildrenCollection.fromJson(Map<String, dynamic> json) =>
      ChildrenCollection(
        items: List<ConfigurationChild>.from(
            json["items"].map((x) => ConfigurationChild.fromJson(x))),
      );
}
