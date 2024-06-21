import 'package:help_my_truck/data/models/contentfull_entnities.dart';

class Truck {
  final String id;
  final String name;
  final bool comingSoon;
  final IDPImage image;

  Truck({
    required this.id,
    required this.name,
    required this.comingSoon,
    required this.image,
  });

  factory Truck.fromJson(Map<String, dynamic> json) {
    return Truck(
      id: json['sys']['id'],
      name: json['name'],
      comingSoon: json['comingSoon'],
      image: IDPImage.fromJson(json['image']),
    );
  }
}
