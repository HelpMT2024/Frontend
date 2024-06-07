import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:help_my_truck/const/colors.dart';
import 'package:help_my_truck/ui/profile_flow/legal_and_policies_screen/legal_and_policies_screen_view_model.dart';
import 'package:help_my_truck/ui/widgets/nav_bar/main_navigation_bar.dart';
import 'package:help_my_truck/ui/widgets/settings_item.dart';

class LegalAndPoliciesScreen extends StatefulWidget {
  final LegalAndPoliciesScreenViewModel viewModel;

  const LegalAndPoliciesScreen({super.key, required this.viewModel});

  @override
  State<LegalAndPoliciesScreen> createState() => _LegalAndPoliciesScreenState();
}

class _LegalAndPoliciesScreenState extends State<LegalAndPoliciesScreen> {
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
              title: l10n?.terms_and_conditions ?? '',
              icon: null,
              onTap: () => widget.viewModel.terms(context),
            ),
            const SizedBox(height: 8),
            SettingsItem(
              title: l10n?.privacy_policy ?? '',
              icon: null,
              onTap: () => widget.viewModel.privacyPolicy(context),
            ),
          ],
        ),
      ),
    );
  }
}
