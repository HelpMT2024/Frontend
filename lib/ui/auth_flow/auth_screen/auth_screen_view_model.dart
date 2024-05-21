import 'package:flutter/material.dart';
import 'package:help_my_truck/services/API/auth_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../services/router/auth_router.dart';
import '../../../services/shared_preferences_wrapper.dart';

class AuthScreenViewModel {
  final AuthProvider provider;

  String? _emailError;
  String? passwordRepeatError;

  String? _username;
  String? _email;
  String? _password;
  String? _passwordRepeat;

  AuthScreenViewModel({required this.provider});

  void saveUsername(String? username) {
    _username = username;
  }

  void saveEmail(String? email) {
    _email = email;
  }

  String? validateEmail(String? value) {
    return _emailError;
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

  void submit(BuildContext context, VoidCallback errorHandler) {
    if ((_username?.isNotEmpty ?? false) &&
        (_email?.isNotEmpty ?? false) &&
        (_password?.isNotEmpty ?? false) &&
        (_passwordRepeat?.isNotEmpty ?? false)) {
      provider
          .register(
        username: _username!,
        email: _email!,
        password: _password!,
        passwordRepeat: _passwordRepeat!,
      )
          .then((value) {
        SharedPreferencesWrapper.setIsFirstLaunch(true);

        Navigator.of(context).pushNamed(
          AuthRouteKeys.verificationScreen,
          arguments:
              Credentials(email: _email ?? '', password: _password ?? ''),
        );
      }).catchError(
        (error) {
          _emailError = error.code == 412
              ? AppLocalizations.of(context)?.email_error
              : error.message;

          errorHandler();
        },
      );
    }
  }
}
