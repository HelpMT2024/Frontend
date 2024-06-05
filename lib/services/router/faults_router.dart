// ignore_for_file: body_might_complete_normally_nullable, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:help_my_truck/data/models/child_problem.dart';
import 'package:help_my_truck/data/models/fault.dart';
import 'package:help_my_truck/services/API/favorites_provider.dart';
import 'package:help_my_truck/services/API/graph_ql_network_service.dart';
import 'package:help_my_truck/services/API/rest_api_network_service.dart';
import 'package:help_my_truck/services/API/vehicle_provider.dart';
import 'package:help_my_truck/ui/faults_flow/fault_screen/fault_screen.dart';
import 'package:help_my_truck/ui/faults_flow/fault_screen/fault_screen_view_model.dart';
import 'package:help_my_truck/ui/faults_flow/problem_case_screen/problem_case_screen.dart';
import 'package:help_my_truck/ui/faults_flow/problem_case_screen/problem_case_view_model.dart';
import 'package:help_my_truck/ui/faults_flow/warning_screen/warning_screen.dart';
import 'package:help_my_truck/ui/faults_flow/warning_screen/warning_screen_view_model.dart';
import 'package:native_page_route/native_page_route.dart';

abstract class FaultsRouteKeys {
  static const String warningScreen = 'warningScreen';
  static const String faultScreen = 'faultScreen';
  static const String problemCaseScreen = 'problemCaseScreen';
}

Route<dynamic>? FaultsRouter(
  RouteSettings setting,
  RestAPINetworkService restAPINetworkService,
  GraphQLNetworkService graphQLNetworkService,
) {
  switch (setting.name) {
    case FaultsRouteKeys.warningScreen:
      return nativePageRoute(
        settings: setting,
        builder: (context) {
          final provider =
              VehicleProvider(graphQLNetworkService, restAPINetworkService);
          final viewModel = WarningScreenViewModel(provider: provider);

          return WarningScreen(viewModel: viewModel);
        },
      );
    case FaultsRouteKeys.problemCaseScreen:
      return nativePageRoute(
        settings: setting,
        builder: (context) {
          final config = setting.arguments as ChildProblem;
          final provider =
              VehicleProvider(graphQLNetworkService, restAPINetworkService);
          final favoritesProvider =
              FavoritesProvider(restAPINetworkService, graphQLNetworkService);
          final viewModel = ProblemCaseScreenViewModel(
            provider: provider,
            favoritesProvider: favoritesProvider,
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
          final provider =
              VehicleProvider(graphQLNetworkService, restAPINetworkService);
          final favoritesProvider =
              FavoritesProvider(restAPINetworkService, graphQLNetworkService);
          final viewModel = FaultScreenViewModel(
            provider: provider,
            favoritesProvider: favoritesProvider,
            config: config,
          );

          return FaultScreen(viewModel: viewModel);
        },
      );
  }
}
