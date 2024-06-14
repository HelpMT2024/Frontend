import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:help_my_truck/data/models/child_problem.dart';
import 'package:help_my_truck/data/models/child_type.dart';
import 'package:help_my_truck/data/models/component.dart';
import 'package:help_my_truck/data/models/configuration.dart';
import 'package:help_my_truck/data/models/fault.dart';
import 'package:help_my_truck/data/models/favorite_model_type.dart';
import 'package:help_my_truck/data/models/part.dart';
import 'package:help_my_truck/data/models/system.dart';
import 'package:help_my_truck/data/models/unit.dart';
import 'package:help_my_truck/services/API/favorites_provider.dart';
import 'package:help_my_truck/services/API/vehicle_provider.dart';
import 'package:help_my_truck/services/router/faults_router.dart';
import 'package:help_my_truck/services/router/vehicle_selector_router.dart';
import 'package:rxdart/rxdart.dart';

class FavoritesScreenViewModel {
  final FavoritesProvider provider;
  final VehicleProvider vehicleProvider;
  final int _cellsPerPage = 10;
  late final isLoading = BehaviorSubject<bool>.seeded(false);
  var updateDataStreamController = StreamController<List<FavoritesListItem>>();
  List<FavoritesListItem> fetchedItems = [];
  FavoriteModelType currentFilter = FavoriteModelType.unit;
  Pagination? pagination;
  UserInfoModel? user;
  bool isLastPage = false;

  int _page = 1;

  FavoritesScreenViewModel({
    required this.provider,
    required this.vehicleProvider,
  });

  void getPage() async {
    isLoading.add(true);
    var typeFilters = currentFilter.filterKeys();
    user = await provider.user();
    await provider
        .favoritesList(user!.id, typeFilters, _page, _cellsPerPage)
        .then((page) async {
      await Future.wait(
        page.items.map((item) async {
          item.name = await itemTitle(item.integrationId);
          return item;
        }).toList(),
      );
      fetchedItems.addAll(page.items);
      pagination = page.pagination;
    });
    _handlePagination();
    updateDataStreamController.add(fetchedItems);
    isLoading.add(false);
  }

  void resetData() {
    _page = 1;
    fetchedItems.clear();
    updateDataStreamController = StreamController<List<FavoritesListItem>>();
    getPage();
  }

  void _handlePagination() {
    _page += 1;
    isLastPage = pagination?.pages == pagination?.page;
  }

  Future<String> itemTitle(String id) async {
    switch (currentFilter) {
      case FavoriteModelType.unit:
        return vehicleProvider.unit(id).then((unit) => unit.name);
      case FavoriteModelType.system:
        return vehicleProvider.system(id).then((system) => system.name);
      case FavoriteModelType.component:
        return vehicleProvider
            .component(id)
            .then((component) => component.name);
      case FavoriteModelType.part:
        return vehicleProvider.part(id).then((part) => part.name);
      case FavoriteModelType.subPart:
        return vehicleProvider.subPart(id).then((subPart) => subPart.name);
      case FavoriteModelType.faultCode:
        return vehicleProvider.fault(id).then((fault) {
          final fmiCodes =
              fault.fmiCodes.toString().replaceAll(']', '').replaceAll('[', '');

          return 'SPN ${fault.spnCode}, FMI $fmiCodes';
        });
      case FavoriteModelType.problemCase:
        return vehicleProvider
            .problemCase(id)
            .then((problemCase) => problemCase.name);
    }
  }

  void handleClick(FavoritesListItem model, BuildContext context) {
    switch (currentFilter) {
      case FavoriteModelType.unit:
        final child = ChildrenUnit(
          id: model.integrationId,
          name: model.name ?? '',
          image: null,
        );
        Navigator.of(context)
            .pushNamed(
          VehicleSelectorRouteKeys.unitObserver,
          arguments: child,
        )
            .then((value) {
          resetData();
        });
      case FavoriteModelType.system:
        final driverDisplayTypeKey =
            FavoriteModelSubType.driverDisplay.filterKey();
        final child = ChildrenSystem(
          id: model.integrationId,
          name: model.name ?? '',
          image: null,
          types: [],
        );
        String routeKey;
        if (model.type == driverDisplayTypeKey) {
          routeKey = VehicleSelectorRouteKeys.driverCabin;
        } else {
          routeKey = VehicleSelectorRouteKeys.systemObserver;
        }
        Navigator.of(context)
            .pushNamed(
          routeKey,
          arguments: child,
        )
            .then((value) {
          resetData();
        });
      case FavoriteModelType.component:
        final warningsTypeKey = FavoriteModelSubType.warningLights.filterKey();
        final child = ChildrenComponent(
          id: model.integrationId,
          name: model.name ?? '',
          image: null,
          type: ChildType.standart,
        );
        String routeKey;
        if (model.type == warningsTypeKey) {
          routeKey = FaultsRouteKeys.warningScreen;
        } else {
          routeKey = VehicleSelectorRouteKeys.componentObserver;
        }
        Navigator.of(context)
            .pushNamed(
          routeKey,
          arguments: child,
        )
            .then((value) {
          resetData();
        });
      case FavoriteModelType.part:
        final child = ChildrenPart(
          id: model.integrationId,
          name: model.name ?? '',
          image: null,
        );
        Navigator.of(context)
            .pushNamed(
          VehicleSelectorRouteKeys.partObserver,
          arguments: child,
        )
            .then((value) {
          resetData();
        });
      case FavoriteModelType.subPart:
        final child = ChildSubpart(
          id: model.integrationId,
          name: model.name ?? '',
          image: null,
        );
        Navigator.of(context)
            .pushNamed(
          VehicleSelectorRouteKeys.subPartObserver,
          arguments: child,
        )
            .then((value) {
          resetData();
        });
      case FavoriteModelType.faultCode:
        final child = ChildFault(
          id: model.integrationId,
          spnCode: model.name ?? '',
          fmiCodes: [],
          showAsPdf: false,
        );
        Navigator.of(context)
            .pushNamed(
          FaultsRouteKeys.faultScreen,
          arguments: child,
        )
            .then((value) {
          resetData();
        });
      case FavoriteModelType.problemCase:
        final child = ChildProblem(
          id: model.integrationId,
          name: model.name ?? '',
        );
        Navigator.of(context)
            .pushNamed(
          FaultsRouteKeys.problemCaseScreen,
          arguments: child,
        )
            .then((value) {
          resetData();
        });
    }
  }
}
