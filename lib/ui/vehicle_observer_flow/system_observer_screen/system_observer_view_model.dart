import 'dart:async';

import 'package:flutter/material.dart';
import 'package:help_my_truck/data/models/child_problem.dart';
import 'package:help_my_truck/data/models/contentfull_entnities.dart';
import 'package:help_my_truck/data/models/favorite_model_type.dart';
import 'package:help_my_truck/data/models/system.dart';
import 'package:help_my_truck/data/models/unit.dart';
import 'package:help_my_truck/extensions/widget_error.dart';
import 'package:help_my_truck/services/API/item_provider.dart';
import 'package:help_my_truck/services/API/vehicle_provider.dart';
import 'package:help_my_truck/services/purchase_service.dart';
import 'package:help_my_truck/services/router/vehicle_selector_router.dart';
import 'package:help_my_truck/ui/vehicle_observer_flow/vehicle_navigation_helper.dart';
import 'package:help_my_truck/ui/widgets/nav_bar/nav_bar_page.dart';
import 'package:rxdart/rxdart.dart';

class SystemObserverViewModel with ErrorHandable {
  final VehicleProvider provider;
  final ItemProvider itemProvider;
  final FavoriteModelType itemType = FavoriteModelType.system;
  final ChildrenSystem config;

  var itemStreamController = StreamController<ContentfulItem>();

  late final system = BehaviorSubject<System>()
    ..addStream(
      Stream.fromFuture(
        provider.system(config.id).catchError((error) {
          showAlertDialog(null, error.message);
        }),
      ),
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
    required this.itemProvider,
  }) {
    item();
  }

  void item() {
    itemProvider
        .processItem(config.id, itemType.filterKey())
        .then((item) => itemStreamController.add(item));
  }

  void onSearch(BuildContext context) {
    VehicleNavigationHelper.navigateTo(NavBarPage.search, context, true);
  }

  void onModelSelected(String id, BuildContext context) {
    final model =
        system.value.children.firstWhere((element) => element.id == id);

    final name = model.isSystem
        ? VehicleSelectorRouteKeys.systemObserver
        : VehicleSelectorRouteKeys.componentObserver;

    final child = !model.isSystem
        ? model
        : ChildrenSystem(
            id: id,
            name: model.name,
            image: model.image,
            types: [],
          );
    PurchaseService.processAfterPayment(
      () => Navigator.of(context)
          .pushNamed(name, arguments: child)
          .then((value) => item()),
      context,
    );
  }
}
