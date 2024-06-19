import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:help_my_truck/const/app_consts.dart';
import 'package:help_my_truck/data/models/child_type.dart';
import 'package:help_my_truck/data/models/configuration.dart';
import 'package:help_my_truck/data/models/unit.dart';
import 'package:help_my_truck/services/API/vehicle_provider.dart';
import 'package:help_my_truck/services/purchase_service.dart';
import 'package:help_my_truck/services/router/vehicle_selector_router.dart';
import 'package:help_my_truck/ui/main_flow/home_page.dart';
import 'package:help_my_truck/ui/vehicle_observer_flow/vehicle_navigation_helper.dart';
import 'package:purchases_ui_flutter/purchases_ui_flutter.dart';
import 'package:rxdart/rxdart.dart';

class ConfigurationObserverViewModel {
  late final VehicleProvider provider;
  final MainPageConfig config;

  late final configuration = BehaviorSubject<Configuration>()
    ..addStream(
      Stream.fromFuture(
        provider.configuration(config.engine, config.truck),
      ),
    );

  ConfigurationObserverViewModel({
    required this.config,
  }) {
    provider = VehicleProvider(
      config.graphQLNetworkService,
      config.restAPINetworkService,
    );
  }

  void onModelSelected(String id, BuildContext context) async {
    final model =
        configuration.value.children.firstWhere((element) => element.id == id);
    VehicleNavigationHelper.processAfterPayment(
        () => _navigateToChild(context, model), context);
  }

  void _navigateToChild(BuildContext context, ConfigurationChild model) {
    switch (model.type) {
      case ConfigurationChildType.unit:
        final unit = ChildrenUnit(
          id: model.id,
          name: model.name,
          image: model.image,
        );

        Navigator.of(context).pushNamed(
          VehicleSelectorRouteKeys.unitObserver,
          arguments: unit,
        );
      case ConfigurationChildType.system:
        final system = ChildrenSystem(
            id: model.id,
            name: model.name,
            image: model.image,
            types: [ChildType.standart]);

        Navigator.of(context).pushNamed(
          VehicleSelectorRouteKeys.systemObserver,
          arguments: system,
        );
    }
  }
}
