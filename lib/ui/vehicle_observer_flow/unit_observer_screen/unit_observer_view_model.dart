import 'package:flutter/material.dart';
import 'package:help_my_truck/data/models/child_problem.dart';
import 'package:help_my_truck/data/models/configuration.dart';
import 'package:help_my_truck/data/models/contentfull_entnities.dart';
import 'package:help_my_truck/data/models/favorite_model_type.dart';
import 'package:help_my_truck/data/models/unit.dart';
import 'package:help_my_truck/services/API/item_provider.dart';
import 'package:help_my_truck/services/API/vehicle_provider.dart';
import 'package:help_my_truck/services/router/vehicle_selector_router.dart';
import 'package:rxdart/rxdart.dart';

class UnitObserverViewModel {
  final VehicleProvider provider;
  final ItemProvider itemProvider;
  final FavoriteModelType itemType = FavoriteModelType.unit;
  final ChildrenUnit config;

  late final unit = BehaviorSubject<Unit>()
    ..addStream(
      Stream.fromFuture(provider.unit(config.id)),
    );

  List<ChildProblem> get problems => unit.valueOrNull?.problems ?? [];
  bool get hasProblems => problems.isNotEmpty;

  List<PdfFile> get pdfFiles =>
      unit.valueOrNull?.pdfFilesCollection.items ?? [];
  bool get hasPDF => pdfFiles.isNotEmpty;

  List<IDPVideo> get videos => unit.valueOrNull?.videos ?? [];
  bool get hasVideos => videos.isNotEmpty;

  bool get hasDescription => unit.valueOrNull?.description != null;

  UnitObserverViewModel({
    required this.config,
    required this.provider,
    required this.itemProvider,
  });

  void onModelSelected(String id, BuildContext context) {
    final model = unit.value.children.firstWhere((element) => element.id == id);
    if (model.isDriverDisplay) {
      Navigator.of(context).pushNamed(
        VehicleSelectorRouteKeys.driverCabin,
        arguments: model,
      );
    } else {
      Navigator.of(context).pushNamed(
        VehicleSelectorRouteKeys.systemObserver,
        arguments: model,
      );
    }
  }
}
