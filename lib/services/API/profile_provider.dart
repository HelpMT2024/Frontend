import 'package:help_my_truck/data/models/truck.dart';
import 'package:help_my_truck/services/API/graph_ql_network_service.dart';
import 'package:help_my_truck/services/API/queries.dart';
import 'package:help_my_truck/services/API/rest_api_network_service.dart';

class UserInfo {
  int id;
  String email;
  String username;
  String language;
  dynamic selectedTruckId;
  List<TruckItem> truckList;
  DateTime createdAt;

  UserInfo({
    required this.id,
    required this.email,
    required this.username,
    required this.language,
    required this.selectedTruckId,
    required this.truckList,
    required this.createdAt,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
        id: json["id"],
        email: json["email"],
        username: json["username"],
        language: json["language"],
        selectedTruckId: json["selectedTruckId"],
        truckList: List<TruckItem>.from(
            json["truckList"].map((x) => TruckItem.fromJson(x))),
        createdAt: DateTime.parse(json["createdAt"]),
      );
}

class TruckItem {
  int id;
  String externalId;
  String engineId;
  DateTime createdAt;

  TruckItem({
    required this.id,
    required this.externalId,
    required this.engineId,
    required this.createdAt,
  });

  factory TruckItem.fromJson(Map<String, dynamic> json) => TruckItem(
        id: json["id"],
        externalId: json["external_id"],
        engineId: json["engine_id"],
        createdAt: DateTime.parse(json["created_at"]),
      );
}

class ProfileProvider {
  final GraphQLNetworkService graphQLService;
  final RestAPINetworkService restAPIService;

  ProfileProvider({required this.graphQLService, required this.restAPIService});

  Future<UserInfo> userInfo() {
    final request = NetworkRequest(
      type: NetworkRequestType.get,
      path: '/api/user',
      data: const NetworkRequestBody.empty(),
    );

    return restAPIService.execute(
        request, (json) => UserInfo.fromJson(json['data']));
  }

  Future<List<Truck>> trucks() async {
    const query = Queries.getTrucks;
    final result = await graphQLService.callApi(query);

    if (result.hasException) {
      throw Exception(result.exception);
    }

    final List<dynamic> trucks = result.data!['truckCollection']['items'];

    return trucks.map((truck) => Truck.fromJson(truck)).toList();
  }
}
