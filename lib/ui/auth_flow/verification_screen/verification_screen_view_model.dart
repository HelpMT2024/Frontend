import 'package:flutter/cupertino.dart';
import 'package:help_my_truck/services/API/auth_provider.dart';
import 'package:help_my_truck/services/router/vehicle_selector_router.dart';
import 'package:help_my_truck/services/shared_preferences_wrapper.dart';

class VerificationScreenViewModel {
  final AuthProvider provider;
  final Credentials credentials;

  String? _code;

  VerificationScreenViewModel(
      {required this.provider, required this.credentials});

  void saveCode(String? value) {
    _code = value;
  }

  String? validateCode(String? value) {
    if (value == null || value.isEmpty) {
      return "The code can't be empty";
    }

    return null;
  }

  void submit(BuildContext context) {
    if (_code?.isNotEmpty ?? false) {
      provider
          .sendVerificationCode(credentials.acceptId, _code ?? '')
          .then((value) {
        provider
            .login(email: credentials.email, password: credentials.password)
            .then((value) {
          SharedPreferencesWrapper.setToken(value);
          Navigator.of(context)
              .pushNamed(VehicleSelectorRouteKeys.truckSelector);
        });
      });
    }
  }

  void resendCode() {
    provider.resendCode(email: credentials.email);
  }
}
