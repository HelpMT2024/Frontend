// ignore_for_file: body_might_complete_normally_nullable, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:help_my_truck/data/models/component.dart';
import 'package:help_my_truck/data/models/configuration.dart';
import 'package:help_my_truck/data/models/system.dart';
import 'package:help_my_truck/data/models/truck.dart';
import 'package:help_my_truck/data/models/unit.dart';
import 'package:help_my_truck/services/API/network_service.dart';
import 'package:help_my_truck/services/API/vehicle_provider.dart';
import 'package:help_my_truck/ui/vehicle_observer_flow/driver_cabin/driver_cabin_screen.dart';
import 'package:help_my_truck/ui/vehicle_observer_flow/driver_cabin/driver_cabin_view_model.dart';
import 'package:help_my_truck/ui/vehicle_observer_flow/part_observer_flow/part_screen.dart';
import 'package:help_my_truck/ui/vehicle_observer_flow/part_observer_flow/part_view_model.dart';
import 'package:help_my_truck/ui/vehicle_observer_flow/component_observer/component_observer_screen.dart';
import 'package:help_my_truck/ui/vehicle_observer_flow/component_observer/component_observer_view_model.dart';
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
  static const String truckSelector = 'truckSelector';
  static const String engineSelector = 'engineSelector';
}

Route<dynamic>? VehicleSelectorRouter(
  RouteSettings setting,
  NetworkService service,
) {
  switch (setting.name) {
    case VehicleSelectorRouteKeys.driverCabin:
      return nativePageRoute(
        settings: setting,
        builder: (context) {
          final provider = VehicleProvider(service);
          final viewModel = DriverCabinViewModel(
            provider: provider,
            config: setting.arguments as ChildrenSystem,
          );

          return DriverCabinScreen(viewModel: viewModel);
        },
      );
    case VehicleSelectorRouteKeys.componentObserver:
      return nativePageRoute(
        settings: setting,
        builder: (context) {
          final provider = VehicleProvider(service);
          final viewModel = ComponentObserverViewModel(
            provider: provider,
            config: setting.arguments as ChildrenComponent,
          );

          return ComponentObserverScreen(viewModel: viewModel);
        },
      );
    case VehicleSelectorRouteKeys.systemObserver:
      return nativePageRoute(
        settings: setting,
        builder: (context) {
          final provider = VehicleProvider(service);
          final viewModel = SystemObserverViewModel(
            provider: provider,
            config: setting.arguments as ChildrenSystem,
          );

          return SystemObserverScreen(viewModel: viewModel);
        },
      );

    case VehicleSelectorRouteKeys.unitObserver:
      return nativePageRoute(
        settings: setting,
        builder: (context) {
          final provider = VehicleProvider(service);
          final viewModel = UnitObserverViewModel(
            provider: provider,
            config: setting.arguments as ChildrenUnit,
          );

          return UnitObserverScreen(viewModel: viewModel);
        },
      );

    case VehicleSelectorRouteKeys.partObserver:
      return nativePageRoute(
        settings: setting,
        builder: (context) {
          final provider = VehicleProvider(service);
          final viewModel = PartViewModel(
            provider: provider,
            config: setting.arguments as ChildrenPart,
          );

          return PartScreen(viewModel: viewModel);
        },
      );

    case VehicleSelectorRouteKeys.engineSelector:
      return nativePageRoute(
        settings: setting,
        builder: (context) {
          final provider = VehicleProvider(service);
          final viewModel = EngineSelectorViewModel(
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
          final provider = VehicleProvider(service);
          final viewModel = TruckSelectorViewModel(provider: provider);

          return TruckSelectorScreen(viewModel: viewModel);
        },
      );
  }
}
