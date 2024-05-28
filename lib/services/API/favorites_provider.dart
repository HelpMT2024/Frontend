import 'package:help_my_truck/services/API/graph_ql_network_service.dart';
import 'package:help_my_truck/services/API/rest_api_network_service.dart';

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
  final Pagination pagination;
  final List<FavoritesListItem> items;

  FavoritesListModel({
    required this.pagination,
    required this.items,
  });

  factory FavoritesListModel.fromJson(Map<String, dynamic> json) =>
      FavoritesListModel(
        pagination: json["pagination"],
        items: json["items"],
      );
}

class FavoritesListItem {
  final int id;
  final String integrationId;
  final int ownerId;
  final String ownerUsername;
  final String createdAt;

  FavoritesListItem({
    required this.id,
    required this.integrationId,
    required this.ownerId,
    required this.ownerUsername,
    required this.createdAt,
  });

  factory FavoritesListItem.fromJson(Map<String, dynamic> json) =>
      FavoritesListItem(
        id: json["id"],
        integrationId: json["integration_id"],
        ownerId: json["owner_id"],
        ownerUsername: json["owner_username"],
        createdAt: json["created_at"],
      );
}

class FavoritesProvider {
  final RestAPINetworkService service;
  final GraphQLNetworkService graphQLNetworkService;

  FavoritesProvider(this.service, this.graphQLNetworkService);

  Future change(int id) {
    final request = NetworkRequest(
      type: NetworkRequestType.get,
      path: '/api/contentful/$id/favorite/change',
      data: NetworkRequestBody.formData({
        'contentfulId': id,
      }),
    );

    return service.execute(
        request, (json) => FavoritesListModel.fromJson(json['data']));
  }

  Future<FavoritesListModel> favoritesList(int id, int page) {
    final request = NetworkRequest(
      type: NetworkRequestType.get,
      path: '/api/favorite/list',
      data: NetworkRequestBody.formData({
        'owner_id': id,
        'page': page,
      }),
    );

    return service.execute(
        request, (json) => FavoritesListModel.fromJson(json['data']));
  }

  Future<UserInfoModel> user() {
    final request = NetworkRequest(
      type: NetworkRequestType.get,
      path: '/api/user',
      data: const NetworkRequestBody.empty(),
    );

    return service.execute(
        request, (json) => UserInfoModel.fromJson(json['data']));
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
