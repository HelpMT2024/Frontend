import 'package:flutter/material.dart';
import 'package:help_my_truck/extensions/widget_error.dart';
import 'package:help_my_truck/services/API/auth_provider.dart';
import 'package:help_my_truck/services/router/vehicle_selector_router.dart';
import 'package:rxdart/rxdart.dart';

class LoginScreenViewModel with ErrorHandable {
  final AuthProvider provider;

  String? _email;
  String? _password;

  late final isLoading = BehaviorSubject<bool>.seeded(false);

  LoginScreenViewModel({required this.provider});

  String? validateEmail(String? value) {
    return null;
  }

  void saveEmail(String? value) {
    if (value != _email) {
      _email = value;
    }
  }

  void savePassword(String? password) {
    _password = password;
  }

  String? validatePassword(String? value) {
    return null;
  }

  void submit(BuildContext context) {
    if ((_email?.isNotEmpty ?? false) && (_password?.isNotEmpty ?? false)) {
      isLoading.add(true);
      provider
          .login(
        email: _email ?? '',
        password: _password ?? '',
      )
          .then(
        (value) {
          isLoading.add(false);
          provider.save(token: value);
          Navigator.of(context).pushNamedAndRemoveUntil(
            VehicleSelectorRouteKeys.truckSelector,
            (route) => false,
          );
        },
      ).catchError((error) {
        isLoading.add(false);
        showAlertDialog(context, error.message);
      });
    }
  }
}
