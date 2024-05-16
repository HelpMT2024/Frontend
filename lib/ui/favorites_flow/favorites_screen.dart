import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:help_my_truck/const/colors.dart';
import 'package:help_my_truck/ui/favorites_flow/favorites_screen_view_model.dart';

import '../../const/resource.dart';

class FavoritesScreen extends StatefulWidget {
  final FavoritesScreenViewModel viewModel;

  const FavoritesScreen({super.key, required this.viewModel});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    return placeholder();
  }

  Widget placeholder() {
    final l10n = AppLocalizations.of(context);
    final styles = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.only(left: 65, right: 65),
      color: ColorConstants.surfacePrimaryDark,
      child: Center(
        child: Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                R.ASSETS_BOOKMARK_SVG,
                height: 128,
                width: 128,
              ),
              const SizedBox(
                height: 23,
              ),
              Text(
                l10n?.favorites_placeholder_title ?? '',
                textAlign: TextAlign.center,
                style: styles.titleMedium?.copyWith(color: ColorConstants.onSurfaceWhite),
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                l10n?.favorites_placeholder_description ?? '',
                style: styles.bodyMedium?.copyWith(color: ColorConstants.onSurfaceWhite80),
              )
            ],
          ),
        ),
      ),
    );
  }
}
