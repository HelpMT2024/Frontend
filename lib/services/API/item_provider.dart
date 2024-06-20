import 'package:help_my_truck/services/API/graph_ql_network_service.dart';
import 'package:help_my_truck/services/API/rest_api_network_service.dart';

class UserInfoModel {
  final int id;
  final String userName;
  final String email;
  final String language;
  final String createdAt;

  UserInfoModel({
    required this.id,
    required this.userName,
    required this.email,
    required this.language,
    required this.createdAt,
  });

  factory UserInfoModel.fromJson(Map<String, dynamic> json) => UserInfoModel(
        id: json["id"],
        email: json["email"],
        userName: json["username"],
        language: json["language"],
        createdAt: json["createdAt"],
      );
}

class ContentfulItem {
  final int id;
  final String integrationId;
  final bool isFavorite;

  ContentfulItem({
    required this.id,
    required this.integrationId,
    required this.isFavorite,
  });

  factory ContentfulItem.fromJson(Map<String, dynamic> json) => ContentfulItem(
        id: json["id"],
        integrationId: json["integrationId"],
        isFavorite: json["isFavorite"],
      );
}

class FavoritesListModel {
  Pagination pagination;
  List<FavoritesListItem> items;

  FavoritesListModel({
    required this.pagination,
    required this.items,
  });

  factory FavoritesListModel.fromJson(Map<String, dynamic> json) {
    var paginationJson = json['pagination'];
    var itemsJson = json['items'] as List;

    Pagination pagination = Pagination.fromJson(paginationJson);
    List<FavoritesListItem> items =
        itemsJson.map((i) => FavoritesListItem.fromJson(i)).toList();

    return FavoritesListModel(
      pagination: pagination,
      items: items,
    );
  }
}

class CommentsListModel {
  Pagination pagination;
  List<CommentsListItem> items;

  CommentsListModel({
    required this.pagination,
    required this.items,
  });

  factory CommentsListModel.fromJson(Map<String, dynamic> json) {
    var paginationJson = json['pagination'];
    var itemsJson = json['items'] as List;

    Pagination pagination = Pagination.fromJson(paginationJson);
    List<CommentsListItem> items =
        itemsJson.map((i) => CommentsListItem.fromJson(i)).toList();

    return CommentsListModel(
      pagination: pagination,
      items: items,
    );
  }
}

class Pagination {
  final int count;
  final int total;
  final int perPage;
  final int page;
  final int pages;

  Pagination({
    required this.count,
    required this.total,
    required this.perPage,
    required this.page,
    required this.pages,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        count: json["count"],
        total: json["total"],
        perPage: json["per_page"],
        page: json["page"],
        pages: json["pages"],
      );
}

class FavoritesListItem {
  final int id;
  final int contentfulId;
  final String integrationId;
  final String type;
  final int ownerId;
  final String ownerUsername;
  final String createdAt;
  String? name;

  FavoritesListItem({
    required this.id,
    required this.contentfulId,
    required this.integrationId,
    required this.type,
    required this.ownerId,
    required this.ownerUsername,
    required this.createdAt,
  });

  factory FavoritesListItem.fromJson(Map<String, dynamic> json) =>
      FavoritesListItem(
        id: json["id"],
        contentfulId: json["contentful_id"],
        integrationId: json["integration_id"],
        type: json["type"],
        ownerId: json["owner_id"],
        ownerUsername: json["owner_username"],
        createdAt: json["created_at"],
      );
}

class CommentsListItem {
  final int id;
  final String text;
  final int reported;
  final String integrationId;
  final int ownerId;
  final String ownerUsername;
  final DateTime createdAt;

  CommentsListItem({
    required this.id,
    required this.text,
    required this.reported,
    required this.integrationId,
    required this.ownerId,
    required this.ownerUsername,
    required this.createdAt,
  });

  factory CommentsListItem.fromJson(Map<String, dynamic> json) =>
      CommentsListItem(
        id: json["id"],
        text: json["text"],
        reported: json["reported"],
        integrationId: json["integration_id"],
        ownerId: json["owner_id"],
        ownerUsername: json["owner_username"],
        createdAt: DateTime.parse(json["created_at"]),
      );
}

class ItemProvider {
  final RestAPINetworkService restAPINetworkService;
  final GraphQLNetworkService graphQLNetworkService;

  ItemProvider(this.restAPINetworkService, this.graphQLNetworkService);

  Future<UserInfoModel> user() {
    final request = NetworkRequest(
      type: NetworkRequestType.get,
      path: '/api/user',
      data: const NetworkRequestBody.empty(),
    );

    return restAPINetworkService.execute(
      request,
      (json) => UserInfoModel.fromJson(json['data']),
    );
  }

  Future<ContentfulItem> item(String integrationId) {
    final request = NetworkRequest(
      type: NetworkRequestType.get,
      path: '/api/contentful/$integrationId/external',
      data: const NetworkRequestBody.empty(),
    );

    return restAPINetworkService.execute(
      request,
      (json) => ContentfulItem.fromJson(json['data']),
    );
  }

  Future add(String integrationId, String type) {
    final request = NetworkRequest(
      type: NetworkRequestType.post,
      path: '/api/contentful/add',
      data: NetworkRequestBody.formData({
        'integrationId': integrationId,
        'type': type,
      }),
    );

    return restAPINetworkService.execute(
      request,
      (json) => null,
    );
  }

  Future<ContentfulItem> processItem(String integrationId, String type) async {
    return await item(integrationId).then((item) => item).catchError((error) {
      if (error.code == 500) {
        return _handleCatchError(integrationId, type);
      }
    });
  }

  Future<ContentfulItem> _handleCatchError(
      String integrationId, String type) async {
    await add(integrationId, type);
    return item(integrationId);
  }

  Future change(int id) {
    final request = NetworkRequest(
      type: NetworkRequestType.post,
      path: '/api/contentful/$id/favorite/change',
      data: const NetworkRequestBody.empty(),
    );

    return restAPINetworkService.execute(request, (json) => null);
  }

  Future<FavoritesListModel> favoritesList(
    int? ownerId,
    List<String> typeFilters,
    int page,
    int size,
  ) {
    Map<String, dynamic> queryParameters = {
      'filter[owner_id]': ownerId,
      'page': page,
      'size': size,
    };

    var index = 0;
    for (var typeFilter in typeFilters) {
      queryParameters['filter[contentful_type][$index]'] = typeFilter;
      index += 1;
    }

    final request = NetworkRequest(
      type: NetworkRequestType.get,
      path: '/api/favorite/list',
      data: const NetworkRequestBody.empty(),
      queryParams: queryParameters,
    );

    return restAPINetworkService.execute(
      request,
      (json) => FavoritesListModel.fromJson(json['data']),
    );
  }

  Future<CommentsListModel> commentsList(
    int contentfulId,
    int? ownerId,
    int page,
    int size,
  ) {
    Map<String, dynamic> queryParameters = {
      //'filter[owner_id]': ownerId,
      'page': page,
      'size': size,
    };

    final request = NetworkRequest(
      type: NetworkRequestType.get,
      path: '/api/contentful/$contentfulId/comment/list',
      data: const NetworkRequestBody.empty(),
      queryParams: queryParameters,
    );

    return restAPINetworkService.execute(
      request,
      (json) => CommentsListModel.fromJson(json['data']),
    );
  }

  Future addComment(int contentfulId, String text) {
    final request = NetworkRequest(
      type: NetworkRequestType.post,
      path: '/api/contentful/$contentfulId/comment/add',
      data: NetworkRequestBody.formData({
        'text': text,
      }),
    );

    return restAPINetworkService.execute(
      request,
      (json) => null,
    );
  }

  Future report(int contentfulId, int commentId) {
    final request = NetworkRequest(
      type: NetworkRequestType.post,
      path: '/api/contentful/$contentfulId/comment/$commentId/report',
      data: NetworkRequestBody.empty(),
    );

    return restAPINetworkService.execute(
      request,
      (json) => null,
    );
  }
}
