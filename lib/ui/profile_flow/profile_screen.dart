import 'package:flutter/material.dart';
import 'package:help_my_truck/const/colors.dart';
import 'package:help_my_truck/ui/profile_flow/profile_screen_view_model.dart';
import 'package:help_my_truck/ui/widgets/nav_bar/main_navigation_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfileScreen extends StatefulWidget {
  final ProfileScreenViewModel viewModel;

  const ProfileScreen({super.key, required this.viewModel});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final styles = Theme.of(context).textTheme;
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: MainNavigationBar(
        context: context,
        styles: styles,
        bgColor: ColorConstants.surfacePrimaryDark,
        action: [_settings()],
      ),
      backgroundColor: ColorConstants.surfacePrimaryDark,
      body: _body(styles, l10n),
    );
  }

  Widget _body(TextTheme styles, AppLocalizations? l10n) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'TheoTruck',
                style: styles.titleLarge
                    ?.copyWith(color: ColorConstants.onSurfaceWhite),
              ),
              _edit(l10n, styles),
            ],
          ),
          Text(
            'theotruck@gmail.com',
            style: styles.bodyMedium
                ?.copyWith(color: ColorConstants.onSurfaceWhite),
          ),
        ],
      ),
    );
  }

  Widget _settings() {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: IconButton(
        icon: Icon(
          Icons.settings,
          color: ColorConstants.onSurfaceWhite,
          size: 32,
        ),
        onPressed: widget.viewModel.settings,
      ),
    );
  }

  Widget _edit(AppLocalizations? l10n, TextTheme styles) {
    return ElevatedButton(
      onPressed: () {
        print('Button Pressed');
      },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(0),
        backgroundColor: ColorConstants.surfacePrimaryDark,
        foregroundColor: ColorConstants.onSurfaceWhite,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.edit, size: 20),
          const SizedBox(width: 6),
          Text(
            l10n?.edit ?? '',
            style: styles.bodyMedium
                ?.copyWith(color: ColorConstants.onSurfaceWhite),
          ),
        ],
      ),
    );
  }
}
