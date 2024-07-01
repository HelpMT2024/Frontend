import 'dart:async';

import 'package:flutter/material.dart';
import 'package:help_my_truck/data/models/child_type.dart';
import 'package:help_my_truck/data/models/favorite_model_type.dart';
import 'package:help_my_truck/data/models/system.dart';
import 'package:help_my_truck/data/models/unit.dart';
import 'package:help_my_truck/extensions/widget_error.dart';
import 'package:help_my_truck/services/API/item_provider.dart';
import 'package:help_my_truck/services/API/vehicle_provider.dart';
import 'package:help_my_truck/services/router/faults_router.dart';
import 'package:help_my_truck/services/router/vehicle_selector_router.dart';
import 'package:help_my_truck/ui/vehicle_observer_flow/vehicle_navigation_helper.dart';
import 'package:help_my_truck/ui/widgets/nav_bar/nav_bar_page.dart';
import 'package:rxdart/rxdart.dart';
import 'package:collection/collection.dart';

class DriverCabinViewModel with ErrorHandable {
  final VehicleProvider provider;
  final ItemProvider itemProvider;
  final FavoriteModelSubType itemType = FavoriteModelSubType.driverDisplay;
  final ChildrenSystem config;

  var itemStreamController = StreamController<ContentfulItem>();

  ChildrenComponent? get warningLightComponent =>
      system.valueOrNull?.children.firstWhereOrNull(
        (element) => element.type == ChildType.warningLight,
      );

  ChildrenComponent? get searchComponent =>
      system.valueOrNull?.children.firstWhereOrNull(
        (element) => element.type == ChildType.search,
      );

  ChildrenComponent? get defaultComponent =>
      system.valueOrNull?.children.firstWhereOrNull(
        (element) => element.type == ChildType.standart,
      );

  late final system = BehaviorSubject<System>()
    ..addStream(
      Stream.fromFuture(
        provider.system(config.id).catchError((error) {
          showAlertDialog(null, error);
        }),
      ),
    );

  DriverCabinViewModel({
    required this.config,
    required this.provider,
    required this.itemProvider,
  }) {
    item();
  }

  item() {
    itemProvider
        .processItem(config.id, itemType.filterKey())
        .then((item) => itemStreamController.add(item));
  }

  void onModelSelected(String id, BuildContext context) {
    final model = system.value.children.firstWhere(
      (element) => element.id == id,
    );

    if (model.type == ChildType.warningLight) {
      Navigator.of(context)
          .pushNamed(
            FaultsRouteKeys.warningScreen,
            arguments: model,
          )
          .then((value) => item());
    } else if (model.type == ChildType.search) {
      VehicleNavigationHelper.navigateTo(NavBarPage.search, context, true);
    } else {
      final name = model.isSystem
          ? VehicleSelectorRouteKeys.systemObserver
          : VehicleSelectorRouteKeys.componentObserver;

      final child = !model.isSystem
          ? model
          : ChildrenSystem(
              id: id,
              name: model.name,
              image: model.image,
              types: [],
            );

      Navigator.of(context)
          .pushNamed(name, arguments: child)
          .then((value) => item());
    }
  }
}
