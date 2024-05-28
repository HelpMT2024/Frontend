import 'dart:async';

import 'package:help_my_truck/services/API/favorites_provider.dart';
import 'package:rxdart/rxdart.dart';

class FavoritesScreenViewModel {
  final FavoritesProvider provider;
  final int _cellsPerPage = 5;

  late final user = BehaviorSubject<UserInfoModel>()
    ..addStream(Stream.fromFuture(provider.user()));

  late final page = BehaviorSubject<Future<FavoritesListModel>>()
    ..addStream(user.map((user) {

      return provider.favoritesList(user.id);
    }));

  List<FavoritesListItem>? pageItems;
  List<FavoritesListItem> fetchedItems = [];
  final updateDataStreamController =
      StreamController<List<FavoritesListItem>>();

  int _page = 1;

  FavoritesScreenViewModel({required this.provider});

  //fetching to list items
  void fetch(List<FavoritesListItem> items) {
    fetchedItems.addAll(items);
    updateDataStreamController.add(fetchedItems);
  }

  //request
  void pagination() {
    // provider.user().then((user) {
    //   provider.favoritesList(user.id).then((list) => {
    //     pageItems = list.items,
    //     fetch(pageItems!)
    //   });
    // }).catchError((error) {
    //   print('error ${error.message}');
    // });
    // _page += 1;
  }
}
