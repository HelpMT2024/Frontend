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

  Component({
    required this.name,
    required this.icon,
    required this.imageView,
    required this.children,
    required this.faults,
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
      faults: json['faultCodesCollection']?['items']
              .map<ChildFault>((e) => ChildFault.fromJson(e))
              .toList() ??
          [],
    );
  }
}
