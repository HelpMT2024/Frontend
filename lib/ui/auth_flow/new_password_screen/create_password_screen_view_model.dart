import 'package:help_my_truck/services/API/auth_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CreatePasswordScreenViewModel {
  final AuthProvider provider;

  String? _password;
  String? _passwordRepeat;

  CreatePasswordScreenViewModel({required this.provider});

  void savePassword(String? password) {
    _password = password;
  }

  String? validatePassword(String? value) {
    return null;
  }

  void saveConfirmPassword(String? password) {
    _passwordRepeat = password;
  }

  String? validateConfirmPassword(String? value, AppLocalizations? l10n) {
    if (value != _password) {
      return l10n?.confirm_password_error;
    } else {
      return null;
    }
  }

  void submit() {}
}
