import 'package:flutter/cupertino.dart';
import 'package:help_my_truck/extensions/widget_error.dart';
import 'package:help_my_truck/services/API/auth_provider.dart';
import 'package:help_my_truck/services/router/vehicle_selector_router.dart';
import 'package:help_my_truck/services/shared_preferences_wrapper.dart';
import 'package:rxdart/rxdart.dart';

class VerificationScreenViewModel with ViewModelErrorHandable {
  final AuthProvider provider;
  final Credentials credentials;

  String? _code;

  late final isLoading = BehaviorSubject<bool>.seeded(false);

  VerificationScreenViewModel(
      {required this.provider, required this.credentials});

  void saveCode(String? value) {
    if (value != _code) {
      _code = value;
    }
  }

  String? validateCode(String? value) {
    if (value == null || value.isEmpty) {
      return "The code can't be empty";
    }

    return null;
  }

  void submit(BuildContext context) {
    if (_code?.isNotEmpty ?? false) {
      isLoading.add(true);
      provider
          .sendVerificationCode(credentials.acceptId, _code ?? '')
          .then((value) {
        provider
            .login(email: credentials.email, password: credentials.password)
            .then((value) {
          isLoading.add(false);
          SharedPreferencesWrapper.setToken(value);
          Navigator.of(context).pushNamedAndRemoveUntil(
              VehicleSelectorRouteKeys.truckSelector, (route) => false);
        });
      }).catchError((error) {
        isLoading.add(false);
        showAlertDialog(context, error.message);
      });
    }
  }

  void resendCode(BuildContext context) {
    isLoading.add(true);
    provider
        .resendCode(email: credentials.email)
        .then((value) => isLoading.add(false))
        .catchError(
      (error) {
        isLoading.add(false);
        showAlertDialog(context, error.message);
      },
    );
  }
}
