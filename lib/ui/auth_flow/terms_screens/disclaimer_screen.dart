import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:help_my_truck/const/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:help_my_truck/ui/auth_flow/terms_screens/disclaimer_screen_view_model.dart';
import 'package:help_my_truck/ui/widgets/loadable.dart';
import 'package:help_my_truck/ui/widgets/nav_bar/main_navigation_bar.dart';

class DisclaimerScreen extends StatelessWidget {
  final DisclaimerScreenViewModel viewModel;

  const DisclaimerScreen({
    super.key,
    required this.viewModel,
  });

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
    return StreamBuilder(
      stream: viewModel.text,
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          return Loadable(
            forceLoad: true,
            child: Container(),
          );
        } else {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Html(
                data: snapshot.data,
                style: {
                  "span": Style(color: ColorConstants.onSurfaceWhite),
                  "li": Style(color: ColorConstants.onSurfaceWhite)
                },
              ),
            ),
          );
        }
      },
    );
  }
}
