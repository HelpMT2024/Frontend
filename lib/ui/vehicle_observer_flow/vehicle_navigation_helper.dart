import 'package:flutter/material.dart';
import 'package:help_my_truck/ui/main_flow/home_page.dart';
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

    Navigator.of(context).popUntil((route) => route.isFirst);
    mainPageController.selectedPage = tab;
  }
}
