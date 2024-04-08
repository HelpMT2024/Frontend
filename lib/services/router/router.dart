// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:help_my_truck/services/API/network_service.dart';
import 'package:help_my_truck/services/router/home_router.dart';
import 'package:help_my_truck/services/router/vehicle_selector_router.dart';

final service = NetworkService();

Route<dynamic>? AppRouter(RouteSettings setting) {
  var route =
      HomeRouter(setting, service) ?? VehicleSelectorRouter(setting, service);

  return route;
}
