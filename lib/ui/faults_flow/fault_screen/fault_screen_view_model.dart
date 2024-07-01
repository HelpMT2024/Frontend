import 'dart:async';

import 'package:help_my_truck/data/models/fault.dart';
import 'package:help_my_truck/data/models/favorite_model_type.dart';
import 'package:help_my_truck/extensions/widget_error.dart';
import 'package:help_my_truck/services/API/item_provider.dart';
import 'package:help_my_truck/services/API/vehicle_provider.dart';
import 'package:rxdart/rxdart.dart';

class FaultScreenViewModel with ErrorHandable {
  final VehicleProvider provider;
  final ItemProvider itemProvider;
  final FavoriteModelType itemType = FavoriteModelType.faultCode;
  final ChildFault config;

  var itemStreamController = StreamController<ContentfulItem>();

  late final fault = BehaviorSubject<Fault>()
    ..addStream(Stream.fromFuture(
      provider.fault(config.id).catchError((error) {
        showAlertDialog(null, error);
      }),
    ));

  bool get hasPDF =>
      fault.valueOrNull?.pdfFilesCollection.items.isNotEmpty ?? false;
  bool get hasVideos =>
      fault.valueOrNull?.videosCollection.items.isNotEmpty ?? false;

  FaultScreenViewModel({
    required this.provider,
    required this.config,
    required this.itemProvider,
  }) {
    item();
  }

  item() {
    itemProvider
        .processItem(config.id, itemType.filterKey())
        .then((item) => itemStreamController.add(item));
  }
}
