import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:help_my_truck/data/models/child_type.dart';
import 'package:help_my_truck/data/models/unit.dart';
import 'package:help_my_truck/services/API/favorites_provider.dart';
import 'package:help_my_truck/services/API/vehicle_provider.dart';
import 'package:rxdart/rxdart.dart';

enum FavoriteModelTypes {
  unit,
  system,
  component,
  part,
  faultCode,
  problemCase,
}

class FavoriteContentfulModel {
  final String id;
  final String name;
  final FavoriteModelTypes type;

  FavoriteContentfulModel({required this.id, required this.name, required this.type});

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
  final int _cellsPerPage = 5;
  FavoriteModelTypes _selectedFilter = FavoriteModelTypes.unit;

  late final user = BehaviorSubject<UserInfoModel>()
    ..addStream(Stream.fromFuture(provider.user()));

  late final page = BehaviorSubject<Future<FavoritesListModel>>()
    ..addStream(user.map((user) {

      return provider.favoritesList(user.id, _page);
    }));

  List<FavoritesListItem>? pageItems;
  List<FavoritesListItem> fetchedItems = [];
  final updateDataStreamController =
      StreamController<List<FavoritesListItem>>();

  int _page = 1;

  FavoritesScreenViewModel({required this.provider, required this.vehicleProvider,});

  //fetching to list items
  void fetch(List<FavoritesListItem> items) {
    fetchedItems.addAll(items);
    updateDataStreamController.add(fetchedItems);
  }
  
  //request
  void loadNextPage() {
    // user
    // .map((user) => provider.favoritesList(user.id, _page))
    // .map((favorites) => switch (_selectedFilter) {
    //   case FavoriteModelTypes.unit:
    //     final signals = favorites.map((favorite){ vehicleProvider.unit(favorite.id) });
    //     final resutls = await Future.wait(signals);

    //     return _favoritesFromSystems(results);
    //   case FavoriteModelTypes.system:
    //   ,
    //   case FavoriteModelTypes.component:

    //   case FavoriteModelTypes.part:

    //   case FavoriteModelTypes.faultCode:

    //   case FavoriteModelTypes.problemCase:

    // }
    // );
      
      // case system:
      // final signals = favorites.map { vehicleProvider.system(id: $0.id) }
      // final resutls = await Future.wait(signals);

      // return _favoritesFromSystems(results)
      // case unit:
      // final signals = favorites.map { vehicleProvider.system(id: $0.id) }
      // final resutls = await Future.wait(signals);

      // return _favoritesFromSystems(results)

  }

  void handleClick(FavoriteContentfulModel model, BuildContext context) {
    switch (model.type) {
      case FavoriteModelTypes.unit:
        final child = ChildrenSystem(id: model.id, name: model.name, image: null, types: [ChildType.standart]);
        Navigator.of(context).pushNamed(child.name);
      case FavoriteModelTypes.system:
        final child = ChildrenSystem(id: model.id, name: model.name, image: null, types: [ChildType.standart]);
        Navigator.of(context).pushNamed(child.name);
      case FavoriteModelTypes.component:
        final child = ChildrenSystem(id: model.id, name: model.name, image: null, types: [ChildType.standart]);
        Navigator.of(context).pushNamed(child.name);
      case FavoriteModelTypes.part:
        final child = ChildrenSystem(id: model.id, name: model.name, image: null, types: [ChildType.standart]);
        Navigator.of(context).pushNamed(child.name);
      case FavoriteModelTypes.faultCode:
        final child = ChildrenSystem(id: model.id, name: model.name, image: null, types: [ChildType.standart]);
        Navigator.of(context).pushNamed(child.name);
      case FavoriteModelTypes.problemCase:
        final child = ChildrenSystem(id: model.id, name: model.name, image: null, types: [ChildType.standart]);
        Navigator.of(context).pushNamed(child.name);
    }
  }

  // List<FavoriteContentfulModel> _favoritesFromSystems(List<System> systems) {
  //   return systems.map (event) {
  //     FavoriteModel(event.id, event.name, Type.systems)
  //   }
  // }
}
