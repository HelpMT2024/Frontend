import 'package:flutter/material.dart';
import 'package:help_my_truck/data/models/child_type.dart';
import 'package:help_my_truck/data/models/system.dart';
import 'package:help_my_truck/data/models/unit.dart';
import 'package:help_my_truck/services/API/item_provider.dart';
import 'package:help_my_truck/services/API/vehicle_provider.dart';
import 'package:help_my_truck/services/router/faults_router.dart';
import 'package:help_my_truck/ui/vehicle_observer_flow/vehicle_navigation_helper.dart';
import 'package:help_my_truck/ui/widgets/nav_bar/nav_bar_page.dart';
import 'package:rxdart/rxdart.dart';
import 'package:collection/collection.dart';

class DriverCabinViewModel {
  final VehicleProvider provider;
  final ItemProvider itemProvider;
  final ChildrenSystem config;

  ChildrenComponent? get warningLightComponent =>
      system.valueOrNull?.children.firstWhereOrNull(
        (element) => element.type == ChildType.warningLight,
      );

  ChildrenComponent? get searchComponent =>
      system.valueOrNull?.children.firstWhereOrNull(
        (element) => element.type == ChildType.search,
      );

  late final system = BehaviorSubject<System>()
    ..addStream(
      Stream.fromFuture(provider.system(config.id)),
    );

  DriverCabinViewModel({
    required this.config,
    required this.provider,
    required this.itemProvider,
  });

  void onModelSelected(String id, BuildContext context) {
    final model = system.value.children.firstWhere(
      (element) => element.id == id,
    );

    if (model.type == ChildType.warningLight) {
      Navigator.of(context).pushNamed(
        FaultsRouteKeys.warningScreen,
        arguments: model,
      );
    } else {
      VehicleNavigationHelper.navigateTo(NavBarPage.search, context, true);
    }
  }
}
