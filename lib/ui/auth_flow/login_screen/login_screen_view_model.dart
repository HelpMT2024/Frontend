import 'package:flutter/material.dart';
import 'package:help_my_truck/services/API/auth_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:help_my_truck/services/router/vehicle_selector_router.dart';

class LoginScreenViewModel {
  final AuthProvider provider;

  String? _email;
  String? _password;
  String? _emailError;

  LoginScreenViewModel({required this.provider});

  String? validateEmail(String? value) {
    return _emailError;
  }

  void saveEmail(String? email) {
    _email = email;
  }

  void savePassword(String? password) {
    _password = password;
  }

  String? validatePassword(String? value) {
    return null;
  }

  void submit(BuildContext context, VoidCallback errorHandler) {
    if ((_email?.isNotEmpty ?? false) && (_password?.isNotEmpty ?? false)) {
      provider
          .login(
        email: _email ?? '',
        password: _password ?? '',
      )
          .then(
        (value) {
          provider.save(token: value);
          Navigator.of(context)
              .pushNamed(VehicleSelectorRouteKeys.truckSelector);
        },
      ).catchError((error) {
        (error) {
          _emailError = error.code == 412
              ? AppLocalizations.of(context)?.email_error
              : error.message;

          errorHandler();
        };
      });
    }
  }
}
