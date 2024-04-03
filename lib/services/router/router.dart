// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:help_my_truck/services/router/home_router.dart';

Route<dynamic>? AppRouter(RouteSettings setting) {
  var route = HomeRouter(setting);

  return route;
}
