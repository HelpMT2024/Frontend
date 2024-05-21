import 'package:help_my_truck/data/models/token_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'API/locale_provider.dart';

class SharedPreferencesWrapper {
  static late SharedPreferences _container;

  static processInitialize() async {
    _container = await SharedPreferences.getInstance();
  }

  static Future<bool> setFCM(String token) {
    return _container.setString('FCMToken', token);
  }

  static TokenModel? getToken() {
    final token = _container.getString('Token');
    final refreshToken = _container.getString('RefreshToken');

    if (token == null ||
        token.isEmpty ||
        refreshToken == null ||
        refreshToken.isEmpty) {
      return null;
    }

    return TokenModel(token, refreshToken);
  }

  static Future<bool> setToken(TokenModel? value) {
    return _container
        .setString(
          'Token',
          value?.token ?? '',
        )
        .then(
          (_) =>
              _container.setString('RefreshToken', value?.refreshToken ?? ''),
        );
  }

  static Future<bool> setLocale(L10nLocales? value) {
    return _container.setString(
      'SelectedLocale',
      value?.locale.languageCode ?? '',
    );
  }

  static void setIsFirstLaunch(bool isFirstLaunch) async {
    await _container.setBool('isFirstLaunch', isFirstLaunch);
  }
}
