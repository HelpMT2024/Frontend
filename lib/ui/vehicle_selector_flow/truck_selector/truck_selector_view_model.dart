import 'package:flutter/material.dart';
import 'package:help_my_truck/data/models/truck.dart';
import 'package:help_my_truck/services/API/vehicle_provider.dart';
import 'package:help_my_truck/services/router/vehicle_selector_router.dart';
import 'package:rxdart/rxdart.dart';

class TruckSelectorViewModel {
  final VehicleProvider provider;

  late final trucks = BehaviorSubject<List<Truck>>()
    ..addStream(Stream.fromFuture(provider.trucks()));

  int currentTruckIndex = 0;

  TruckSelectorViewModel({
    required this.provider,
  });

  void selectTruck(BuildContext context) {
    final truck = trucks.value.elementAt(currentTruckIndex);

    Navigator.of(context).pushNamed(
      VehicleSelectorRouteKeys.engineSelector,
      arguments: truck,
    );
  }
}
