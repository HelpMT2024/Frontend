import 'package:flutter/material.dart';
import 'package:help_my_truck/data/models/fault.dart';
import 'package:help_my_truck/data/models/favorite_model_type.dart';
import 'package:help_my_truck/data/models/system.dart';
import 'package:help_my_truck/data/models/warning.dart';
import 'package:help_my_truck/services/API/favorites_provider.dart';
import 'package:help_my_truck/services/API/vehicle_provider.dart';
import 'package:help_my_truck/services/router/router.dart';
import 'package:help_my_truck/ui/search_flow/search_screen.dart';
import 'package:rxdart/rxdart.dart';

import '../../vehicle_observer_flow/vehicle_navigation_helper.dart';
import '../../widgets/nav_bar/nav_bar_page.dart';

class WarningScreenViewModel {
  final VehicleProvider provider;
  final FavoritesProvider favoritesProvider;
  final FavoriteModelSubType itemType = FavoriteModelSubType.warningLights;
  final ChildrenComponent config;

  late final warnings = BehaviorSubject<List<Warning>>()
    ..addStream(
      Stream.fromFuture(provider.warnings()),
    );

  WarningScreenViewModel({
    required this.provider,
    required this.favoritesProvider,
    required this.config,
  }) {
    favoritesProvider.processItem(config.id, itemType.filterKey());
  }

  void onModelSelected(Warning model, BuildContext context) {
    final fault = SearchFault.fromWarning(model);
    final faults = SearchFaults(searchFaults: [fault]);

    final provider = VehicleProvider(graphQLService, restAPIService);
    final controller = SearchModalController(
      provider: provider,
      searchFaults: faults,
      needHideBackButton: true,
    );

    final search = SearchScreen(searchModalController: controller);

    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext bc) => Wrap(
        children: [search],
      ),
    );
  }

  void onSearch(BuildContext context) {
    VehicleNavigationHelper.navigateTo(NavBarPage.search, context, true);
  }
}
