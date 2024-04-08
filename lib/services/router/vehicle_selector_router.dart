// ignore_for_file: body_might_complete_normally_nullable, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:help_my_truck/services/API/network_service.dart';
import 'package:help_my_truck/ui/main_flow/home_page.dart';
import 'package:native_page_route/native_page_route.dart';

abstract class VehicleSelectorRouteKeys {
  static const String truckSelector = 'truckSelector';
}

Route<dynamic>? VehicleSelectorRouter(
    RouteSettings setting, NetworkService service) {
  switch (setting.name) {
    case VehicleSelectorRouteKeys.truckSelector:
      return nativePageRoute(
        settings: setting,
        builder: (context) {
          return const MainPage();
        },
      );
  }
}
