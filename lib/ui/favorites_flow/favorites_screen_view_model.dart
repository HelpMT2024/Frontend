import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:help_my_truck/data/models/child_problem.dart';
import 'package:help_my_truck/data/models/child_type.dart';
import 'package:help_my_truck/data/models/component.dart';
import 'package:help_my_truck/data/models/configuration.dart';
import 'package:help_my_truck/data/models/fault.dart';
import 'package:help_my_truck/data/models/favorite_model_type.dart';
import 'package:help_my_truck/data/models/system.dart';
import 'package:help_my_truck/data/models/unit.dart';
import 'package:help_my_truck/services/API/favorites_provider.dart';
import 'package:help_my_truck/services/API/vehicle_provider.dart';
import 'package:help_my_truck/services/router/faults_router.dart';
import 'package:help_my_truck/services/router/vehicle_selector_router.dart';

class FavoritesScreenViewModel {
  final FavoritesProvider provider;
  final VehicleProvider vehicleProvider;
  final updateDataStreamController =
      StreamController<List<FavoritesListItem>>.broadcast();
  final int _cellsPerPage = 10;

  UserInfoModel? user;
  List<FavoritesListItem> fetchedItems = [];
  FavoriteModelType selectedFilter = FavoriteModelType.unit;
  Pagination? pagination;
  bool isLastPage = false;
  bool isFavoritesExists = false;

  int _page = 1;

  FavoritesScreenViewModel({
    required this.provider,
    required this.vehicleProvider,
  });

  void getPage() async {
    var typeFilter = selectedFilter.filterKey();
    user = await provider.user();
    await provider
        .favoritesList(user!.id, typeFilter, _page, _cellsPerPage)
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
    handlePagination();
    updateDataStreamController.add(fetchedItems);
  }

  void resetData() {
    _page = 1;
    fetchedItems.clear();
    getPage();
  }

  void handlePagination() {
    _page += 1;
    isLastPage = pagination?.pages == pagination?.page;
  }

  void handleTabButtonClick(int index) {
    selectedFilter = FavoriteModelType.values[index];
    resetData();
  }

  Future<String> itemTitle(String id) async {
    switch (selectedFilter) {
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
        return vehicleProvider.fault(id).then((fault) => 'SPN ${fault.spnCode}, FMI ${fault.spnCode}');
      case FavoriteModelType.problemCase:
        return vehicleProvider
            .problemCase(id)
            .then((problemCase) => problemCase.name);
    }
  }

  void handleClick(FavoritesListItem model, BuildContext context) {
    switch (selectedFilter) {
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
        final child = ChildrenSystem(
          id: model.integrationId,
          name: model.name ?? '',
          image: null,
          types: [],
        );
        Navigator.of(context)
            .pushNamed(
          VehicleSelectorRouteKeys.systemObserver,
          arguments: child,
        )
            .then((value) {
          resetData();
        });
      case FavoriteModelType.component:
        final child = ChildrenComponent(
          id: model.integrationId,
          name: model.name ?? '',
          image: null,
          type: ChildType.standart,
        );
        Navigator.of(context)
            .pushNamed(
          VehicleSelectorRouteKeys.componentObserver,
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
        final child = ChildrenPart(
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
