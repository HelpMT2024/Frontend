// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:help_my_truck/services/API/graph_ql_network_service.dart';
import 'package:help_my_truck/services/router/auth_router.dart';
import 'package:help_my_truck/services/router/faults_router.dart';
import 'package:help_my_truck/services/router/home_router.dart';
import 'package:help_my_truck/services/router/vehicle_selector_router.dart';

import '../API/rest_api_network_service.dart';

final graphQLService = GraphQLNetworkService();
final restAPIService =
    RestAPINetworkService(baseUrl: RestAPINetworkService.mainURL);

Route<dynamic>? AppRouter(RouteSettings setting) {
  var route = AuthRouter(setting, restAPIService) ??
      HomeRouter(setting, graphQLService) ??
      VehicleSelectorRouter(setting, graphQLService) ??
      FaultsRouter(setting, graphQLService);

  return route;
}
