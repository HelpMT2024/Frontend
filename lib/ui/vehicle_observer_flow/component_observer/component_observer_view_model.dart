import 'package:flutter/material.dart';
import 'package:help_my_truck/data/models/component.dart';
import 'package:help_my_truck/data/models/system.dart';
import 'package:help_my_truck/services/API/vehicle_provider.dart';
import 'package:rxdart/subjects.dart';

class ComponentObserverViewModel {
  final VehicleProvider provider;
  final ChildrenComponent config;

  late final system = BehaviorSubject<Component>()
    ..addStream(
      Stream.fromFuture(provider.component(config.id)),
    );

  ComponentObserverViewModel({required this.config, required this.provider});

  void onModelSelected(String id, BuildContext context) {}
}
