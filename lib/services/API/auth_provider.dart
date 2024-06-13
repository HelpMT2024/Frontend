import 'package:help_my_truck/data/models/token_model.dart';
import 'package:help_my_truck/services/API/rest_api_network_service.dart';
import 'package:help_my_truck/services/shared_preferences_wrapper.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class UserID {
  final int id;
  final int status;
  final String acceptId;

  UserID({required this.id, required this.status, required this.acceptId});

  factory UserID.fromJson(Map<String, dynamic> json) => UserID(
        id: json["id"],
        status: json["status"],
        acceptId: json["acceptId"],
      );
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
  final String username;
  final String email;
  final String password;
  final String acceptId;

  Credentials({
    required this.username,
    required this.email,
    required this.password,
    required this.acceptId,
  });
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

    return service
        .execute(request, (json) => UserID.fromJson(json['data']))
        .then((value) async {
      await Purchases.logIn(email);
      return value;
    });
  }

  Future<Verification> sendVerificationCode(String acceptId, String code) {
    final request = NetworkRequest(
      type: NetworkRequestType.get,
      path: '/api/user/approve/$acceptId/$code',
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

    return service
        .execute(
      request,
      (json) => TokenModel.fromJson(json['data']),
    )
        .then((value) async {
      await Purchases.logIn(email);
      return value;
    });
  }

  Future<bool> save({required TokenModel token}) {
    service.addBasicAuth(token.token);
    return SharedPreferencesWrapper.setToken(token);
  }

  Future<void> changePassword({
    required String passwordOld,
    required String passwordNew,
    required String passwordNewRepeat,
  }) {
    final request = NetworkRequest(
      type: NetworkRequestType.post,
      path: '/api/user/change-password',
      data: NetworkRequestBody.formData({
        'passwordOld': passwordOld,
        'passwordNew': passwordNew,
        'passwordNewRepeat': passwordNewRepeat,
      }),
    );

    return service.execute(request, (data) {});
  }

  Future<String> resendCode({required String email}) {
    final request = NetworkRequest(
        type: NetworkRequestType.post,
        path: '/api/user/resend-code',
        data: NetworkRequestBody.formData({'email': email}));

    return service.execute(request, (data) => data['data']['acceptId']);
  }

  Future<void> resetPassword({required String email}) {
    final request = NetworkRequest(
      type: NetworkRequestType.post,
      path: '/api/user/reset-password',
      data: NetworkRequestBody.formData({
        'email': email,
      }),
    );

    return service.execute(request, (data) {});
  }
}
