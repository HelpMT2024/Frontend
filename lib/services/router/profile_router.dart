import 'package:flutter/material.dart';
import 'package:help_my_truck/services/API/graph_ql_network_service.dart';
import 'package:help_my_truck/services/API/profile_provider.dart';
import 'package:help_my_truck/services/API/rest_api_network_service.dart';
import 'package:help_my_truck/ui/profile_flow/edit_username_screen/edit_username_screen.dart';
import 'package:help_my_truck/ui/profile_flow/edit_username_screen/edit_username_screen_view_model.dart';
import 'package:help_my_truck/ui/profile_flow/language_screen/language_screen.dart';
import 'package:help_my_truck/ui/profile_flow/language_screen/language_screen_view_model.dart';
import 'package:help_my_truck/ui/profile_flow/legal_and_policies_screen/legal_and_policies_screen.dart';
import 'package:help_my_truck/ui/profile_flow/legal_and_policies_screen/legal_and_policies_screen_view_model.dart';
import 'package:help_my_truck/ui/profile_flow/profile_screen/profile_screen.dart';
import 'package:help_my_truck/ui/profile_flow/profile_screen/profile_screen_view_model.dart';
import 'package:help_my_truck/ui/profile_flow/settings_screen/settings_screen.dart';
import 'package:help_my_truck/ui/profile_flow/settings_screen/settings_screen_view_model.dart';
import 'package:help_my_truck/ui/profile_flow/subscriptions_screen/subscriptions_screen.dart';
import 'package:help_my_truck/ui/profile_flow/subscriptions_screen/subscriptions_screen_view_model.dart';
import 'package:native_page_route/native_page_route.dart';

abstract class ProfileRouteKeys {
  static const String profileScreen = 'welcomeScreen';
  static const String editUsernameScreen = 'editUsernameScreen';
  static const String settingsScreen = 'settingsScreen';
  static const String legalAndPoliciesScreen = 'legalAndPoliciesScreen';
  static const String languageScreen = 'languageScreen';
  static const String subscriptionsScreen = 'subscriptionsScreen';
}

// ignore: body_might_complete_normally_nullable
Route<dynamic>? ProfileRouter(
  RouteSettings setting,
  GraphQLNetworkService graphQLService,
  RestAPINetworkService restAPIService,
) {
  final provider = ProfileProvider(
    graphQLService: graphQLService,
    restAPIService: restAPIService,
  );

  switch (setting.name) {
    case ProfileRouteKeys.profileScreen:
      return nativePageRoute(
        settings: setting,
        builder: (context) {
          final viewModel = ProfileScreenViewModel(provider: provider);
          return ProfileScreen(viewModel: viewModel);
        },
      );

    case ProfileRouteKeys.editUsernameScreen:
      return nativePageRoute(
        settings: setting,
        builder: (context) {
          final username = setting.arguments as String;
          final viewModel = EditUsernameScreenViewModel(provider: provider);
          return EditUsernameScreen(
            viewModel: viewModel,
            username: username,
          );
        },
      );

    case ProfileRouteKeys.settingsScreen:
      return nativePageRoute(
        settings: setting,
        builder: (context) {
          final viewModel = SettingsScreenViewModel(provider: provider);
          return SettingsScreen(viewModel: viewModel);
        },
      );

    case ProfileRouteKeys.legalAndPoliciesScreen:
      return nativePageRoute(
        settings: setting,
        builder: (context) {
          final viewModel = LegalAndPoliciesScreenViewModel(provider: provider);
          return LegalAndPoliciesScreen(viewModel: viewModel);
        },
      );

    case ProfileRouteKeys.languageScreen:
      return nativePageRoute(
        settings: setting,
        builder: (context) {
          final viewModel = LanguageScreenViewModel(provider: provider);
          return LanguageScreen(viewModel: viewModel);
        },
      );

    case ProfileRouteKeys.subscriptionsScreen:
      return nativePageRoute(
        settings: setting,
        builder: (context) {
          final viewModel = SubscriptionsScreenViewModel(provider: provider);
          return SubscriptionsScreen(viewModel: viewModel);
        },
      );
  }
}
