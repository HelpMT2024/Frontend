import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:help_my_truck/const/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:help_my_truck/const/resource.dart';

class PeopleComingSoonPlaceHolder extends StatelessWidget {
  const PeopleComingSoonPlaceHolder({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final styles = Theme.of(context).textTheme;

    return Center(
      child: Expanded(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              R.ASSETS_PEOPLE_COMING_SOON_SVG,
              height: 80,
              width: 80,
            ),
            const SizedBox(
              height: 12,
            ),
            Text(
              l10n?.coming_soon_title_ellipsis ?? '',
              textAlign: TextAlign.center,
              style: styles.headlineMedium
                  ?.copyWith(color: ColorConstants.onSurfaceWhite),
            ),
            const SizedBox(
              height: 6,
            ),
            Text(
              l10n?.coming_soon_top_description ?? '',
              textAlign: TextAlign.center,
              style: styles.bodyLarge?.copyWith(
                color: ColorConstants.onSurfaceWhite,
                fontSize: 16,
              ),
            ),
            Text(
              l10n?.coming_soon_bottom_description ?? '',
              textAlign: TextAlign.center,
              style: styles.bodyLarge?.copyWith(
                color: ColorConstants.onSurfaceWhite,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
