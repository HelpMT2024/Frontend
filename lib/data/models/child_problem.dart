import 'package:help_my_truck/data/models/contentfull_entnities.dart';

class ChildWarningLight {
  final String name;
  final IDPIcon? icon;

  ChildWarningLight({
    required this.name,
    required this.icon,
  });

  factory ChildWarningLight.fromJson(Map<String, dynamic> json) {
    return ChildWarningLight(
      name: json['name'],
      icon: json['icon'] != null ? IDPIcon.fromJson(json['icon']) : null,
    );
  }
}

class ChildProblem {
  final String id;
  final String name;

  ChildProblem({
    required this.id,
    required this.name,
  });

  factory ChildProblem.fromJson(Map<String, dynamic> json) {
    return ChildProblem(
      id: json['sys']['id'],
      name: json['name'],
    );
  }
}
