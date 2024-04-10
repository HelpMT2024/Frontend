import 'package:flutter/material.dart';
import 'package:help_my_truck/data/models/configuration.dart';
import 'package:help_my_truck/data/models/unit.dart';
import 'package:help_my_truck/services/API/vehicle_provider.dart';
import 'package:help_my_truck/services/router/vehicle_selector_router.dart';
import 'package:rxdart/rxdart.dart';

class UnitObserverViewModel {
  final VehicleProvider provider;
  final ChildrenUnit config;

  late final unit = BehaviorSubject<Unit>()
    ..addStream(
      Stream.fromFuture(provider.unit(config.id)),
    );

  UnitObserverViewModel({required this.config, required this.provider});

  void onModelSelected(String id, BuildContext context) {
    final model = unit.value.children.firstWhere((element) => element.id == id);

    Navigator.of(context).pushNamed(
      VehicleSelectorRouteKeys.systemObserver,
      arguments: model,
    );
  }
}
