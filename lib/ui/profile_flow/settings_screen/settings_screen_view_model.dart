import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:help_my_truck/extensions/widget_error.dart';
import 'package:help_my_truck/services/API/profile_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:help_my_truck/services/router/auth_router.dart';
import 'package:help_my_truck/services/router/profile_router.dart';
import 'package:help_my_truck/services/router/router.dart';
import 'package:help_my_truck/services/shared_preferences_wrapper.dart';

class SettingsScreenViewModel with ErrorHandable {
  final ProfileProvider provider;

  SettingsScreenViewModel({required this.provider});

  void resetPassword(BuildContext context) {
    Navigator.of(context).pushNamed(AuthRouteKeys.resetPassword);
  }

  void changeLanguage(BuildContext context) {
    Navigator.of(context).pushNamed(ProfileRouteKeys.languageScreen);
  }

  void subscription(BuildContext context) {
    Navigator.of(context).pushNamed(ProfileRouteKeys.subscriptionsScreen);
  }

  void privacyPolicy(BuildContext context) {
    Navigator.of(context).pushNamed(ProfileRouteKeys.legalAndPoliciesScreen);
  }

  void deleteProfile(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return PlatformAlertDialog(
          content: Text(l10n?.want_delete_profile ?? ''),
          actions: <Widget>[
            TextButton(
              child: Text(l10n?.cancel ?? ''),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(l10n?.delete ?? ''),
              onPressed: () {
                remove(context);
              },
            ),
          ],
        );
      },
    );
  }

  void logout(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return PlatformAlertDialog(
          content: Text(l10n?.want_logout ?? ''),
          actions: <Widget>[
            TextButton(
              child: Text(l10n?.cancel ?? ''),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(l10n?.logout ?? ''),
              onPressed: () {
                exit(context);
              },
            ),
          ],
        );
      },
    );
  }

  void exit(BuildContext context) {
    provider.logout().then((value) {
      SharedPreferencesWrapper.setToken(null);
      restAPIService.addBasicAuth('');
      Navigator.of(context).pop();
      Navigator.of(context).pushNamedAndRemoveUntil(
        AuthRouteKeys.welcomeScreen,
        (route) => false,
      );
    }).catchError((error) {
       showAlertDialog(context, error.message);
    });
  }

  void remove(BuildContext context) {
    provider.deleteProfile().then((value) {
      SharedPreferencesWrapper.setToken(null);
      restAPIService.addBasicAuth('');
      Navigator.of(context).pop();
      Navigator.of(context).pushNamedAndRemoveUntil(
        AuthRouteKeys.welcomeScreen,
        (route) => false,
      );
    }).catchError((error) {
      showAlertDialog(context, error.message);
    });
  }
}
