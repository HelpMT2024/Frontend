import 'dart:async';

import 'package:flutter/material.dart';
import 'package:help_my_truck/data/models/child_problem.dart';
import 'package:help_my_truck/data/models/contentfull_entnities.dart';
import 'package:help_my_truck/data/models/fault.dart';
import 'package:help_my_truck/data/models/favorite_model_type.dart';
import 'package:help_my_truck/data/models/part.dart';
import 'package:help_my_truck/data/models/subpart.dart';
import 'package:help_my_truck/extensions/widget_error.dart';
import 'package:help_my_truck/services/API/item_provider.dart';
import 'package:help_my_truck/services/API/vehicle_provider.dart';
import 'package:help_my_truck/ui/vehicle_observer_flow/vehicle_navigation_helper.dart';
import 'package:help_my_truck/ui/widgets/nav_bar/nav_bar_page.dart';
import 'package:rxdart/rxdart.dart';

class SubPartViewModel with ErrorHandable {
  final VehicleProvider provider;
  final ItemProvider itemProvider;
  final FavoriteModelType itemType = FavoriteModelType.subPart;
  final ChildSubpart config;

  var itemStreamController = StreamController<ContentfulItem>();

  late final part = BehaviorSubject<SubPart>()
    ..addStream(Stream.fromFuture(
      provider.subPart(config.id).catchError((error) {
        showAlertDialog(null, error.message);
      }),
    ));

  bool get hasImage =>
      part.valueOrNull?.imageView != null &&
      part.valueOrNull?.imageView?.imageFront != null;

  List<PdfFile> get pdfFiles =>
      part.valueOrNull?.pdfFilesCollection?.items ?? [];
  bool get hasPDF => pdfFiles.isNotEmpty;
  bool get hasVideos =>
      part.valueOrNull?.videosCollection?.items.isNotEmpty ?? false;

  bool get hasFaults => part.valueOrNull?.faults.isNotEmpty ?? false;
  bool get hasDescription => part.valueOrNull?.description != null;

  List<ChildWarningLight> get warnings => part.valueOrNull?.warningLights ?? [];
  bool get hasWarnings => warnings.isNotEmpty;

  List<IDPVideo> get videos => part.valueOrNull?.videosCollection?.items ?? [];
  List<ChildFault> get faults => part.valueOrNull?.faults ?? [];

  List<ChildProblem> get problems => part.valueOrNull?.problems ?? [];
  bool get hasProblems => problems.isNotEmpty;

  int currentTruckIndex = 0;

  SubPartViewModel({
    required this.provider,
    required this.config,
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

  void onModelSelected(String id, BuildContext context) {}
}
