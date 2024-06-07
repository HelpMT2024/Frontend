import 'package:flutter/material.dart';
import 'package:help_my_truck/services/API/vehicle_provider.dart';
import 'package:help_my_truck/services/router/router.dart';
import 'package:help_my_truck/ui/main_flow/home_page.dart';
import 'package:help_my_truck/ui/search_flow/search_screen.dart';
import 'package:help_my_truck/ui/widgets/nav_bar/nav_bar_page.dart';

class VehicleNavigationHelper {
  static void navigateTo(
    NavBarPage tab,
    BuildContext context,
    bool onlySearch,
  ) {
    if (onlySearch && tab != NavBarPage.search) {
      return;
    }
    if (tab == NavBarPage.search) {
      _showSearchModal(context);
    } else {
      Navigator.of(context).popUntil((route) => route.isFirst);
      mainPageController.selectedPage = tab;
    }
  }

  static void _showSearchModal(BuildContext context) {
    final provider = VehicleProvider(graphQLService, restAPIService);
    final controller = SearchModalController(provider: provider);
    final search = SearchScreen(searchModalController: controller);

    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext bc) => Wrap(
        children: [search],
      ),
    );
  }
}
