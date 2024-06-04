// ignore_for_file: body_might_complete_normally_nullable, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:help_my_truck/data/models/component.dart';
import 'package:help_my_truck/data/models/configuration.dart';
import 'package:help_my_truck/data/models/part.dart';
import 'package:help_my_truck/data/models/system.dart';
import 'package:help_my_truck/data/models/truck.dart';
import 'package:help_my_truck/data/models/unit.dart';
import 'package:help_my_truck/services/API/favorites_provider.dart';
import 'package:help_my_truck/services/API/graph_ql_network_service.dart';
import 'package:help_my_truck/services/API/rest_api_network_service.dart';
import 'package:help_my_truck/services/API/vehicle_provider.dart';
import 'package:help_my_truck/ui/vehicle_observer_flow/driver_cabin/driver_cabin_screen.dart';
import 'package:help_my_truck/ui/vehicle_observer_flow/driver_cabin/driver_cabin_view_model.dart';
import 'package:help_my_truck/ui/vehicle_observer_flow/part_observer_flow/part_screen.dart';
import 'package:help_my_truck/ui/vehicle_observer_flow/part_observer_flow/part_view_model.dart';
import 'package:help_my_truck/ui/vehicle_observer_flow/component_observer/component_observer_screen.dart';
import 'package:help_my_truck/ui/vehicle_observer_flow/component_observer/component_observer_view_model.dart';
import 'package:help_my_truck/ui/vehicle_observer_flow/subpart_observer/subpart_screen.dart';
import 'package:help_my_truck/ui/vehicle_observer_flow/subpart_observer/subpart_view_model.dart';
import 'package:help_my_truck/ui/vehicle_observer_flow/system_observer_screen/system_observer_screen.dart';
import 'package:help_my_truck/ui/vehicle_observer_flow/system_observer_screen/system_observer_view_model.dart';
import 'package:help_my_truck/ui/vehicle_observer_flow/unit_observer_screen/unit_observer_screen.dart';
import 'package:help_my_truck/ui/vehicle_observer_flow/unit_observer_screen/unit_observer_view_model.dart';
import 'package:help_my_truck/ui/vehicle_selector_flow/engine_selector/engine_selector_screen.dart';
import 'package:help_my_truck/ui/vehicle_selector_flow/engine_selector/engine_selector_view_model.dart';
import 'package:help_my_truck/ui/vehicle_selector_flow/truck_selector/truck_selector_screen.dart';
import 'package:help_my_truck/ui/vehicle_selector_flow/truck_selector/truck_selector_view_model.dart';
import 'package:native_page_route/native_page_route.dart';

abstract class VehicleSelectorRouteKeys {
  static const String driverCabin = 'driverCabin';
  static const String componentObserver = 'componentObserver';
  static const String systemObserver = 'systemObserver';
  static const String unitObserver = 'unitObserver';
  static const String partObserver = 'partObserver';
  static const String subPartObserver = 'subPartObserver';
  static const String truckSelector = 'truckSelector';
  static const String engineSelector = 'engineSelector';
}

Route<dynamic>? VehicleSelectorRouter(
  RouteSettings setting,
  RestAPINetworkService restAPINetworkService,
  GraphQLNetworkService graphQLNetworkService,
) {
  switch (setting.name) {
    case VehicleSelectorRouteKeys.subPartObserver:
      return nativePageRoute(
        settings: setting,
        builder: (context) {
          final provider = VehicleProvider(graphQLNetworkService);
          final favoritesProvider = FavoritesProvider(restAPINetworkService, graphQLNetworkService);
          final viewModel = SubPartViewModel(
            provider: provider,
            favoritesProvider: favoritesProvider,
            config: setting.arguments as ChildSubpart,
          );

          return SubPartScreen(viewModel: viewModel);
        },
      );
    case VehicleSelectorRouteKeys.driverCabin:
      return nativePageRoute(
        settings: setting,
        builder: (context) {
          final provider = VehicleProvider(graphQLNetworkService);
          final favoritesProvider = FavoritesProvider(restAPINetworkService, graphQLNetworkService);
          final viewModel = DriverCabinViewModel(
            provider: provider,
            favoritesProvider: favoritesProvider,
            config: setting.arguments as ChildrenSystem,
          );

          return DriverCabinScreen(viewModel: viewModel);
        },
      );
    case VehicleSelectorRouteKeys.componentObserver:
      return nativePageRoute(
        settings: setting,
        builder: (context) {
          final provider = VehicleProvider(graphQLNetworkService);
          final favoritesProvider = FavoritesProvider(restAPINetworkService, graphQLNetworkService);
          final viewModel = ComponentObserverViewModel(
            provider: provider,
            favoritesProvider: favoritesProvider,
            config: setting.arguments as ChildrenComponent,
          );

          return ComponentObserverScreen(viewModel: viewModel);
        },
      );
    case VehicleSelectorRouteKeys.systemObserver:
      return nativePageRoute(
        settings: setting,
        builder: (context) {
          final provider = VehicleProvider(graphQLNetworkService);
          final favoritesProvider = FavoritesProvider(restAPINetworkService, graphQLNetworkService);
          final viewModel = SystemObserverViewModel(
            provider: provider,
            favoritesProvider: favoritesProvider,
            config: setting.arguments as ChildrenSystem,
          );

          return SystemObserverScreen(viewModel: viewModel);
        },
      );

    case VehicleSelectorRouteKeys.unitObserver:
      return nativePageRoute(
        settings: setting,
        builder: (context) {
          final provider = VehicleProvider(graphQLNetworkService);
          final favoritesProvider = FavoritesProvider(restAPINetworkService, graphQLNetworkService);
          final viewModel = UnitObserverViewModel(
            provider: provider,
            favoritesProvider: favoritesProvider,
            config: setting.arguments as ChildrenUnit,
          );

          return UnitObserverScreen(viewModel: viewModel);
        },
      );

    case VehicleSelectorRouteKeys.partObserver:
      return nativePageRoute(
        settings: setting,
        builder: (context) {
          final provider = VehicleProvider(graphQLNetworkService);
          final favoritesProvider = FavoritesProvider(restAPINetworkService, graphQLNetworkService);
          final viewModel = PartViewModel(
            provider: provider,
            favoritesProvider: favoritesProvider,
            config: setting.arguments as ChildrenPart,
          );

          return PartScreen(viewModel: viewModel);
        },
      );

    case VehicleSelectorRouteKeys.engineSelector:
      return nativePageRoute(
        settings: setting,
        builder: (context) {
          final provider = VehicleProvider(graphQLNetworkService);
          final viewModel = EngineSelectorViewModel(
            restAPINetworkService: restAPINetworkService,
            provider: provider,
            truck: setting.arguments as Truck,
          );

          return EngineSelectorScreen(viewModel: viewModel);
        },
      );
    case VehicleSelectorRouteKeys.truckSelector:
      return nativePageRoute(
        settings: setting,
        builder: (context) {
          final provider = VehicleProvider(graphQLNetworkService);
          final viewModel = TruckSelectorViewModel(provider: provider);

          return TruckSelectorScreen(viewModel: viewModel);
        },
      );
  }
}
