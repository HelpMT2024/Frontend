import 'package:help_my_truck/data/models/component.dart';
import 'package:help_my_truck/data/models/configuration.dart';
import 'package:help_my_truck/data/models/engine.dart';
import 'package:help_my_truck/data/models/fault.dart';
import 'package:help_my_truck/data/models/part.dart';
import 'package:help_my_truck/data/models/problem_case.dart';
import 'package:help_my_truck/data/models/subpart.dart';
import 'package:help_my_truck/data/models/system.dart';
import 'package:help_my_truck/data/models/truck.dart';
import 'package:help_my_truck/data/models/unit.dart';
import 'package:help_my_truck/data/models/warning.dart';
import 'package:help_my_truck/services/API/graph_ql_network_service.dart';
import 'package:help_my_truck/services/API/queries.dart';

class VehicleProvider {
  final GraphQLNetworkService service;

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

  Future<SubPart> subPart(String id) async {
    final query = Queries.subPartById(id: id);
    final result = await service.callApi(query);

    if (result.hasException) {
      throw Exception(result.exception);
    }

    return SubPart.fromJson(result.data!['subPart']);
  }

  Future<Part> part(String id) async {
    final query = Queries.partById(id: id);
    final result = await service.callApi(query);

    if (result.hasException) {
      throw Exception(result.exception);
    }

    return Part.fromJson(result.data!['part']);
  }

  Future<Fault> fault(String id) async {
    final query = Queries.faultById(id: id);
    final result = await service.callApi(query);

    if (result.hasException) {
      throw Exception(result.exception);
    }

    return Fault.fromJson(result.data!['faultCode']);
  }

  Future<SearchFault> searchFault(String spn, String fmi) async {
    final query = Queries.foundFaults(spn: spn, fmi: fmi);
    final result = await service.callApi(query);

    if (result.data!['faultCodeCollection']['items'].isEmpty) {
      throw Exception('Fault not found');
    }

    return SearchFault.fromJson(
      result.data!['faultCodeCollection']['items'][0],
    );
  }

  Future<ProblemCase> problemCase(String id) async {
    final query = Queries.problemCase(id: id);

    final result = await service.callApi(query);

    if (result.hasException) {
      throw Exception(result.exception);
    }

    return ProblemCase.fromJson(result.data!['problemCase']);
  }

  Future<List<Warning>> warnings() async {
    final query = Queries.getWholeWarningsCollection;
    final result = await service.callApi(query);

    if (result.hasException) {
      throw Exception(result.exception);
    }

    final List<dynamic> warnings =
        result.data!['warningLightCollection']['items'];

    return warnings.map((warning) => Warning.fromJson(warning)).toList();
  }
}
