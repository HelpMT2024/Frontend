class TokenModel {
  final String token;
  final String type;
  final String refreshToken;

  TokenModel(this.token, this.type, this.refreshToken);

  factory TokenModel.fromJson(
      Map<String, dynamic> json, Map<String, dynamic> refreshToken) {
    return TokenModel(
      json['token'],
      json['type'],
      refreshToken['token'],
    );
  }
}
