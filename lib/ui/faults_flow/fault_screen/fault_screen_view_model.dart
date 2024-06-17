import 'package:help_my_truck/data/models/fault.dart';
import 'package:help_my_truck/data/models/favorite_model_type.dart';
import 'package:help_my_truck/services/API/favorites_provider.dart';
import 'package:help_my_truck/services/API/vehicle_provider.dart';
import 'package:rxdart/rxdart.dart';

class FaultScreenViewModel {
  final VehicleProvider provider;
  final FavoritesProvider favoritesProvider;
  final FavoriteModelType itemType = FavoriteModelType.faultCode;
  final ChildFault config;

  late final fault = BehaviorSubject<Fault>()
    ..addStream(Stream.fromFuture(provider.fault(config.id)));

  bool get hasPDF =>
      fault.valueOrNull?.pdfFilesCollection.items.isNotEmpty ?? false;
  bool get hasVideos =>
      fault.valueOrNull?.videosCollection.items.isNotEmpty ?? false;

  FaultScreenViewModel({
    required this.provider,
    required this.config,
    required this.favoritesProvider,
  }) {
    favoritesProvider.processItem(config.id, itemType.filterKey());
  }
}
