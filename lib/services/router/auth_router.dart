// ignore_for_file: body_might_complete_normally_nullable, non_constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:help_my_truck/services/API/graph_ql_network_service.dart';
import 'package:help_my_truck/services/API/rest_api_network_service.dart';
import 'package:help_my_truck/ui/auth_flow/forgot_password_screen/forgot_password_screen.dart';
import 'package:help_my_truck/ui/auth_flow/forgot_password_screen/forgot_password_screen_view_model.dart';
import 'package:help_my_truck/ui/auth_flow/terms_screens/disclaimer_screen.dart';
import 'package:help_my_truck/ui/auth_flow/terms_screens/disclaimer_screen_view_model.dart';
import 'package:help_my_truck/ui/auth_flow/terms_screens/privacy_policy_screen.dart';
import 'package:help_my_truck/ui/auth_flow/terms_screens/privacy_policy_screen_view_model.dart';
import 'package:help_my_truck/ui/auth_flow/terms_screens/terms_of_service_screen.dart';
import 'package:help_my_truck/ui/auth_flow/terms_screens/terms_of_service_screen_view_model.dart';
import 'package:help_my_truck/ui/gif_loading_flow/gif_loading_screen.dart';
import 'package:help_my_truck/ui/gif_loading_flow/gif_loading_screen_view_model.dart';
import 'package:native_page_route/native_page_route.dart';
import 'package:help_my_truck/ui/auth_flow/auth_screen/auth_screen.dart';
import 'package:help_my_truck/ui/auth_flow/auth_screen/auth_screen_view_model.dart';
import 'package:help_my_truck/ui/auth_flow/login_screen/login_screen.dart';
import 'package:help_my_truck/ui/auth_flow/login_screen/login_screen_view_model.dart';
import 'package:help_my_truck/ui/auth_flow/reset_password_screen/reset_password_screen.dart';
import 'package:help_my_truck/ui/auth_flow/reset_password_screen/reset_password_screen_view_model.dart';
import 'package:help_my_truck/ui/auth_flow/verification_screen/verification_screen.dart';
import 'package:help_my_truck/ui/auth_flow/verification_screen/verification_screen_view_model.dart';
import 'package:help_my_truck/ui/auth_flow/welcome_screen.dart';
import 'package:help_my_truck/services/API/auth_provider.dart';

abstract class AuthRouteKeys {
  static const String gifLoader = 'gifLoader';
  static const String welcomeScreen = 'welcomeScreen';
  static const String authScreen = 'authScreen';
  static const String loginScreen = 'loginScreen';
  static const String verificationScreen = 'verificationCode';
  static const String resetPassword = 'resetPassword';
  static const String createPassword = 'createPassword';
  static const String termsOfService = 'termsOfService';
  static const String privacyPolicy = 'privacyPolicy';
  static const String forgotPassword = 'forgotPassword';
  static const String disclaimer = 'disclaimer';
}

Route<dynamic>? AuthRouter(
  RouteSettings setting,
  RestAPINetworkService service,
  GraphQLNetworkService graphQLService,
) {
  final provider = AuthProvider(service);

  switch (setting.name) {
    case AuthRouteKeys.gifLoader:
      return nativePageRoute(
        settings: setting,
        builder: (context) {
          final viewModel = GifLoadingScreenViewModel(graphQLService);
          return GifLoadingScreen(viewModel: viewModel);
        },
      );
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
          final viewModel = AuthScreenViewModel(provider: provider);
          return AuthScreen(
            viewModel: viewModel,
          );
        },
      );

    case AuthRouteKeys.loginScreen:
      return nativePageRoute(
        settings: setting,
        builder: (context) {
          final viewModel = LoginScreenViewModel(provider: provider);
          return LoginScreen(
            viewModel: viewModel,
          );
        },
      );

    case AuthRouteKeys.verificationScreen:
      return nativePageRoute(
        settings: setting,
        builder: (context) {
          final credentials = setting.arguments as Credentials;
          final viewModel = VerificationScreenViewModel(
            provider: provider,
            credentials: credentials,
          );
          return VerificationScreen(
            viewModel: viewModel,
          );
        },
      );

    case AuthRouteKeys.resetPassword:
      return nativePageRoute(
        settings: setting,
        builder: (context) {
          final viewModel = ResetPasswordScreenViewModel(provider: provider);
          return ResetPasswordScreen(
            viewModel: viewModel,
          );
        },
      );

    case AuthRouteKeys.termsOfService:
      return nativePageRoute(
        settings: setting,
        builder: (context) {
          final viewModel = TermsOfServiceScreenViewModel(provider: provider);
          return TermsOfServiceScreen(viewModel: viewModel);
        },
      );

    case AuthRouteKeys.privacyPolicy:
      return nativePageRoute(
        settings: setting,
        builder: (context) {
          final viewModel = PrivacyPolicyScreenViewModel(provider: provider);
          return PrivacyPolicyScreen(viewModel: viewModel);
        },
      );

    case AuthRouteKeys.disclaimer:
      return nativePageRoute(
        settings: setting,
        builder: (context) {
          final viewModel = DisclaimerScreenViewModel(provider: provider);
          return DisclaimerScreen(viewModel: viewModel);
        },
      );

    case AuthRouteKeys.forgotPassword:
      return nativePageRoute(
        settings: setting,
        builder: (context) {
          final viewModel = ForgotPasswordScreenViewModel(provider: provider);
          return ForgotPasswordScreen(
            viewModel: viewModel,
          );
        },
      );
  }
}
