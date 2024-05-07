import 'package:flutter/material.dart';
import 'package:help_my_truck/services/API/network_service.dart';
import 'package:help_my_truck/services/API/vehicle_provider.dart';
import 'package:help_my_truck/ui/favorites_flow/favorites_screen.dart';
import 'package:help_my_truck/ui/favorites_flow/favorites_screen_view_model.dart';
import 'package:native_page_route/native_page_route.dart';

abstract class FavoritesRouteKeys {
  static const String favoritesScreen = 'favoritesScreen';
}

Route<dynamic>? FavoritesRouter(RouteSettings setting, NetworkService service) {
  switch (setting.name) {
    case FavoritesRouteKeys.favoritesScreen:
      return nativePageRoute(
        settings: setting,
        builder: (context) {
          final provider = VehicleProvider(service);
          final viewModel = FavoritesScreenViewModel(provider: provider);

          return FavoritesScreen(viewModel: viewModel);
        }
      );
  }
}