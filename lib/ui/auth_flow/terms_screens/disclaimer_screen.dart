import 'package:flutter/material.dart';
import 'package:help_my_truck/const/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:help_my_truck/ui/widgets/nav_bar/main_navigation_bar.dart';

class DisclaimerScreen extends StatelessWidget {
  const DisclaimerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final styles = Theme.of(context).textTheme;
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: MainNavigationBar(
        context: context,
        styles: styles,
        title: l10n?.disclaimer,
        bgColor: ColorConstants.surfacePrimaryDark,
      ),
      backgroundColor: ColorConstants.surfacePrimaryDark,
      body: _body(styles),
    );
  }

  Widget _body(TextTheme styles) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: Text(
          'The information provided on the Help My Truck mobile application (the \"App\") is for general informational purposes only. While we strive to provide accurate and up-to-date information, we make no representations or warranties of any kind, express or implied, about the completeness, accuracy, reliability, suitability, or availability with respect to the App or the information, products, services, or related graphics contained on the App for any purpose. Any reliance you place on such information is therefore strictly at your own risk.\n\nIn no event shall Aliakraft Solutions LLC ("Aliakraft Solutions") be liable for any loss or damage including without limitation, indirect or consequential loss or damage, or any loss or damage whatsoever arising from loss of data, profits, property, or health arising out of, or in connection with, the use of the App.\n\nThrough the App, you are able to link to other websites and applications which are not under the control of Aliakraft Solutions. We have no control over the nature, content, and availability of those sites or applications. The inclusion of any links does not necessarily imply a recommendation or endorse the views expressed within them.\n\nEvery effort is made to keep the App up and running smoothly. However, Aliakraft Solutions takes no responsibility for, and will not be liable for, the App being temporarily unavailable due to technical issues beyond our control.\n\nBy using the Help My Truck App, you acknowledge and agree to the terms of this disclaimer. If you do not agree with any part of this disclaimer, you must not use the App.',
          style:
              styles.bodyMedium?.copyWith(color: ColorConstants.onSurfaceWhite),
        ),
      ),
    );
  }
}
