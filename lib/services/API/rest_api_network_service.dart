import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:http_parser/http_parser.dart';
import '../../data/models/token_model.dart';
import '../../extensions/widget_error.dart';
import '../../main.dart';
import '../router/auth_router.dart';
import '../shared_preferences_wrapper.dart';
import 'locale_provider.dart';

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'rest_api_network_service.freezed.dart';

@freezed
class NetworkRequestBody with _$NetworkRequestBody {
  const factory NetworkRequestBody.empty() = Empty;
  const factory NetworkRequestBody.json(Map<String, dynamic> data) = Json;
  const factory NetworkRequestBody.text(String data) = Text;
  const factory NetworkRequestBody.formData(Map<String, dynamic> data) = Form;
}

enum NetworkRequestType { get, post, put, patch, delete }

class NetworkRequest {
  NetworkRequest({
    required this.type,
    required this.path,
    required this.data,
    this.queryParams,
    this.headers,
  });

  final NetworkRequestType type;
  final String path;
  NetworkRequestBody data;
  final Map<String, dynamic>? queryParams;
  final Map<String, String>? headers;
}

@freezed
class NetworkResponse<Model> with _$NetworkResponse {
  const factory NetworkResponse.ok(Model data) = Ok;
  const factory NetworkResponse.noData(ErrorValue message) = NoData;
  const factory NetworkResponse.custom(ErrorValue message) = Custom;
  const factory NetworkResponse.updateToken(TokenModel? token, Model data) =
      UpdateToken;
  const factory NetworkResponse.updateTokenError(
      ErrorValue? error, TokenModel? token) = UpdateTokenError;
  const factory NetworkResponse.logout(TokenModel? old) = Logout;
}

class _PreparedNetworkRequest<Model> {
  _PreparedNetworkRequest(
    this.request,
    this.parser,
    this.dio,
    this.headers,
    this.onSendProgress,
    this.onReceiveProgress,
  );
  NetworkRequest request;
  final Model Function(Map<String, dynamic>) parser;
  Dio dio;
  final Map<String, dynamic> headers;
  final ProgressCallback? onSendProgress;
  final ProgressCallback? onReceiveProgress;
}

Future<NetworkResponse<Model>> _executeRequest<Model>(
  _PreparedNetworkRequest<Model> request,
  TokenModel? token,
  Future<TokenModel?> Function(TokenModel? tokenModel) refreshHandler,
) async {
  try {
    dynamic body = request.request.data.whenOrNull(
      json: (data) => data,
      text: (data) => data,
      formData: (data) {
        request.headers['content-type'] = 'multipart/form-data; charset=utf-8';
        // final debugForm = FormData.fromMap(data, ListFormat.multiCompatible);
        // debugForm.finalize().toList().then(
        //       (value) => value.forEach(
        //         (element) => print(
        //           String.fromCharCodes(element),
        //         ),
        //       ),
        //     );

        return FormData.fromMap(data, ListFormat.multiCompatible);
      },
    );

    if (body is FormData) {
      final files = body.files.where(
        (element) => element.value is MultipartFileExtended,
      );
      if (files.length != body.files.length) {
        return Future.error(
          ErrorValue(
            code: -1,
            message:
                'MultipartFileExtended use this class instead of regular MultipartFile',
          ),
        );
      }
    }

    final response = await request.dio.request(
      request.request.path,
      data: body,
      queryParameters: request.request.queryParams,
      options: Options(
        method: request.request.type.name,
        headers: request.headers,
        extra: {'token': token, 'request': request},
      ),
      onSendProgress: request.onSendProgress,
      onReceiveProgress: request.onReceiveProgress,
    );

    return NetworkResponse.ok(request.parser(response.data));
  } on DioException catch (responseError) {
    try {
      final errorText = ErrorValue.fromJson(responseError.response?.data);
      if (responseError.requestOptions.cancelToken?.isCancelled == true) {
        return NetworkResponse.noData(
          ErrorValue(code: -1, message: responseError.toString()),
        );
      }
      switch (errorText.code) {
        case 407:
          final options = responseError.requestOptions.extra;
          final isRefreshed = options['newToken'];

          if (isRefreshed != null) {
            final response = options['response'] as NetworkResponse;
            final mapped = response.map(
              ok: (value) => NetworkResponse<Model>.custom(value.data),
              noData: (value) => NetworkResponse<Model>.updateTokenError(
                  value.message, isRefreshed),
              custom: (value) => NetworkResponse<Model>.updateTokenError(
                  value.message, isRefreshed),
              updateToken: (value) =>
                  NetworkResponse<Model>.updateToken(isRefreshed, value.data),
              updateTokenError: (value) =>
                  NetworkResponse<Model>.updateTokenError(
                      value.error, isRefreshed),
              logout: (value) => NetworkResponse<Model>.logout(isRefreshed),
            );

            return mapped;
          }

          return NetworkResponse.logout(token);
        default:
          return NetworkResponse.custom(errorText);
      }
    } catch (error) {
      return NetworkResponse.noData(
        ErrorValue(
          code: -1,
          message: responseError.message,
        ),
      );
    }
  } catch (error) {
    return NetworkResponse.noData(ErrorValue(
      code: -1,
      message: error.toString(),
    ));
  }
}

class RestAPINetworkService {
  static String mainURL = () {
    // if (kDebugMode || flavor == 'Firebase') {
    //   return 'https://cbone-dev.idap.pro';
    // } else if (kReleaseMode) {
    //   return 'https://api.cbone.io';
    // } else {
    //   return 'https://cbone-stage.idap.pro';
    // }
    return 'https://helpmytrack-dev.idap.pro';
  }();

  RestAPINetworkService({
    required this.baseUrl,
    dioClient,
    httpHeaders,
  })  : _dio = dioClient,
        _headers = httpHeaders ?? {};
  Dio? _dio;
  final String baseUrl;
  Map<String, String> _headers;
  Future<Dio> _getDefaultDioClient() async {
    final dio = Dio()
      ..options.baseUrl = baseUrl
      ..options.headers = _headers
      ..options.connectTimeout = const Duration(seconds: 10)
      ..options.receiveTimeout = const Duration(seconds: 10);

    return dio;
  }

  void addLocale(L10nLocales locale) {
    _headers['locale'] = serverCodeFrom(locale);
  }

  void addBasicAuth(String accessToken) {
    _headers['Authorization'] = 'Bearer $accessToken';
  }

  Future<NetworkResponse<Model>> _retry<Model>(
    TokenModel? token,
    _PreparedNetworkRequest<Model> request,
  ) async {
    final isRefreshed = token;

    if (isRefreshed != null) {
      if (request.request.data is Form) {
        final data = request.request.data;

        request.request.data = data.map(
          empty: (empty) => empty,
          json: (json) => json,
          text: (text) => text,
          formData: (formData) {
            Map<String, dynamic> updated = {};
            updated.addAll(formData.data);

            updated.updateAll((key, value) {
              var old = value;
              if (old is MultipartFileExtended) {
                return MultipartFileExtended.fromFileSync(
                  old.filePath,
                  filename: old.filePath,
                );
              }

              return value;
            });

            return Form(updated);
          },
        );
      }

      request.headers['Authorization'] = 'Bearer ${isRefreshed.token}';
      request.dio = await _getDefaultDioClient();

      final value = await _executeRequest<Model>(
        request,
        isRefreshed,
        (_) => Future.value(null),
      ).then(
        (value) {
          return value.map(
            ok: (value) => NetworkResponse<Model>.updateToken(
                isRefreshed, value.data as Model),
            noData: (value) => NetworkResponse<Model>.updateTokenError(
                value.message, isRefreshed),
            custom: (value) => NetworkResponse<Model>.updateTokenError(
                value.message, isRefreshed),
            updateToken: (value) => value,
            updateTokenError: (value) => value,
            logout: (value) => value,
          );
        },
      ).catchError((e) => e);

      return Future.value(value as NetworkResponse<Model>);
    }

    return Future.value(NetworkResponse.logout(isRefreshed));
  }

  Future<TokenModel?> _processRefresh(TokenModel? token) async {
    if (token == null) {
      return Future.value(null);
    }
    final request = NetworkRequest(
      type: NetworkRequestType.post,
      path: '/api/user/token/refresh',
      data: NetworkRequestBody.formData(
        {
          'refreshToken': token.refreshToken,
        },
      ),
    );
    final req = _PreparedNetworkRequest<TokenModel>(
      request,
      (result) => TokenModel.fromJson(result['data']),
      await _getDefaultDioClient(),
      {..._headers, ...(request.headers ?? {})},
      (q0, q1) => {},
      (q0, q1) => {},
    );

    return _composed<TokenModel?>(_IsolatedValue(req, null)).then((result) {
      final test = result.map(
        ok: (value) => value,
        noData: (value) => null,
        custom: (value) => null,
        updateToken: (value) => null,
        logout: (_) => null,
        updateTokenError: (value) => null,
      );

      return Future.value(test?.data as TokenModel?);
    });
  }

  Future<Model> execute<Model>(
    NetworkRequest request,
    Model Function(Map<String, dynamic>) parser, {
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      _dio ??= await _getDefaultDioClient()
        ..interceptors.add(
          QueuedInterceptorsWrapper(onError: (e, handler) async {
            if (e.response?.statusCode == 407) {
              final options = e.requestOptions;
              final token = options.extra['token'];
              final newToken = await _processRefresh(token);

              options.extra['newToken'] = newToken;
              options.extra['response'] = await _retry<Model>(
                options.extra['newToken'],
                options.extra['request'],
              );

              handler.next(e);
            } else {
              handler.next(e);
            }
          }),
        );

      final req = _PreparedNetworkRequest<Model>(
        request,
        parser,
        _dio!,
        {..._headers, ...(request.headers ?? {})},
        onSendProgress,
        onReceiveProgress,
      );
      
      final token = SharedPreferencesWrapper.getToken();
      
      return await _composed<Model>(_IsolatedValue(req, token)).then(
        (value) {
          return value.map(
            ok: (response) => Future.value(response.data),
            custom: (error) => Future.error(error.message),
            noData: (error) => Future.error(error.message),
            updateTokenError: (response) {
              final token = response.token;
              if (token != null) {
                addBasicAuth(token.token);
                SharedPreferencesWrapper.setToken(token);
              }
              return Future.error(response.error as Object);
            },
            updateToken: (response) {
              final token = response.token;
              if (token != null) {
                addBasicAuth(token.token);
                SharedPreferencesWrapper.setToken(token);
              }

              return Future.value(response.data);
            },
            logout: (token) {
              final old = token.old?.token;
              final newToken = SharedPreferencesWrapper.getToken()?.token;

              if (old != newToken && old != null && newToken != null) {
                return execute(
                  request,
                  parser,
                  onReceiveProgress: onReceiveProgress,
                  onSendProgress: onSendProgress,
                );
              } else {
                SharedPreferencesWrapper.setToken(null);
                addBasicAuth('');

                final state = NavigationService.navigatorKey.currentState;
                final context = NavigationService.navigatorKey.currentContext;

                state?.pushNamedAndRemoveUntil(
                  AuthRouteKeys.authScreen,
                  (route) => false,
                );

                var error = '';
                if (context != null) {
                  final l10n = AppLocalizations.of(context);
                  error = l10n?.refresh_error ?? '';
                }

                return Future.error(ErrorValue(code: -1, message: error));
              }
            },
          );
        },
      );
    } catch (e) {
      if (e is ErrorValue) {
        return Future.error(e);
      } else {
        return Future.error(ErrorValue(code: -1, message: e.toString()));
      }
    }
  }

  Future<NetworkResponse<Model>> _composed<Model>(value) async {
    return _executeRequest<Model>(value.req, value.token, _processRefresh);
  }
}

class _IsolatedValue {
  dynamic req;
  dynamic token;
  _IsolatedValue(this.req, this.token);
}

class MultipartFileExtended extends MultipartFile {
  final String filePath;

  MultipartFileExtended(
    Stream<List<int>> stream,
    length, {
    filename,
    required this.filePath,
    contentType,
  }) : super(stream, length, filename: filename, contentType: contentType);

  static MultipartFileExtended fromFileSync(
    String filePath, {
    required String filename,
    MediaType? contentType,
  }) =>
      multipartFileFromPathSync(filePath,
          filename: filename, contentType: contentType);
}

MultipartFileExtended multipartFileFromPathSync(
  String filePath, {
  required String filename,
  MediaType? contentType,
}) {
  var file = File(filePath);
  var length = file.lengthSync();
  var stream = file.openRead();
  return MultipartFileExtended(
    stream,
    length,
    filename: filename,
    contentType: contentType,
    filePath: filePath,
  );
}
