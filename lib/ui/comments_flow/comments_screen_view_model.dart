import 'dart:async';

import 'package:help_my_truck/services/API/item_provider.dart';
import 'package:help_my_truck/services/router/router.dart';
import 'package:rxdart/rxdart.dart';

class CommentsScreenViewModel {
  final int? contentfulId;
  final itemProvider = ItemProvider(restAPIService, graphQLService);

  final int _cellsPerPage = 10;
  late final isLoading = BehaviorSubject<bool>.seeded(false);
  var updateDataStreamController = StreamController<List<CommentsListItem>>();
  List<CommentsListItem> fetchedItems = [];
  Pagination? pagination;
  UserInfoModel? user;
  bool isLastPage = true;

  int _page = 1;

  CommentsScreenViewModel({
    required this.contentfulId,
  });

  void addComment(String text) async {
    if (contentfulId != null && !isLoading.value) {
      isLoading.add(true);
      await itemProvider.addComment(contentfulId!, text).then((value) {
        isLoading.add(false);
        resetData();
      });
    }
  }

  void sendReport(int contentfulId, int commentId) async {
    if (!isLoading.value) {
      isLoading.add(true);
      await itemProvider
          .report(contentfulId, commentId)
          .then((value) => isLoading.add(false));
    }
  }

  void getPage() async {
    if (!isLoading.value) {
      isLoading.add(true);
      user = await itemProvider.user();
      final page = await itemProvider.commentsList(
          contentfulId!, user!.id, _page, _cellsPerPage);
      // .then((page) => {
      fetchedItems.addAll(page.items);
      pagination = page.pagination;
      //     });
      _handlePagination();
      updateDataStreamController.add(fetchedItems);
      isLoading.add(false);
    }
  }

  void resetData() {
    _page = 1;
    fetchedItems.clear();
    updateDataStreamController = StreamController<List<CommentsListItem>>();
    isLoading.add(false);
    getPage();
  }

  void _handlePagination() {
    _page += 1;
    isLastPage = pagination?.pages == pagination?.page;
  }
}
