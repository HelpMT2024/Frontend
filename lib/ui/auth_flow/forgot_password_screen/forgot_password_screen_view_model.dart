import 'package:flutter/cupertino.dart';
import 'package:help_my_truck/extensions/widget_error.dart';
import 'package:help_my_truck/services/API/auth_provider.dart';
import 'package:help_my_truck/services/router/auth_router.dart';
import 'package:rxdart/rxdart.dart';

class ForgotPasswordScreenViewModel with ViewModelErrorHandable {
  final AuthProvider provider;

  String? _email;

  late final isLoading = BehaviorSubject<bool>.seeded(false);

  ForgotPasswordScreenViewModel({required this.provider});

  void saveCode(String? value) {
    if (value != _email) {
      _email = value;
    }
  }

  String? validateCode(String? value) {
    if (value == null || value.isEmpty) {
      return "The email can't be empty";
    }

    return null;
  }

  void submit(BuildContext context) {
    if (_email?.isNotEmpty ?? false) {
      isLoading.add(true);
      provider.resetPassword(email: _email ?? '').then((value) {
        isLoading.add(false);
        Navigator.of(context).pushNamed(AuthRouteKeys.loginScreen);
      }).catchError((error) {
        isLoading.add(false);
        showAlertDialog(context, error.message);
      });
    }
  }
}
