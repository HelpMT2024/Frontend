import 'package:help_my_truck/services/API/auth_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AuthScreenViewModel {
  final AuthProvider provider;

  String? _usernameError;
  String? _emailError;

  String? _username;
  String? _email;
  String? _password;
  String? _passwordRepeat;

  AuthScreenViewModel({required this.provider});

  void saveUsername(String? username) {
    _username = username;
  }

  String? validateUsername(String? username, AppLocalizations? l10n) {
    provider.validateUsername();
  }

  void saveEmail(String? email) {
    _email = email;
  }

  String? validateEmail(String? email, AppLocalizations? l10n) {
    provider.validateEmail();
  }

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
