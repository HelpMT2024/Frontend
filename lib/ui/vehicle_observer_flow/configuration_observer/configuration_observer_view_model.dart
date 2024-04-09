import 'package:help_my_truck/data/models/configuration.dart';
import 'package:help_my_truck/services/API/vehicle_provider.dart';
import 'package:help_my_truck/ui/main_flow/home_page.dart';
import 'package:rxdart/rxdart.dart';

class ConfigurationObserverViewModel {
  late final VehicleProvider provider;
  final MainPageConfig config;

  late final configuration = BehaviorSubject<Configuration>()
    ..addStream(
      Stream.fromFuture(
        provider.configuration(config.engine, config.truck),
      ),
    );

  ConfigurationObserverViewModel({
    required this.config,
  }) {
    provider = VehicleProvider(config.service);
  }
}
