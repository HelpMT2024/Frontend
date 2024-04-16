import 'package:help_my_truck/data/models/contentfull_entnities.dart';

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

  Component({
    required this.name,
    required this.icon,
    required this.imageView,
    required this.children,
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
    );
  }
}
