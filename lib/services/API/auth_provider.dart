import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:help_my_truck/data/models/token_model.dart';
import 'package:help_my_truck/services/API/rest_api_network_service.dart';
import 'package:help_my_truck/services/shared_preferences_wrapper.dart';

class UserID {
  int id;
  String ss;

  UserID(this.id, this.ss);
}

class Verification {
  final int id;
  final String userName;
  final int status;
  final String email;
  final String language;
  final String image;
  final DateTime createdAt;
  final String roles;

  Verification({
    required this.id,
    required this.userName,
    required this.status,
    required this.email,
    required this.language,
    required this.image,
    required this.createdAt,
    required this.roles,
  });

  factory Verification.fromJson(Map<String, dynamic> json) => Verification(
        id: json["id"],
        userName: json["userName"],
        status: json["status"],
        email: json["email"],
        language: json["language"],
        image: json["image"],
        createdAt: DateTime.parse(json["createdAt"]),
        roles: json["roles"],
      );
}

class Credentials {
  final String email;
  final String password;

  Credentials({required this.email, required this.password});
}

class AuthProvider {
  final RestAPINetworkService service;

  AuthProvider(this.service);

  Future<UserID> register({
    required String username,
    required String email,
    required String password,
    required String passwordRepeat,
  }) {
    final request = NetworkRequest(
      type: NetworkRequestType.post,
      path: '/api/user/registration',
      data: NetworkRequestBody.formData({
        'username': username,
        'email': email,
        'password': password,
        'passwordRepeat': passwordRepeat,
      }),
    );

    return service.execute(
        request, (json) => UserID(json['data']['id'], json['data']['ss']));
  }

  Future<Verification> sendVerificationCode(String code) {
    final request = NetworkRequest(
      type: NetworkRequestType.get,
      path: '/api/user/approve/$code',
      data: const NetworkRequestBody.empty(),
    );

    return service.execute(
        request, (json) => Verification.fromJson(json['data']));
  }

  Future<TokenModel> login({required String email, required String password}) {
    final request = NetworkRequest(
        type: NetworkRequestType.post,
        path: '/api/user/login',
        data: NetworkRequestBody.formData({
          'username': email,
          'password': password,
        }));

    return service.execute(
        request, (json) => TokenModel.fromJson(json['data']));
  }

  Future<bool> save({required TokenModel token}) {
    service.addBasicAuth(token.token);
    return SharedPreferencesWrapper.setToken(token);
  }

  Future<void> resetPassword({required String email}) {
    final request = NetworkRequest(
      type: NetworkRequestType.post,
      path: '/api/user/reset-password',
      data: NetworkRequestBody.formData({'email': email}),
    );

    return service.execute(request, (data) {});
  }
}
