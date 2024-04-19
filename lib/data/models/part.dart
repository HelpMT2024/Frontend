import 'package:help_my_truck/data/models/contentfull_entnities.dart';
import 'package:help_my_truck/data/models/fault.dart';

class Part {
  final String internalName;
  final String name;
  final IDPIcon? icon;
  final List<ChildFault> faults;
  final Map<String, dynamic>? description;
  final IDPImageView? imageView;
  final PdfFilesCollection pdfFilesCollection;
  final VideosCollection videosCollection;

  Part({
    required this.internalName,
    required this.name,
    required this.icon,
    required this.description,
    required this.imageView,
    required this.pdfFilesCollection,
    required this.videosCollection,
    required this.faults,
  });

  factory Part.fromJson(Map<String, dynamic> json) {
    return Part(
      internalName: json['internalName'],
      name: json['name'],
      icon: json['icon'] != null ? IDPIcon.fromJson(json['icon']) : null,
      description: json['description']['json'],
      imageView: json['imageView'] != null
          ? IDPImageView.fromJson(json['imageView'])
          : null,
      pdfFilesCollection:
          PdfFilesCollection.fromJson(json['pdfFilesCollection']),
      videosCollection: VideosCollection.fromJson(json['videosCollection']),
      faults: json['faultCodesCollection']?['items']
              .map<ChildFault>((e) => ChildFault.fromJson(e))
              .toList() ??
          [],
    );
  }
}
