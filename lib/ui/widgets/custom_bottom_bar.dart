import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:help_my_truck/const/colors.dart';
import 'package:help_my_truck/const/resource.dart';
import 'package:help_my_truck/ui/widgets/nav_bar/nav_bar_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CustomBottomBar extends StatelessWidget {
  final NavBarPage selectedPage;
  final bool hideAllExceptSearch;
  final Function(int) onItemTapped;

  const CustomBottomBar({
    super.key,
    required this.selectedPage,
    required this.onItemTapped,
    this.hideAllExceptSearch = false,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final styles = Theme.of(context).textTheme;

    return Container(
      height: 89,
      color: Colors.red,
      child: Column(
        children: [
          Container(height: 8, color: Colors.red),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _customIcon(
                styles: styles,
                asset: R.ASSETS_HOME_SVG,
                navBarPage: NavBarPage.home,
                text: l10n?.home_title,
                action: () => onItemTapped(0),
              ),
              _customIcon(
                styles: styles,
                asset: R.ASSETS_PEOPLE_SVG,
                navBarPage: NavBarPage.people,
                text: l10n?.people_title,
                action: () => onItemTapped(1),
              ),
              if (!hideAllExceptSearch) _faultCodeIcon(l10n),
              _customIcon(
                styles: styles,
                asset: R.ASSETS_FAVORITE_STAR_SVG,
                navBarPage: NavBarPage.favorites,
                text: l10n?.favorites_title,
                action: () => onItemTapped(3),
              ),
              _customIcon(
                styles: styles,
                asset: R.ASSETS_PROFILE_IMAGE_SVG,
                navBarPage: NavBarPage.profile,
                text: l10n?.profile_title,
                action: () => onItemTapped(4),
              ),
              if (hideAllExceptSearch) _spnFmiIcon(l10n),
            ],
          ),
        ],
      ),
    );
  }

  Widget _faultCodeIcon(AppLocalizations? l10n) {
    return _customIcon(
      icon: Icons.search_rounded,
      navBarPage: NavBarPage.search,
      isCenterIcon: true,
      text: l10n?.fault_code_title,
      action: () => onItemTapped(2),
    );
  }

  Widget _spnFmiIcon(AppLocalizations? l10n) {
    return _customIcon(
      icon: Icons.search_rounded,
      navBarPage: NavBarPage.search,
      isCenterIcon: true,
      text: l10n?.spn_fmi_title,
      action: () => onItemTapped(2),
    );
  }

  Widget _customIcon({
    TextTheme? styles,
    String? asset,
    IconData? icon,
    bool isCenterIcon = false,
    NavBarPage navBarPage = NavBarPage.people,
    String? text,
    double size = 24,
    required VoidCallback action,
  }) {
    bool isActive = navBarPage == selectedPage;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: isCenterIcon
            ? ColorConstants.statesDanger
            : ColorConstants.surfacePrimaryDark,
        foregroundColor: isCenterIcon
            ? ColorConstants.onSurfaceHigh
            : isActive
                ? ColorConstants.onSurfaceWhite
                : ColorConstants.onSurfaceWhite64,
        padding: const EdgeInsets.fromLTRB(6, 4, 6, 4),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onPressed: () {
        action();
      },
      child: SizedBox(
        height: 48,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (asset != null)
              SvgPicture.asset(
                asset,
                width: 24,
                height: 24,
              ),
            if (asset == null) Icon(icon, size: size),
            const SizedBox(height: 4),
            Text(
              text ?? '',
              style: styles?.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
