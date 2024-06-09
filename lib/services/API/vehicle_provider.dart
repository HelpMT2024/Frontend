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
import 'package:help_my_truck/services/API/rest_api_network_service.dart';

class VehicleProvider {
  final GraphQLNetworkService graphQLService;
  final RestAPINetworkService restAPIService;

  VehicleProvider(this.graphQLService, this.restAPIService);

  Future<Component> component(String id) async {
    final query = Queries.componentById(id: id);
    final result = await graphQLService.callApi(query);

    if (result.hasException) {
      throw Exception(result.exception);
    }

    return Component.fromJson(result.data!['component']);
  }

  Future<System> system(String id) async {
    final query = Queries.systemById(id: id);
    final result = await graphQLService.callApi(query);

    if (result.hasException) {
      throw Exception(result.exception);
    }

    return System.fromJson(result.data!['system']);
  }

  Future<Unit> unit(String id) async {
    final query = Queries.unitById(id: id);
    final result = await graphQLService.callApi(query);

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
    final result = await graphQLService.callApi(query);

    if (result.hasException) {
      throw Exception(result.exception);
    }

    final collection = result.data!['configurationCollection']['items'];
    final configuration = collection.first;

    return Configuration.fromJson(configuration);
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

  Future<List<Engine>> engines() async {
    const query = Queries.getEngines;
    final result = await graphQLService.callApi(query);

    if (result.hasException) {
      throw Exception(result.exception);
    }

    final List<dynamic> engines = result.data!['engineCollection']['items'];

    return engines.map((engine) => Engine.fromJson(engine)).toList();
  }

  Future<SubPart> subPart(String id) async {
    final query = Queries.subPartById(id: id);
    final result = await graphQLService.callApi(query);

    if (result.hasException) {
      throw Exception(result.exception);
    }

    return SubPart.fromJson(result.data!['subPart']);
  }

  Future<Part> part(String id) async {
    final query = Queries.partById(id: id);
    final result = await graphQLService.callApi(query);

    if (result.hasException) {
      throw Exception(result.exception);
    }

    return Part.fromJson(result.data!['part']);
  }

  Future<Fault> fault(String id) async {
    final query = Queries.faultById(id: id);
    final result = await graphQLService.callApi(query);

    if (result.hasException) {
      throw Exception(result.exception);
    }

    return Fault.fromJson(result.data!['faultCode']);
  }

  Future<SearchFault> searchFault(String spn, String fmi) async {
    final query = Queries.foundFaults(spn: spn, fmi: fmi);
    final result = await graphQLService.callApi(query);

    if (result.data!['faultCodeCollection']['items'].isEmpty) {
      throw Exception('Fault not found');
    }

    return SearchFault.fromJson(
      result.data!['faultCodeCollection']['items'][0],
    );
  }

  Future<SearchFaults> searchFaults(String spn, String fmi) async {
    final query = Queries.foundFaults(spn: spn, fmi: fmi);
    final result = await graphQLService.callApi(query);

    if (result.data!['faultCodeCollection'].isEmpty) {
      throw Exception('Faults not found');
    }

    return SearchFaults.fromJson(
      result.data!['faultCodeCollection'],
    );
  }

  Future<ProblemCase> problemCase(String id) async {
    final query = Queries.problemCase(id: id);

    final result = await graphQLService.callApi(query);

    if (result.hasException) {
      throw Exception(result.exception);
    }

    return ProblemCase.fromJson(result.data!['problemCase']);
  }

  Future<List<Warning>> warnings() async {
    final query = Queries.getWholeWarningsCollection;
    final result = await graphQLService.callApi(query);

    if (result.hasException) {
      throw Exception(result.exception);
    }

    final List<dynamic> warnings =
        result.data!['warningLightCollection']['items'];

    return warnings.map((warning) => Warning.fromJson(warning)).toList();
  }

  Future<void> chooseConfiguration({
    required String truckId,
    required String engineId,
  }) {
    final truckId = '2BV4LcsvZp3ivuHXGKTeXX';
    final engineId = '7zuQJb6lwiqWgPPKuuyzOY';
    /*
      For the MVP period, a strictly defined truck ID is sent,
      in the future the lines above must be deleted
    */
    final request = NetworkRequest(
      type: NetworkRequestType.post,
      path: '/api/truck/add',
      data: NetworkRequestBody.formData({
        'truckId': truckId,
        'engineId': engineId,
      }),
    );

    return restAPIService.execute(request, (data) {});
  }
}
