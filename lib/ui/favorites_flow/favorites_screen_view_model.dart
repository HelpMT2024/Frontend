import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:help_my_truck/data/models/child_type.dart';
import 'package:help_my_truck/data/models/unit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:help_my_truck/services/API/favorites_provider.dart';
import 'package:help_my_truck/services/API/vehicle_provider.dart';

enum FavoriteModelTypes {
  unit,
  system,
  component,
  part,
  subPart,
  faultCode,
  problemCase,
}

extension FavoriteModelTypesExtension on FavoriteModelTypes {
  String title(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    switch (this) {
      case FavoriteModelTypes.unit:
        return l10n?.favorites_item_type_units ?? '';
      case FavoriteModelTypes.system:
        return l10n?.favorites_item_type_systems ?? '';
      case FavoriteModelTypes.component:
        return l10n?.favorites_item_type_components ?? '';
      case FavoriteModelTypes.part:
        return l10n?.favorites_item_type_parts ?? '';
      case FavoriteModelTypes.subPart:
        return l10n?.favorites_item_type_sub_parts ?? '';
      case FavoriteModelTypes.faultCode:
        return l10n?.favorites_item_type_fault_codes ?? '';
      case FavoriteModelTypes.problemCase:
        return l10n?.favorites_item_type_problem_cases ?? '';
    }
  }
}

class FavoriteContentfulModel {
  final String id;
  final String name;
  final FavoriteModelTypes type;

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
  final updateDataStreamController = StreamController<List<FavoritesListItem>>.broadcast();
  final int _cellsPerPage = 10;

  // late final user = BehaviorSubject<UserInfoModel>()
  //   ..addStream(Stream.fromFuture(provider.user()));

  // late final page = BehaviorSubject<Future<FavoritesListModel>>()
  //   ..addStream(user.map((user) {

  //     return provider.favoritesList(user.id, _page);
  //   }));

  UserInfoModel? user;
  List<FavoritesListItem> pageItems = [];
  List<FavoritesListItem> fetchedItems = [];
  FavoriteModelTypes _selectedFilter = FavoriteModelTypes.unit;
  Pagination? pagination;
  bool isLastPage = false;

  int _page = 1;

  FavoritesScreenViewModel({
    required this.provider,
    required this.vehicleProvider,
  });

  //request
  void getPage() async {
    user = await provider.user();

    await provider
        .favoritesList(user!.id, _page, _cellsPerPage)
        .then((value) {
          fetchedItems.addAll(value.items);
          pagination = value.pagination;
          updateDataStreamController.add(fetchedItems);
        });
    filterItems();
    handlePagination();
  }

  void handlePagination() {
    _page += 1;
    isLastPage = pagination?.pages == pagination?.page;
  }

  void filterItems() {
    fetchedItems.map((e) => 
      switch (_selectedFilter) {
        FavoriteModelTypes.unit => {     
          print('VEHICLEPROVIDER ${vehicleProvider.unit(e.integrationId)}',),
        },
        FavoriteModelTypes.system => {

        },
        FavoriteModelTypes.component => {

        },
        FavoriteModelTypes.part => {

        },
        FavoriteModelTypes.subPart => {

        },
        FavoriteModelTypes.faultCode => {

        },
        FavoriteModelTypes.problemCase => {

        },
      }
    );
  }

  void handleTabButtonClick() {

  }

  void handleClick(FavoriteContentfulModel model, BuildContext context) {
    switch (model.type) {
      case FavoriteModelTypes.unit:
        final child = ChildrenSystem(
            id: model.id,
            name: model.name,
            image: null,
            types: [ChildType.standart]);
        Navigator.of(context).pushNamed(child.name);
      case FavoriteModelTypes.system:
        final child = ChildrenSystem(
            id: model.id,
            name: model.name,
            image: null,
            types: [ChildType.standart]);
        Navigator.of(context).pushNamed(child.name);
      case FavoriteModelTypes.component:
        final child = ChildrenSystem(
            id: model.id,
            name: model.name,
            image: null,
            types: [ChildType.standart]);
        Navigator.of(context).pushNamed(child.name);
      case FavoriteModelTypes.part:
        final child = ChildrenSystem(
            id: model.id,
            name: model.name,
            image: null,
            types: [ChildType.standart]);
        Navigator.of(context).pushNamed(child.name);
      case FavoriteModelTypes.subPart:
        final child = ChildrenSystem(
            id: model.id,
            name: model.name,
            image: null,
            types: [ChildType.standart]);
        Navigator.of(context).pushNamed(child.name);
      case FavoriteModelTypes.faultCode:
        final child = ChildrenSystem(
            id: model.id,
            name: model.name,
            image: null,
            types: [ChildType.standart]);
        Navigator.of(context).pushNamed(child.name);
      case FavoriteModelTypes.problemCase:
        final child = ChildrenSystem(
            id: model.id,
            name: model.name,
            image: null,
            types: [ChildType.standart]);
        Navigator.of(context).pushNamed(child.name);
    }
  }

  // List<FavoriteContentfulModel> _favoritesFromUnits(List<Unit> units) {
  //   return units.map (event) {
  //     FavoriteContentfulModel(event.id, event.name, FavoriteModelTypes.unit);
  //   };
  // }

  // List<FavoriteContentfulModel> _favoritesFromSystems(List<System> systems) {
  //   return systems.map (event) {
  //     FavoriteContentfulModel(event.id, event.name, Type.systems);
  //   };
  // }
}
