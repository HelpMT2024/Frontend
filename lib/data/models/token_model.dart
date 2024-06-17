class TokenModel {
  final String token;
  final String refreshToken;

  TokenModel(this.token, this.refreshToken);

  factory TokenModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return TokenModel(
      json['token'],
      json['refresh_token'],
    );
  }
}
