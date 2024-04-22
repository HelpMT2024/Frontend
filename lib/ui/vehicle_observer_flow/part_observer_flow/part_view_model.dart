import 'package:help_my_truck/data/models/component.dart';
import 'package:help_my_truck/data/models/contentfull_entnities.dart';
import 'package:help_my_truck/data/models/fault.dart';
import 'package:help_my_truck/data/models/part.dart';
import 'package:help_my_truck/services/API/vehicle_provider.dart';
import 'package:rxdart/rxdart.dart';

class PartViewModel {
  final VehicleProvider provider;
  final ChildrenPart config;

  late final part = BehaviorSubject<Part>()
    ..addStream(Stream.fromFuture(provider.part(config.id)));

  bool get hasImage => part.valueOrNull?.imageView != null;
  bool get hasPDF =>
      part.valueOrNull?.pdfFilesCollection.items.isNotEmpty ?? false;
  bool get hasVideos =>
      part.valueOrNull?.videosCollection.items.isNotEmpty ?? false;
  bool get hasFaults => part.valueOrNull?.faults.isNotEmpty ?? false;

  List<IDPVideo> get videos => part.valueOrNull?.videosCollection.items ?? [];
  List<ChildFault> get faults => part.value.faults;

  int currentTruckIndex = 0;

  PartViewModel({
    required this.provider,
    required this.config,
  });
}
