// ignore_for_file: body_might_complete_normally_nullable, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:help_my_truck/data/models/child_problem.dart';
import 'package:help_my_truck/data/models/fault.dart';
import 'package:help_my_truck/services/API/network_service.dart';
import 'package:help_my_truck/services/API/vehicle_provider.dart';
import 'package:help_my_truck/ui/faults_flow/fault_screen/fault_screen.dart';
import 'package:help_my_truck/ui/faults_flow/fault_screen/fault_screen_view_model.dart';
import 'package:help_my_truck/ui/faults_flow/problem_case_screen/problem_case_screen.dart';
import 'package:help_my_truck/ui/faults_flow/problem_case_screen/problem_case_view_model.dart';
import 'package:native_page_route/native_page_route.dart';

abstract class FaultsRouteKeys {
  static const String faultScreen = 'faultScreen';
  static const String problemCaseScreen = 'problemCaseScreen';
}

Route<dynamic>? FaultsRouter(RouteSettings setting, NetworkService service) {
  switch (setting.name) {
    case FaultsRouteKeys.problemCaseScreen:
      return nativePageRoute(
        settings: setting,
        builder: (context) {
          final config = setting.arguments as ChildProblem;
          final provider = VehicleProvider(service);
          final viewModel = ProblemCaseScreenViewModel(
            provider: provider,
            config: config,
          );

          return ProblemCaseScreen(viewModel: viewModel);
        },
      );
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
