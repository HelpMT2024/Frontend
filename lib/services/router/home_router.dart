// ignore_for_file: body_might_complete_normally_nullable, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:native_page_route/native_page_route.dart';

abstract class HomeRouteKeys {
  static const String home = 'home';
}

Route<dynamic>? HomeRouter(RouteSettings setting) {
  switch (setting.name) {
    case HomeRouteKeys.home:
      return nativePageRoute(
        settings: setting,
        builder: (context) {
          return const Placeholder();
        },
      );
  }
}
