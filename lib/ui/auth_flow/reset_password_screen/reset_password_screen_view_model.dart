import 'package:flutter/material.dart';
import 'package:help_my_truck/services/API/auth_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ResetPasswordScreenViewModel {
  final AuthProvider provider;

  String? _email;

  ResetPasswordScreenViewModel({required this.provider});

  void saveEmail(String? email) {
    _email = email;
  }

  void submit(BuildContext context) {
    if (_email?.isNotEmpty ?? false) {
      provider
          .resetPassword(email: _email ?? '')
          .then((value) => Navigator.of(context).pop());
    }
  }
}
