import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:help_my_truck/services/router/auth_router.dart';
import 'package:help_my_truck/ui/widgets/custom_button.dart';

import '../../const/colors.dart';
import '../../const/resource.dart';
import '../widgets/app_gradient_bg_decorator.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  void _signUp(BuildContext context) {
    Navigator.of(context).pushNamed(AuthRouteKeys.authScreen);
  }

  void _login(BuildContext context) {
    Navigator.of(context).pushNamed(AuthRouteKeys.loginScreen);
  }

  @override
  Widget build(BuildContext context) {
    final styles = Theme.of(context).textTheme;
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      body: Container(
          padding: const EdgeInsets.only(bottom: 56),
          decoration: appGradientBgDecoration,
          child: _body(styles, l10n, context)),
    );
  }

  Widget _body(TextTheme styles, AppLocalizations? l10n, BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SvgPicture.asset(
          R.ASSETS_TRUCK_SVG,
          width: double.infinity,
          height: MediaQuery.of(context).size.width * 237 / 375,
        ),
        const SizedBox(height: 64),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ..._texts(styles, l10n),
              const SizedBox(height: 32),
              ..._buttons(styles, l10n, context),
            ],
          ),
        ),
      ],
    );
  }

  List<Widget> _texts(TextTheme styles, AppLocalizations? l10n) {
    return [
      Text(
        l10n?.truck_care_anywhere ?? '',
        style: styles.bodyMedium?.copyWith(
          color: ColorConstants.onSurfaceWhite,
        ),
      ),
      const SizedBox(height: 8),
      Text(
        l10n?.ultimate_maintenance ?? '',
        style: styles.headlineLarge?.copyWith(
          color: ColorConstants.onSurfaceWhite,
        ),
      ),
    ];
  }

  List<Widget> _buttons(
    TextTheme styles,
    AppLocalizations? l10n,
    BuildContext context,
  ) {
    return [
      CustomButton(
        title: CustomButtonTitle(text: l10n?.sign_up ?? ''),
        state: CustomButtonStates.filled,
        mainColor: ColorConstants.surfaceWhite,
        textColor: ColorConstants.onSurfaceHigh,
        height: 48,
        onPressed: () => _signUp(context),
      ),
      const SizedBox(height: 12),
      CustomButton(
        title: CustomButtonTitle(text: l10n?.login),
        state: CustomButtonStates.filled,
        mainColor: ColorConstants.onSurfaceSecondary,
        textColor: ColorConstants.onSurfaceWhite,
        height: 48,
        onPressed: () => _login(context),
      ),
    ];
  }
}
