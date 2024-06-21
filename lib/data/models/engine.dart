import 'package:help_my_truck/data/models/contentfull_entnities.dart';

class Engine {
  final String id;
  final String name;
  final bool comingSoon;
  final IDPImage image;

  Engine({
    required this.id,
    required this.name,
    required this.comingSoon,
    required this.image,
  });

  factory Engine.fromJson(Map<String, dynamic> json) {
    return Engine(
      id: json['sys']['id'],
      name: json['name'],
      comingSoon: json['comingSoon'],
      image: IDPImage.fromJson(json['image']),
    );
  }
}
