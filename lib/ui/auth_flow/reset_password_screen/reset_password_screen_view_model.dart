import 'package:flutter/material.dart';
import 'package:help_my_truck/extensions/widget_error.dart';
import 'package:help_my_truck/services/API/auth_provider.dart';
import 'package:rxdart/rxdart.dart';

class ResetPasswordScreenViewModel with ViewModelErrorHandable {
  final AuthProvider provider;

  String? _email;

  late final isLoading = BehaviorSubject<bool>.seeded(false);

  ResetPasswordScreenViewModel({required this.provider});

  void saveEmail(String? email) {
    _email = email;
  }

  void submit(BuildContext context) {
    if (_email?.isNotEmpty ?? false) {
      isLoading.add(true);
      provider.resetPassword(email: _email ?? '').then((value) {
        isLoading.add(false);
        Navigator.of(context).pop();
      }).catchError((error) {
        isLoading.add(false);
        showAlertDialog(context, error.message);
      });
    }
  }
}
