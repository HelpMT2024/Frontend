import 'package:flutter/material.dart';
import 'package:help_my_truck/const/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:help_my_truck/ui/widgets/nav_bar/main_navigation_bar.dart';

class TermsOfServiceScreen extends StatelessWidget {
  const TermsOfServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final styles = Theme.of(context).textTheme;
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: MainNavigationBar(
        context: context,
        styles: styles,
        title: l10n?.terms_and_conditions,
        bgColor: ColorConstants.surfacePrimaryDark,
      ),
      backgroundColor: ColorConstants.surfacePrimaryDark,
      body: _body(styles),
    );
  }

  Widget _body(TextTheme styles) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Text(
          '''Lorem ipsum dolor sit amet consectetur. Eget diam gravida est vitae habitasse. Proin nec gravida dignissim eu egestas potenti. Non malesuada euismod sit orci ac. Quis aliquet cras fermentum ipsum. \n\nLorem ipsum dolor sit amet consectetur. Eget diam gravida est vitae habitasse. Proin nec gravida dignissim eu egestas potenti. Non malesuada euismod sit orci ac. Quis aliquet cras fermentum ipsum. \n\nLorem ipsum dolor sit amet consectetur. Eget diam gravida est vitae habitasse. Proin nec gravida dignissim eu egestas potenti. Non malesuada euismod sit orci ac. Quis aliquet cras fermentum ipsum. \n\nLorem ipsum dolor sit amet consectetur. Eget diam gravida est vitae habitasse. Proin nec gravida dignissim eu egestas potenti. Non malesuada euismod sit orci ac. Quis aliquet cras fermentum ipsum. \n\nLorem ipsum dolor sit amet consectetur. Eget diam gravida est vitae habitasse. Proin nec gravida dignissim eu egestas potenti. Non malesuada euismod sit orci ac. Quis aliquet cras fermentum ipsum.''',
          style:
              styles.bodyMedium?.copyWith(color: ColorConstants.onSurfaceWhite),
        ),
      ),
    );
  }
}
