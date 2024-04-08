// ignore_for_file: body_might_complete_normally_nullable, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:help_my_truck/data/models/truck.dart';
import 'package:help_my_truck/services/API/network_service.dart';
import 'package:help_my_truck/services/API/vehicle_provider.dart';
import 'package:help_my_truck/ui/vehicle_selector_flow/engine_selector/engine_selector_screen.dart';
import 'package:help_my_truck/ui/vehicle_selector_flow/engine_selector/engine_selector_view_model.dart';
import 'package:help_my_truck/ui/vehicle_selector_flow/truck_selector/truck_selector_screen.dart';
import 'package:help_my_truck/ui/vehicle_selector_flow/truck_selector/truck_selector_view_model.dart';
import 'package:native_page_route/native_page_route.dart';

abstract class VehicleSelectorRouteKeys {
  static const String truckSelector = 'truckSelector';
  static const String engineSelector = 'engineSelector';
}

Route<dynamic>? VehicleSelectorRouter(
  RouteSettings setting,
  NetworkService service,
) {
  switch (setting.name) {
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