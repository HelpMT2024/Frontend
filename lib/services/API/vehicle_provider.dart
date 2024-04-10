import 'package:help_my_truck/data/models/component.dart';
import 'package:help_my_truck/data/models/configuration.dart';
import 'package:help_my_truck/data/models/engine.dart';
import 'package:help_my_truck/data/models/part.dart';
import 'package:help_my_truck/data/models/system.dart';
import 'package:help_my_truck/data/models/truck.dart';
import 'package:help_my_truck/data/models/unit.dart';
import 'package:help_my_truck/services/API/network_service.dart';
import 'package:help_my_truck/services/API/queries.dart';

class VehicleProvider {
  final NetworkService service;

  VehicleProvider(this.service);

  Future<Component> component(String id) async {
    final query = Queries.componentById(id: id);
    final result = await service.callApi(query);

    if (result.hasException) {
      throw Exception(result.exception);
    }

    return Component.fromJson(result.data!['component']);
  }

  Future<System> system(String id) async {
    final query = Queries.systemById(id: id);
    final result = await service.callApi(query);

    if (result.hasException) {
      throw Exception(result.exception);
    }

    return System.fromJson(result.data!['system']);
  }

  Future<Unit> unit(String id) async {
    final query = Queries.unitById(id: id);
    final result = await service.callApi(query);

    if (result.hasException) {
      throw Exception(result.exception);
    }

    return Unit.fromJson(result.data!['unit']);
  }

  Future<Configuration> configuration(Engine engine, Truck truck) async {
    final query = Queries.getConfiguration(
      engineId: engine.id,
      truckId: truck.id,
    );
    final result = await service.callApi(query);

    if (result.hasException) {
      throw Exception(result.exception);
    }

    final collection = result.data!['configurationCollection']['items'];
    final configuration = collection.first;

    return Configuration.fromJson(configuration);
  }

  Future<List<Truck>> trucks() async {
    const query = Queries.getTrucks;
    final result = await service.callApi(query);

    if (result.hasException) {
      throw Exception(result.exception);
    }

    final List<dynamic> trucks = result.data!['truckCollection']['items'];

    return trucks.map((truck) => Truck.fromJson(truck)).toList();
  }

  Future<List<Engine>> engines() async {
    const query = Queries.getEngines;
    final result = await service.callApi(query);

    if (result.hasException) {
      throw Exception(result.exception);
    }

    final List<dynamic> engines = result.data!['engineCollection']['items'];

    return engines.map((engine) => Engine.fromJson(engine)).toList();
  }

  Future<Part> part(String id) async {
    final query = Queries.partById(id: id);
    final result = await service.callApi(query);

    if (result.hasException) {
      throw Exception(result.exception);
    }

    return Part.fromJson(result.data!['part']);
  }
}
