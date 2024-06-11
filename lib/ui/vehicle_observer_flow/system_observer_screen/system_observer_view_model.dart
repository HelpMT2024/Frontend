import 'package:flutter/material.dart';
import 'package:help_my_truck/data/models/child_problem.dart';
import 'package:help_my_truck/data/models/contentfull_entnities.dart';
import 'package:help_my_truck/data/models/system.dart';
import 'package:help_my_truck/data/models/unit.dart';
import 'package:help_my_truck/services/API/favorites_provider.dart';
import 'package:help_my_truck/services/API/vehicle_provider.dart';
import 'package:help_my_truck/services/router/vehicle_selector_router.dart';
import 'package:help_my_truck/ui/vehicle_observer_flow/vehicle_navigation_helper.dart';
import 'package:help_my_truck/ui/widgets/nav_bar/nav_bar_page.dart';
import 'package:rxdart/rxdart.dart';

class SystemObserverViewModel {
  final VehicleProvider provider;
  final FavoritesProvider favoritesProvider;
  final ChildrenSystem config;

  late final system = BehaviorSubject<System>()
    ..addStream(
      Stream.fromFuture(provider.system(config.id)),
    );

  List<ChildProblem> get problems => system.valueOrNull?.problems ?? [];
  bool get hasProblems => problems.isNotEmpty;

  List<PdfFile> get pdfFiles =>
      system.valueOrNull?.pdfFilesCollection.items ?? [];
  bool get hasPDF => pdfFiles.isNotEmpty;

  List<IDPVideo> get videos => system.valueOrNull?.videos ?? [];
  bool get hasVideos => videos.isNotEmpty;

  bool get hasDescription => system.valueOrNull?.description != null;

  SystemObserverViewModel({
    required this.config,
    required this.provider,
    required this.favoritesProvider,
  });

  void onSearch(BuildContext context) {
    VehicleNavigationHelper.navigateTo(NavBarPage.search, context, true);
  }

  void onModelSelected(String id, BuildContext context) {
    final model =
        system.value.children.firstWhere((element) => element.id == id);

    Navigator.of(context).pushNamed(
      VehicleSelectorRouteKeys.componentObserver,
      arguments: model,
    );
  }
}
