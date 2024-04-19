// ignore_for_file: body_might_complete_normally_nullable, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:help_my_truck/data/models/fault.dart';
import 'package:help_my_truck/services/API/network_service.dart';
import 'package:help_my_truck/services/API/vehicle_provider.dart';
import 'package:help_my_truck/ui/faults_flow/fault_screen/fault_screen.dart';
import 'package:help_my_truck/ui/faults_flow/fault_screen/fault_screen_view_model.dart';
import 'package:native_page_route/native_page_route.dart';

abstract class FaultsRouteKeys {
  static const String faultScreen = 'faultScreen';
}

Route<dynamic>? FaultsRouter(RouteSettings setting, NetworkService service) {
  switch (setting.name) {
    case FaultsRouteKeys.faultScreen:
      return nativePageRoute(
        settings: setting,
        builder: (context) {
          final config = setting.arguments as ChildFault;
          final provider = VehicleProvider(service);
          final viewModel = FaultScreenViewModel(
            provider: provider,
            config: config,
          );
          return FaultScreen(viewModel: viewModel);
        },
      );
  }
}
