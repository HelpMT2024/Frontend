import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:help_my_truck/const/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:help_my_truck/const/resource.dart';

class NoConnectionPlaceHolder extends StatelessWidget {
  const NoConnectionPlaceHolder({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final styles = Theme.of(context).textTheme;
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 67.5),
      color: ColorConstants.surfacePrimaryDark,
      child: Center(
        child: Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                R.ASSETS_WIFI_IS_OFF_SVG,
                height: 80,
                width: 80,
              ),
              const SizedBox(
                height: 12,
              ),
              Text(
                l10n?.ooops ?? '',
                textAlign: TextAlign.center,
                style: styles.headlineMedium
                    ?.copyWith(color: ColorConstants.onSurfaceWhite),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                l10n?.no_connection_description ?? '',
                textAlign: TextAlign.center,
                style: styles.bodyLarge
                    ?.copyWith(color: ColorConstants.onSurfaceWhite),
              ),
            ],
          ),
        ),
      ),
    );
  }
}