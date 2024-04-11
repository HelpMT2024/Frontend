import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:help_my_truck/const/colors.dart';
import 'package:help_my_truck/const/resource.dart';
import 'package:help_my_truck/ui/widgets/nav_bar/custom_navigation_bar_icon.dart';
import 'package:help_my_truck/ui/widgets/nav_bar/nav_bar_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MainBottomBar extends StatelessWidget {
  final NavBarPage selectedPage;
  final bool hideAllExceptSearch;
  final Function(int) onItemTapped;

  const MainBottomBar({
    super.key,
    required this.selectedPage,
    required this.onItemTapped,
    this.hideAllExceptSearch = false,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return SafeArea(
      child: PlatformNavBar(
        backgroundColor: ColorConstants.surfacePrimaryDark,
        material: (_, __) => MaterialNavBarData(
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          padding: EdgeInsets.zero,
        ),
        material3: (context, platform) {
          return MaterialNavigationBarData(
            height: 68,
            elevation: 0,
            backgroundColor: ColorConstants.surfacePrimaryDark,
            indicatorColor: ColorConstants.surfacePrimaryDark,
            labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
          );
        },
        cupertino: (context, platform) => CupertinoTabBarData(height: 51),
        items: [
          _customIcon(
            asset: R.ASSETS_HOME_SVG,
            navBarPage: NavBarPage.home,
            text: l10n?.home_title,
          ),
          _customIcon(
            asset: R.ASSETS_PEOPLE_SVG,
            navBarPage: NavBarPage.people,
            text: l10n?.people_title,
          ),
          if (!hideAllExceptSearch) _faultCodeIcon(l10n),
          _customIcon(
            asset: R.ASSETS_FAVORITE_STAR_SVG,
            navBarPage: NavBarPage.favorites,
            text: l10n?.favorites_title,
          ),
          _customIcon(
            asset: R.ASSETS_PROFILE_IMAGE_SVG,
            navBarPage: NavBarPage.profile,
            text: l10n?.profile_title,
          ),
          if (hideAllExceptSearch) _faultCodeIcon(l10n),
        ],
        currentIndex: selectedPage.indexPage,
        itemChanged: (int index) => onItemTapped(index),
      ),
    );
  }

  BottomNavigationBarItem _faultCodeIcon(AppLocalizations? l10n) {
    return _customIcon(
      icon: Icons.search_rounded,
      navBarPage: NavBarPage.search,
      isCenterIcon: true,
      text: l10n?.fault_code_title,
    );
  }

  BottomNavigationBarItem _customIcon({
    String? asset,
    IconData? icon,
    bool isCenterIcon = false,
    NavBarPage navBarPage = NavBarPage.home,
    String? text,
    double size = 24,
    double padding = 0,
  }) {
    bool isActive = navBarPage == selectedPage;
    return BottomNavigationBarItem(
      icon: Container(
        padding: EdgeInsets.only(top: Platform.isAndroid ? 0 : 5),
        child: GestureDetector(
          behavior: HitTestBehavior.deferToChild,
          child: CustomNavigationBarIcon(
            asset: hideAllExceptSearch ? null : asset,
            icon: icon,
            isCenterItem: isCenterIcon,
            isActiveItem: isActive,
            text: !hideAllExceptSearch || navBarPage == NavBarPage.search
                ? text
                : null,
            size: size,
            padding: padding,
          ),
        ),
      ),
    );
  }
}
