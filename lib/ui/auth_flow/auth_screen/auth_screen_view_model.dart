import 'package:flutter/material.dart';
import 'package:help_my_truck/extensions/widget_error.dart';
import 'package:help_my_truck/services/API/auth_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:rxdart/rxdart.dart';
import 'package:help_my_truck/services/router/auth_router.dart';
import 'package:help_my_truck/services/shared_preferences_wrapper.dart';

class AuthScreenViewModel with ErrorHandable {
  final AuthProvider provider;

  String? passwordRepeatError;

  String? _username;
  String? _email;
  String? _password;
  String? _passwordRepeat;

  late final isLoading = BehaviorSubject<bool>.seeded(false);

  AuthScreenViewModel({required this.provider});

  void saveUsername(String? username) {
    _username = username;
  }

  void saveEmail(String? email) {
    _email = email;
  }

  String? validateEmail(String? value) {
    if (value != _email) {
      _email = value;
    }

    return null;
  }

  void savePassword(String? value) {
    _password = value;
  }

  String? validatePassword(String? value) {
    if (value != _password) {
      _password = value;
    }

    return null;
  }

  void saveConfirmPassword(String? value) {
    _passwordRepeat = value;
  }

  String? validateConfirmPassword(String? value, AppLocalizations? l10n) {
    if (value != _password) {
      passwordRepeatError = l10n?.confirm_password_error;
    } else {
      passwordRepeatError = null;
    }

    return passwordRepeatError;
  }

  void submit(BuildContext context) {
    if ((_username?.isNotEmpty ?? false) &&
        (_email?.isNotEmpty ?? false) &&
        (_password?.isNotEmpty ?? false) &&
        (_passwordRepeat?.isNotEmpty ?? false)) {
      isLoading.add(true);
      provider
          .register(
        username: _username!,
        email: _email!.toLowerCase(),
        password: _password!,
        passwordRepeat: _passwordRepeat!,
      )
          .then((value) {
        isLoading.add(false);
        SharedPreferencesWrapper.setIsFirstLaunch(true);

        Navigator.of(context).pushNamed(
          AuthRouteKeys.verificationScreen,
          arguments: Credentials(
              username: _username ?? '',
              email: _email?.toLowerCase() ?? '',
              password: _password ?? '',
              acceptId: value.acceptId),
        );
      }).catchError(
        (error) {
          isLoading.add(false);
          showAlertDialog(context, error.message);
        },
      );
    }
  }

  void loginScreen(BuildContext context) {
    Navigator.of(context).pushNamed(AuthRouteKeys.loginScreen);
  }
}
