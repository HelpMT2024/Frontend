import 'package:help_my_truck/data/models/part.dart';
import 'package:help_my_truck/services/API/network_service.dart';
import 'package:help_my_truck/services/API/queries.dart';

class VehicleProvider {
  final NetworkService service;

  VehicleProvider(this.service);

  Future<Part> part(String id) async {
    final query = Queries.partById(id: id);
    final result = await service.callApi(query);

    if (result.hasException) {
      throw Exception(result.exception);
    }

    return Part.fromJson(result.data!['part']);
  }
}
