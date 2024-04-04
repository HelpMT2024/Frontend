import 'package:help_my_truck/data/models/token_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesWrapper {
  static late SharedPreferences _container;

  static processInitialize() async {
    _container = await SharedPreferences.getInstance();
  }

  static TokenModel? getToken() {
    final token = _container.getString('Token');
    final type = _container.getString('Type');
    final refreshToken = _container.getString('RefreshToken');

    if (token == null ||
        token.isEmpty ||
        type == null ||
        type.isEmpty ||
        refreshToken == null ||
        refreshToken.isEmpty) {
      return null;
    }

    return TokenModel(token, type, refreshToken);
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
        )
        .then(
          (_) => _container.setString('Type', value?.type ?? ''),
        );
  }
}
