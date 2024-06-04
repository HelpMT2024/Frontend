import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:help_my_truck/data/models/child_type.dart';
import 'package:help_my_truck/data/models/favorite_model_type.dart';
import 'package:help_my_truck/data/models/unit.dart';
import 'package:help_my_truck/services/API/favorites_provider.dart';
import 'package:help_my_truck/services/API/vehicle_provider.dart';

class FavoriteContentfulModel {
  final String id;
  final String name;
  final FavoriteModelType type;

  FavoriteContentfulModel(
      {required this.id, required this.name, required this.type});

  factory FavoriteContentfulModel.fromJson(Map<String, dynamic> json) =>
      FavoriteContentfulModel(
        id: json["id"],
        name: json["name"],
        type: json["type"],
      );
}

class FavoritesScreenViewModel {
  final FavoritesProvider provider;
  final VehicleProvider vehicleProvider;
  final updateDataStreamController =
      StreamController<List<FavoritesListItem>>.broadcast();
  final int _cellsPerPage = 10;

  UserInfoModel? user;
  List<FavoritesListItem> fetchedItems = [];
  List<FavoriteContentfulModel> filtered = [];
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

    await provider.favoritesList(user!.id, typeFilter, 1, 1);
    
    await provider.favoritesList(user!.id, typeFilter, _page, _cellsPerPage).then((value) {
      fetchedItems.addAll(value.items);
      pagination = value.pagination;
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

  void handleClick(FavoriteContentfulModel model, BuildContext context) {
    switch (model.type) {
      case FavoriteModelType.unit:
        final child = ChildrenSystem(
            id: model.id,
            name: model.name,
            image: null,
            types: [ChildType.standart]);
        Navigator.of(context).pushNamed(child.name);
      case FavoriteModelType.system:
        final child = ChildrenSystem(
            id: model.id,
            name: model.name,
            image: null,
            types: [ChildType.standart]);
        Navigator.of(context).pushNamed(child.name);
      case FavoriteModelType.component:
        final child = ChildrenSystem(
            id: model.id,
            name: model.name,
            image: null,
            types: [ChildType.standart]);
        Navigator.of(context).pushNamed(child.name);
      case FavoriteModelType.part:
        final child = ChildrenSystem(
            id: model.id,
            name: model.name,
            image: null,
            types: [ChildType.standart]);
        Navigator.of(context).pushNamed(child.name);
      case FavoriteModelType.subPart:
        final child = ChildrenSystem(
            id: model.id,
            name: model.name,
            image: null,
            types: [ChildType.standart]);
        Navigator.of(context).pushNamed(child.name);
      case FavoriteModelType.faultCode:
        final child = ChildrenSystem(
            id: model.id,
            name: model.name,
            image: null,
            types: [ChildType.standart]);
        Navigator.of(context).pushNamed(child.name);
      case FavoriteModelType.problemCase:
        final child = ChildrenSystem(
            id: model.id,
            name: model.name,
            image: null,
            types: [ChildType.standart]);
        Navigator.of(context).pushNamed(child.name);
    }
  }
}
