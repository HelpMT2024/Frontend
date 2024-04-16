import 'package:help_my_truck/data/models/component.dart';
import 'package:help_my_truck/data/models/contentfull_entnities.dart';
import 'package:help_my_truck/data/models/part.dart';
import 'package:help_my_truck/services/API/vehicle_provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:url_launcher/url_launcher_string.dart';

class PartViewModel {
  final VehicleProvider provider;
  final ChildrenPart config;

  late final part = BehaviorSubject<Part>()
    ..addStream(Stream.fromFuture(provider.part(config.id)));

  int currentTruckIndex = 0;

  PartViewModel({
    required this.provider,
    required this.config,
  });

  void openPdf(PdfFile file) {
    if (file.url == null) return;
    launchUrlString(file.url!);
  }

  void openVideo(IDPVideo video) {
    launchUrlString(video.url);
  }
}
