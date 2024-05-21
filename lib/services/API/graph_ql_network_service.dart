import 'dart:async';

import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:help_my_truck/const/app_consts.dart';
import 'package:help_my_truck/services/shared_preferences_wrapper.dart';

class GraphQLNetworkService {
  Future<bool>? _refreshTokenFuture;
  static final GraphQLNetworkService _api = GraphQLNetworkService._internal();
  final store = InMemoryStore();
  factory GraphQLNetworkService() {
    return _api;
  }

  GraphQLNetworkService._internal();

  Future<QueryResult> callApi(
    String query, {
    bool isMutation = false,
    bool cachingEnabled = false,
    Map<String, dynamic> variables = const {},
    int attempts = 0,
  }) async {
    // final token = SharedPreferencesWrapper.getToken();
    //add proxy to the link
    final link = HttpLink(
      AppConsts.pathToConnectServer,
      defaultHeaders: {
        'Authorization': AppConsts.accessToken,
      },
    );

    GraphQLClient client = GraphQLClient(
      link: link,
      cache: GraphQLCache(
        store: cachingEnabled ? store : null,
      ),
    );

    if (isMutation) {
      MutationOptions mutationOptions = MutationOptions(
        document: gql(query),
        variables: variables,
      );

      QueryResult queryResult = await client.mutate(mutationOptions);

      try {
        final isRefreshed =
            await _refreshIfNeeded(queryResult.exception?.linkException);
        if (isRefreshed) {
          return callApi(query, isMutation: isMutation, variables: variables);
        }
      } catch (e) {
        await SharedPreferencesWrapper.setToken(null);
        if (attempts < 5) {
          return callApi(
            query,
            isMutation: isMutation,
            variables: variables,
            attempts: attempts + 1,
          );
        }
      }

      _handleUnauth(queryResult);

      return queryResult;
    } else {
      QueryResult queryResult = await client.query(
        QueryOptions(
          document: gql(query),
          variables: variables,
        ),
      );

      try {
        final isRefreshed =
            await _refreshIfNeeded(queryResult.exception?.linkException);
        if (isRefreshed) {
          return callApi(query, isMutation: isMutation, variables: variables);
        }
      } catch (e) {
        await SharedPreferencesWrapper.setToken(null);

        if (attempts < 5) {
          return callApi(
            query,
            isMutation: isMutation,
            variables: variables,
            attempts: attempts + 1,
          );
        }
      }

      _handleUnauth(queryResult);

      return queryResult;
    }
  }

  void _handleUnauth(QueryResult result) {
    if (result.exception?.raw?.isNotEmpty == true) {
      if (result.exception?.raw?[0]?['errorType'] == 'Unauthorized') {
        throw Exception('Please login, to access this feature');
      }
    }
  }

  Future<bool> _refreshIfNeeded(LinkException? e) async {
    if (e is HttpLinkServerException) {
      if (e.response.statusCode == 401 &&
          e.response.reasonPhrase == 'Unauthorized' &&
          SharedPreferencesWrapper.getToken() != null) {
        _refreshTokenFuture ??= _refreshToken();

        return _refreshTokenFuture!;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  Future<bool> _refreshToken() async {
    // final token = SharedPreferencesWrapper.getToken();
    // final query = userRefreshTokenConst(token!.refreshToken);

    // final link = HttpLink(
    //   AppConsts.pathToConnectServer,
    //   defaultHeaders: {
    //     'x-api-key': AppConsts.apiKey,
    //   },
    // );

    // GraphQLClient client = GraphQLClient(link: link, cache: GraphQLCache());

    // final response = await client.mutate(
    //   MutationOptions(document: gql(query)),
    // );

    // if (response.data != null) {
    //   final json = response.data!['refreshToken'];
    //   final newToken =
    //       TokenModel.fromJson(json['access_token'], json['refresh_token']);
    //   SharedPreferencesWrapper.setToken(newToken);
    // } else {
    //   Timer(const Duration(seconds: 5), () {
    //     _refreshTokenFuture = null;
    //   });
    //   _refreshTokenFuture = null;

    //   throw Exception('Something went wrong');
    // }

    // Timer(const Duration(seconds: 5), () {
    //   _refreshTokenFuture = null;
    // });

    return false;
  }
}
