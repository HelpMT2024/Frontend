// ignore_for_file: body_might_complete_normally_nullable, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:help_my_truck/services/API/network_service.dart';
import 'package:native_page_route/native_page_route.dart';
import '../../ui/auth_flow/auth_screen/auth_screen.dart';
import '../../ui/auth_flow/auth_screen/auth_screen_view_model.dart';
import '../../ui/auth_flow/welcome_screen.dart';
import '../API/auth_provider.dart';

abstract class AuthRouteKeys {
  static const String welcomeScreen = 'welcomeScreen';
  static const String authScreen = 'authScreen';
}

Route<dynamic>? AuthRouter(RouteSettings setting, NetworkService service) {
  switch (setting.name) {
    case AuthRouteKeys.welcomeScreen:
      return nativePageRoute(
        settings: setting,
        builder: (context) {
          return const WelcomeScreen();
        },
      );

    case AuthRouteKeys.authScreen:
      return nativePageRoute(
        settings: setting,
        builder: (context) {
          final provider = AuthProvider(service);
          final viewModel = AuthScreenViewModel(provider: provider);
          return AuthScreen(
            viewModel: viewModel,
          );
        },
      );
  }
}
