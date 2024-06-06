import 'package:flutter/material.dart';
import 'package:help_my_truck/const/colors.dart';
import 'package:help_my_truck/ui/profile_flow/settings_screen/settings_screen_view_model.dart';
import 'package:help_my_truck/ui/widgets/nav_bar/main_navigation_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:help_my_truck/ui/widgets/settings_item.dart';

class SettingsScreen extends StatefulWidget {
  final SettingsScreenViewModel viewModel;

  const SettingsScreen({super.key, required this.viewModel});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final styles = Theme.of(context).textTheme;
    final l10n = AppLocalizations.of(context);

    return Scaffold(
        appBar: MainNavigationBar(
          title: l10n?.settings,
          context: context,
          styles: styles,
          bgColor: ColorConstants.surfacePrimaryDark,
        ),
        backgroundColor: ColorConstants.surfacePrimaryDark,
        body: _body(styles, l10n));
  }

  Widget _body(TextTheme styles, AppLocalizations? l10n) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SettingsItem(
              title: l10n?.reset_password ?? '',
              icon: Icons.password,
              onTap: () => widget.viewModel.resetPassword(),
            ),
            const SizedBox(height: 8),
            SettingsItem(
              title: l10n?.language ?? '',
              icon: Icons.language,
              onTap: () => widget.viewModel.changeLanguage(),
            ),
            const SizedBox(height: 8),
            SettingsItem(
              title: l10n?.subscription ?? '',
              icon: Icons.credit_card,
              onTap: () => widget.viewModel.subscription(),
            ),
            const SizedBox(height: 8),
            SettingsItem(
              title: l10n?.legal_and_policies ?? '',
              icon: Icons.policy,
              onTap: () => widget.viewModel.privacyPolicy(),
            ),
            const SizedBox(height: 8),
            SettingsItem(
              title: l10n?.delete_profile ?? '',
              icon: Icons.delete,
              hasArrow: false,
              onTap: () => widget.viewModel.deleteProfile(),
            ),
            const SizedBox(height: 8),
            SettingsItem(
              title: l10n?.logout ?? '',
              icon: Icons.logout,
              hasArrow: false,
              onTap: () => widget.viewModel.logout(),
            ),
          ],
        ),
      ),
    );
  }
}
