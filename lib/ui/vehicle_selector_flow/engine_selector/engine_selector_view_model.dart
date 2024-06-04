import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:help_my_truck/data/models/engine.dart';
import 'package:help_my_truck/data/models/truck.dart';
import 'package:help_my_truck/services/API/vehicle_provider.dart';
import 'package:help_my_truck/services/router/home_router.dart';
import 'package:help_my_truck/ui/main_flow/home_page.dart';
import 'package:rxdart/rxdart.dart';

class EngineSelectorViewModel {
  final Truck truck;
  late final engines = BehaviorSubject<List<Engine>>()
    ..addStream(Stream.fromFuture(provider.engines()));

  int currentEngineIndex = 0;

  final VehicleProvider provider;

  EngineSelectorViewModel({
    required this.provider,
    required this.truck,
  });

  void selectEngine(BuildContext context) {
    final engine = engines.value.elementAt(currentEngineIndex);
    final config = MainPageConfig(
      engine: engine,
      truck: truck,
      graphQLNetworkService: provider.graphQLService,
      restAPINetworkService: provider.restAPIService,
    );

    Navigator.of(context).pushNamedAndRemoveUntil(
      HomeRouteKeys.home,
      (route) => false,
      arguments: config,
    );
  }
}
