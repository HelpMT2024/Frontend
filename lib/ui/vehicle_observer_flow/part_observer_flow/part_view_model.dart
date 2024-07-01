import 'dart:async';

import 'package:flutter/material.dart';
import 'package:help_my_truck/data/models/child_problem.dart';
import 'package:help_my_truck/data/models/component.dart';
import 'package:help_my_truck/data/models/contentfull_entnities.dart';
import 'package:help_my_truck/data/models/fault.dart';
import 'package:help_my_truck/data/models/favorite_model_type.dart';
import 'package:help_my_truck/data/models/part.dart';
import 'package:help_my_truck/extensions/widget_error.dart';
import 'package:help_my_truck/services/API/item_provider.dart';
import 'package:help_my_truck/services/API/vehicle_provider.dart';
import 'package:help_my_truck/services/router/vehicle_selector_router.dart';
import 'package:rxdart/rxdart.dart';

import '../../widgets/nav_bar/nav_bar_page.dart';
import '../vehicle_navigation_helper.dart';

class PartViewModel with ErrorHandable {
  final VehicleProvider provider;
  final ItemProvider itemProvider;
  final FavoriteModelType itemType = FavoriteModelType.part;
  final ChildrenPart config;

  var itemStreamController = StreamController<ContentfulItem>();

  late final part = BehaviorSubject<Part>()
    ..addStream(Stream.fromFuture(
      provider.part(config.id).catchError((error) {
        showAlertDialog(null, error);
      }),
    ));

  bool get hasImage =>
      part.valueOrNull?.imageView != null &&
      part.valueOrNull?.imageView?.imageFront != null;

  List<PdfFile> get pdfFiles =>
      part.valueOrNull?.pdfFilesCollection.items ?? [];
  bool get hasPDF => pdfFiles.isNotEmpty;
  bool get hasVideos =>
      part.valueOrNull?.videosCollection.items.isNotEmpty ?? false;

  bool get hasFaults => part.valueOrNull?.faults.isNotEmpty ?? false;
  bool get hasDescription => part.valueOrNull?.description != null;

  List<ChildWarningLight> get warnings => part.valueOrNull?.warningLights ?? [];
  bool get hasWarnings => warnings.isNotEmpty;

  List<IDPVideo> get videos => part.valueOrNull?.videosCollection.items ?? [];
  List<ChildFault> get faults => part.valueOrNull?.faults ?? [];

  List<ChildProblem> get problems => part.valueOrNull?.problems ?? [];
  bool get hasProblems => problems.isNotEmpty;

  int currentTruckIndex = 0;

  PartViewModel({
    required this.provider,
    required this.itemProvider,
    required this.config,
  }) {
    item();
  }

  item() {
    itemProvider
        .processItem(config.id, itemType.filterKey())
        .then((item) => itemStreamController.add(item));
  }

  void onSearch(BuildContext context) {
    VehicleNavigationHelper.navigateTo(NavBarPage.search, context, true);
  }

  void onModelSelected(String id, BuildContext context) {
    final model = part.valueOrNull?.subparts.firstWhere(
      (element) => element.id == id,
    );

    Navigator.of(context)
        .pushNamed(
          VehicleSelectorRouteKeys.subPartObserver,
          arguments: model,
        )
        .then((value) => item());
  }
}
