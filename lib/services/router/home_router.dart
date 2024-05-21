// ignore_for_file: body_might_complete_normally_nullable, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:help_my_truck/services/API/graph_ql_network_service.dart';
import 'package:help_my_truck/ui/main_flow/home_page.dart';
import 'package:native_page_route/native_page_route.dart';

abstract class HomeRouteKeys {
  static const String home = 'home';
}

Route<dynamic>? HomeRouter(
    RouteSettings setting, GraphQLNetworkService service) {
  switch (setting.name) {
    case HomeRouteKeys.home:
      return nativePageRoute(
        settings: setting,
        builder: (context) {
          final config = setting.arguments as MainPageConfig;
          return MainPage(config: config);
        },
      );
  }
}
