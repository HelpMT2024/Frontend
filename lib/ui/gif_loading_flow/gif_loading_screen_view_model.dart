import 'package:flutter/material.dart';
import 'package:help_my_truck/main.dart';
import 'package:help_my_truck/services/API/graph_ql_network_service.dart';
import 'package:help_my_truck/services/API/queries.dart';
import 'package:help_my_truck/services/gifs_loader.dart';
import 'package:help_my_truck/services/router/auth_router.dart';
import 'package:help_my_truck/services/router/vehicle_selector_router.dart';
import 'package:help_my_truck/services/shared_preferences_wrapper.dart';
import 'package:rxdart/rxdart.dart';

class GifLoadingScreenViewModel {
  final GraphQLNetworkService graphQLService;
  final loader = GifsLoader();

  late BehaviorSubject<double> progress = BehaviorSubject.seeded(0.0)
    ..addStream(loader.progress);

  GifLoadingScreenViewModel(this.graphQLService) {
    _startLoading();
  }

  void _startLoading() async {
    final query = Queries.getAllGifs;
    final result = await graphQLService.callApi(query);

    if (result.hasException) {
      _startLoading();
      return;
    }

    final list = (result.data?['assetCollection']['items'] as List)
        .map<String>((e) => e['url'])
        .toList();
    try {
      await loader.loadList(list);
    } catch (e) {
      _startLoading();
    }

    final route = SharedPreferencesWrapper.getToken() == null
        ? AuthRouteKeys.welcomeScreen
        : VehicleSelectorRouteKeys.truckSelector;

    Navigator.of(NavigationService.navigatorKey.currentContext!)
        .pushReplacementNamed(route);
  }
}
