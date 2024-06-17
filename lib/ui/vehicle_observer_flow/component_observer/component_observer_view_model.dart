import 'package:flutter/material.dart';
import 'package:help_my_truck/data/models/child_problem.dart';
import 'package:help_my_truck/data/models/component.dart';
import 'package:help_my_truck/data/models/contentfull_entnities.dart';
import 'package:help_my_truck/data/models/fault.dart';
import 'package:help_my_truck/data/models/system.dart';
import 'package:help_my_truck/services/API/item_provider.dart';
import 'package:help_my_truck/services/API/vehicle_provider.dart';
import 'package:help_my_truck/services/router/vehicle_selector_router.dart';
import 'package:help_my_truck/ui/vehicle_observer_flow/vehicle_navigation_helper.dart';
import 'package:help_my_truck/ui/widgets/nav_bar/nav_bar_page.dart';
import 'package:rxdart/subjects.dart';

class ComponentObserverViewModel {
  final VehicleProvider provider;
  final ItemProvider itemProvider;
  final ChildrenComponent config;

  late final component = BehaviorSubject<Component>()
    ..addStream(
      Stream.fromFuture(provider.component(config.id)),
    );

  List<ChildFault> get faults => component.valueOrNull?.faults ?? [];
  bool get hasFaults => faults.isNotEmpty;
  bool get hasImage => component.valueOrNull?.imageView != null;
  List<IDPVideo> get videos => component.valueOrNull?.videos ?? [];
  bool get hasVideos => videos.isNotEmpty;
  List<ChildWarningLight> get warnings =>
      component.valueOrNull?.warningLights ?? [];
  bool get hasWarnings => warnings.isNotEmpty;
  List<ChildProblem> get problems => component.valueOrNull?.problems ?? [];
  bool get hasProblems => problems.isNotEmpty;
  bool get hasDescription => component.valueOrNull?.description != null;
  List<PdfFile> get pdfFiles => component.valueOrNull?.pdfFiles.items ?? [];
  bool get hasPDF => pdfFiles.isNotEmpty;

  ComponentObserverViewModel({
    required this.config,
    required this.provider,
    required this.itemProvider
  });

  void onSearch(BuildContext context) {
    VehicleNavigationHelper.navigateTo(NavBarPage.search, context, true);
  }

  void onModelSelected(String id, BuildContext context) {
    final model = component.value.children.firstWhere(
      (element) => element.id == id,
    );

    Navigator.of(context).pushNamed(
      VehicleSelectorRouteKeys.partObserver,
      arguments: model,
    );
  }
}
