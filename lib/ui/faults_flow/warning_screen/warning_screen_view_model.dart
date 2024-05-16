import 'package:flutter/material.dart';
import 'package:help_my_truck/data/models/fault.dart';
import 'package:help_my_truck/data/models/warning.dart';
import 'package:help_my_truck/services/API/vehicle_provider.dart';
import 'package:help_my_truck/services/router/router.dart';
import 'package:help_my_truck/ui/search_flow/search_screen.dart';
import 'package:rxdart/rxdart.dart';

import '../../vehicle_observer_flow/vehicle_navigation_helper.dart';
import '../../widgets/nav_bar/nav_bar_page.dart';

class WarningScreenViewModel {
  final VehicleProvider provider;

  late final warnings = BehaviorSubject<List<Warning>>()
    ..addStream(
      Stream.fromFuture(provider.warnings()),
    );

  WarningScreenViewModel({required this.provider});

  void onModelSelected(Warning model, BuildContext context) {
    final fault = SearchFault.fromWarning(model);

    final provider = VehicleProvider(service);
    final controller = SearchModalController(
      provider: provider,
      searchFault: fault,
      needHideBackButton: true,
    );

    final search = SearchScreen(searchModalController: controller);

    showModalBottomSheet(context: context, builder: (_) => search);
  }

  void onSearch(BuildContext context) {
    VehicleNavigationHelper.navigateTo(NavBarPage.search, context, true);
  }
}
