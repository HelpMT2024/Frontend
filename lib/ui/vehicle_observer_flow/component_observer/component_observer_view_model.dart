import 'package:flutter/material.dart';
import 'package:help_my_truck/data/models/component.dart';
import 'package:help_my_truck/data/models/fault.dart';
import 'package:help_my_truck/data/models/system.dart';
import 'package:help_my_truck/services/API/vehicle_provider.dart';
import 'package:help_my_truck/services/router/vehicle_selector_router.dart';
import 'package:help_my_truck/ui/vehicle_observer_flow/vehicle_navigation_helper.dart';
import 'package:help_my_truck/ui/widgets/nav_bar/nav_bar_page.dart';
import 'package:rxdart/subjects.dart';

class ComponentObserverViewModel {
  final VehicleProvider provider;
  final ChildrenComponent config;

  late final system = BehaviorSubject<Component>()
    ..addStream(
      Stream.fromFuture(provider.component(config.id)),
    );

  List<ChildFault> get faults => system.valueOrNull?.faults ?? [];
  bool get hasFaults => faults.isNotEmpty;

  ComponentObserverViewModel({required this.config, required this.provider});

  void onSearch(BuildContext context) {
    VehicleNavigationHelper.navigateTo(NavBarPage.search, context, true);
  }

  void onModelSelected(String id, BuildContext context) {
    final model = system.value.children.firstWhere(
      (element) => element.id == id,
    );

    Navigator.of(context).pushNamed(
      VehicleSelectorRouteKeys.partObserver,
      arguments: model,
    );
  }
}
