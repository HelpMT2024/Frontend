import 'package:flutter/material.dart';
import 'package:help_my_truck/services/API/favorites_provider.dart';
import 'package:help_my_truck/services/API/graph_ql_network_service.dart';
import 'package:help_my_truck/services/API/rest_api_network_service.dart';
import 'package:help_my_truck/services/API/vehicle_provider.dart';
import 'package:help_my_truck/services/router/router.dart';
import 'package:help_my_truck/ui/favorites_flow/favorites_screen.dart';
import 'package:help_my_truck/ui/favorites_flow/favorites_screen_view_model.dart';
import 'package:native_page_route/native_page_route.dart';

abstract class FavoritesRouteKeys {
  static const String favoritesScreen = 'favoritesScreen';
}

Route<dynamic>? FavoritesRouter(
  RouteSettings setting,
  RestAPINetworkService restAPINetworkService,
  GraphQLNetworkService graphQLNetworkService,
) {
  switch (setting.name) {
    case FavoritesRouteKeys.favoritesScreen:
      return nativePageRoute(
          settings: setting,
          builder: (context) {
            final provider =
                FavoritesProvider(restAPINetworkService, graphQLNetworkService);
            final vehicleProvider =
                VehicleProvider(graphQLNetworkService, restAPINetworkService);
            final viewModel = FavoritesScreenViewModel(
                provider: provider, vehicleProvider: vehicleProvider);

            return FavoritesScreen(viewModel: viewModel);
          });
  }
}
