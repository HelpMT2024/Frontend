import 'package:help_my_truck/services/API/graph_ql_network_service.dart';
import 'package:help_my_truck/services/API/rest_api_network_service.dart';

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
  final String integrationId;
  final String type;
  final int ownerId;
  final String ownerUsername;
  final String createdAt;
  String? name;

  FavoritesListItem({
    required this.id,
    required this.integrationId,
    required this.type,
    required this.ownerId,
    required this.ownerUsername,
    required this.createdAt,
  });

  factory FavoritesListItem.fromJson(Map<String, dynamic> json) =>
      FavoritesListItem(
        id: json["id"],
        integrationId: json["integration_id"],
        type: json["type"],
        ownerId: json["owner_id"],
        ownerUsername: json["owner_username"],
        createdAt: json["created_at"],
      );
}

class FavoritesProvider {
  final RestAPINetworkService restAPINetworkService;
  final GraphQLNetworkService graphQLNetworkService;

  FavoritesProvider(this.restAPINetworkService, this.graphQLNetworkService);

  Future<void> createContentfulItem(String integrationId, String type) {
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
      (json) => FavoritesListModel.fromJson(json['data']),
    );
  }

  Future<ContentfulItem> itemWith(String integrationId) {
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

  Future change(int id) {
    final request = NetworkRequest(
      type: NetworkRequestType.post,
      path: '/api/contentful/$id/favorite/change',
      data: const NetworkRequestBody.empty(),
    );

    return restAPINetworkService.execute(
        request, (json) => null);
  }

  Future<FavoritesListModel> favoritesList(int? id, List<String> typeFilters, int page, int size) {
    Map<String, dynamic> queryParameters = {
        'filter[owner_id]': id,
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
}

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
