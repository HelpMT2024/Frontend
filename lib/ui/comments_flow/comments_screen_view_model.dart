import 'dart:async';

import 'package:flutter/material.dart';
import 'package:help_my_truck/services/API/item_provider.dart';
import 'package:help_my_truck/services/router/router.dart';
import 'package:rxdart/rxdart.dart';

class CommentsScreenViewModel {
  final int? contentfulId;
  final itemProvider = ItemProvider(restAPIService, graphQLService);

  final int _cellsPerPage = 10;
  late final isLoading = BehaviorSubject<bool>.seeded(false);
  bool isLastPage = false;
  int _page = 1;

  late final commentsList = BehaviorSubject<CommentsListModel>()
    ..addStream(Stream.fromFuture(
        itemProvider.commentsList(contentfulId!, null, _page, _cellsPerPage)));

  CommentsScreenViewModel({
    required this.contentfulId,
  });

  Future<void> addComment(String text) async {
    if (contentfulId != null && !isLoading.value) {
      isLoading.add(true);
      await itemProvider.addComment(contentfulId!, text);
      isLoading.add(false);
      resetData();
      return;
    }
  }

  void sendReport(
      int contentfulId, int commentId, VoidCallback callback) async {
    if (!isLoading.value) {
      isLoading.add(true);
      await itemProvider.report(contentfulId, commentId).then((value) {
        isLoading.add(false);
        callback();
      });
    }
  }

  void getPage() async {
    if (!isLoading.value) {
      isLoading.add(true);
      _page++;
      final commentPage = await itemProvider.commentsList(
        contentfulId!,
        null,
        _page,
        _cellsPerPage,
      );

      isLastPage = _page == commentPage.pagination.pages;
      var tempValue = commentsList.value;
      tempValue.items.addAll(commentPage.items);
      isLoading.add(false);
      commentsList.add(tempValue);
    }
  }

  void resetData() {
    _page = 0;
    var tempValue = commentsList.value;
    tempValue.items.clear;
    isLoading.add(false);
    commentsList.add(tempValue);
    isLoading.add(false);
    getPage();
  }

  void checkIfLastPage(CommentsListModel data) {
    if (data.pagination.page == data.pagination.pages) {
      isLastPage = true;
    }
  }
}
