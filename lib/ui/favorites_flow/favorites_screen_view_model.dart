import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:help_my_truck/data/models/child_type.dart';
import 'package:help_my_truck/data/models/unit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:help_my_truck/services/API/favorites_provider.dart';
import 'package:help_my_truck/services/API/vehicle_provider.dart';

enum FavoriteModelType {
  unit,
  system,
  component,
  part,
  subPart,
  faultCode,
  problemCase,
}

extension FavoriteModelTypesExtension on FavoriteModelType {
  FavoriteModelType getTypeBy(String name) {
    return FavoriteModelTypesExtension.itemType[name] ?? FavoriteModelType.unit;
  }

  static Map<String, FavoriteModelType> itemType = {
    "Units": FavoriteModelType.unit,
    "Systems": FavoriteModelType.system,
    "Component": FavoriteModelType.component,
    "Parts": FavoriteModelType.part,
    "Sub Parts": FavoriteModelType.subPart,
    "Fault Code": FavoriteModelType.faultCode,
    "Problem Case": FavoriteModelType.problemCase,
  };

  String title(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    switch (this) {
      case FavoriteModelType.unit:
        return l10n?.favorites_item_type_units ?? '';
      case FavoriteModelType.system:
        return l10n?.favorites_item_type_systems ?? '';
      case FavoriteModelType.component:
        return l10n?.favorites_item_type_components ?? '';
      case FavoriteModelType.part:
        return l10n?.favorites_item_type_parts ?? '';
      case FavoriteModelType.subPart:
        return l10n?.favorites_item_type_sub_parts ?? '';
      case FavoriteModelType.faultCode:
        return l10n?.favorites_item_type_fault_codes ?? '';
      case FavoriteModelType.problemCase:
        return l10n?.favorites_item_type_problem_cases ?? '';
    }
  }

  String filterKey() {
    switch (this) {
      case FavoriteModelType.unit:
        return 'unit';
      case FavoriteModelType.system:
        return 'system';
      case FavoriteModelType.component:
        return 'component';
      case FavoriteModelType.part:
        return 'part';
      case FavoriteModelType.subPart:
        return 'sub_part';
      case FavoriteModelType.faultCode:
        return 'fault_code';
      case FavoriteModelType.problemCase:
        return 'problem_case';
    }
  }
}

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

  int _page = 1;

  FavoritesScreenViewModel({
    required this.provider,
    required this.vehicleProvider,
  });

  void getPage(FavoriteModelType filter) async {
    user = await provider.user();
    var typeFilter = selectedFilter.filterKey();
    
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
    getPage(selectedFilter);
  }

  void handlePagination() {
    _page += 1;
    isLastPage = pagination?.pages == pagination?.page;
  }

  void handleTabButtonClick(int filter) {

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
