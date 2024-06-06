import 'package:flutter/material.dart';
import 'package:help_my_truck/extensions/widget_error.dart';
import 'package:help_my_truck/services/API/auth_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:rxdart/rxdart.dart';

class ResetPasswordScreenViewModel with ViewModelErrorHandable {
  final AuthProvider provider;

  String? _password;
  String? _newPassword;
  String? _newPasswordRepeat;
  String? passwordRepeatError;

  late final isLoading = BehaviorSubject<bool>.seeded(false);

  ResetPasswordScreenViewModel({required this.provider});

  void savePassword(String? value) {
    _password = value;
  }

  String? validatePassword(String? value) {
    if (value != _password) {
      _password = value;
    }

    return null;
  }

  void saveNewPassword(String? value) {
    _newPassword = value;
  }

  String? validateNewPassword(String? value) {
    if (value != _password) {
      _newPassword = value;
    }

    return null;
  }

  void saveConfirmPassword(String? value) {
    _newPasswordRepeat = value;
  }

  String? validateConfirmPassword(String? value, AppLocalizations? l10n) {
    if (value != _newPassword) {
      passwordRepeatError = l10n?.confirm_password_error;
    } else {
      passwordRepeatError = null;
    }

    return passwordRepeatError;
  }

  void submit(BuildContext context) {
    if ((_password?.isNotEmpty ?? false) &&
        (_newPassword?.isNotEmpty ?? false) &&
        (_newPasswordRepeat?.isNotEmpty ?? false)) {
      isLoading.add(true);
      provider
          .changePassword(
        passwordOld: _password ?? '',
        passwordNew: _newPassword ?? '',
        passwordNewRepeat: _newPasswordRepeat ?? '',
      )
          .then((value) {
        isLoading.add(false);
        Navigator.of(context).pop();
      }).catchError((error) {
        isLoading.add(false);
        showAlertDialog(context, error.message);
      });
    }
  }
}
