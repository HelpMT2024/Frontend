import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:help_my_truck/const/resource.dart';

import '../../../const/colors.dart';
import '../../widgets/nav_bar/main_navigation_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'verification_screen_view_model.dart';

class VerificationScreen extends StatefulWidget {
  final VerificationScreenViewModel viewModel;

  const VerificationScreen({super.key, required this.viewModel});

  @override
  State<VerificationScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<VerificationScreen> {
  @override
  Widget build(BuildContext context) {
    final styles = Theme.of(context).textTheme;
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: MainNavigationBar(
        context: context,
        styles: styles,
        bgColor: ColorConstants.surfacePrimaryDark,
      ),
      backgroundColor: ColorConstants.surfacePrimaryDark,
      body: _body(context, styles, l10n),
    );
  }

  Widget _body(BuildContext context, TextTheme styles, AppLocalizations? l10n) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(
            R.ASSETS_MARK_EMAIL_READ_SVG,
            height: 48,
            width: 48,
          ),
          const SizedBox(height: 12),
          Text(
            l10n?.verify_your_email ?? '',
            style: styles.headlineSmall
                ?.copyWith(color: ColorConstants.onSurfaceWhite),
          ),
          const SizedBox(height: 12),
          Text(
            l10n?.check_your_email ?? '',
            style: styles.bodyLarge
                ?.copyWith(color: ColorConstants.onSurfaceWhite),
          ),
        ],
      ),
    );
  }
}
