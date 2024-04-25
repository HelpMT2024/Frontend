import 'package:help_my_truck/data/models/contentfull_entnities.dart';
import 'package:help_my_truck/data/models/fault.dart';

class Warning {
  final String id;
  final String name;
  final IDPIcon? icon;
  final List<SearchFaultDetail> linkedFrom;

  Warning({
    required this.id,
    required this.name,
    required this.icon,
    required this.linkedFrom,
  });

  factory Warning.fromJson(Map<String, dynamic> json) {
    return Warning(
      id: json['sys']['id'],
      name: json['name'],
      icon: json['icon'] != null ? IDPIcon.fromJson(json['icon']) : null,
      linkedFrom: json['linkedFrom']['entryCollection']['items']
          .map<SearchFaultDetail>((e) => SearchFaultDetail.fromJson(e))
          .toList(),
    );
  }
}
