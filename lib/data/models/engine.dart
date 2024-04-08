import 'package:help_my_truck/data/models/system.dart';

class Engine {
  final String id;
  final String name;
  final IDPImage image;

  Engine({
    required this.id,
    required this.name,
    required this.image,
  });

  factory Engine.fromJson(Map<String, dynamic> json) {
    return Engine(
      id: json['sys']['id'],
      name: json['name'],
      image: IDPImage.fromJson(json['image']),
    );
  }
}
