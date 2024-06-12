import 'package:flutter/material.dart';
import 'package:help_my_truck/data/models/child_problem.dart';
import 'package:help_my_truck/data/models/contentfull_entnities.dart';
import 'package:help_my_truck/data/models/fault.dart';
import 'package:help_my_truck/data/models/part.dart';
import 'package:help_my_truck/data/models/subpart.dart';
import 'package:help_my_truck/services/API/favorites_provider.dart';
import 'package:help_my_truck/services/API/vehicle_provider.dart';
import 'package:rxdart/rxdart.dart';

import '../../widgets/nav_bar/nav_bar_page.dart';
import '../vehicle_navigation_helper.dart';

class SubPartViewModel {
  final VehicleProvider provider;
  final FavoritesProvider favoritesProvider;
  final ChildSubpart config;

  late final part = BehaviorSubject<SubPart>()
    ..addStream(Stream.fromFuture(provider.subPart(config.id)));

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
    required this.favoritesProvider,
  });

  void onSearch(BuildContext context) {
    VehicleNavigationHelper.navigateTo(NavBarPage.search, context, true);
  }

  void onModelSelected(String id, BuildContext context) {}
}
