// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:help_my_truck/const/colors.dart';
import 'package:help_my_truck/services/API/favorites_provider.dart';

class BookmarkButton extends StatefulWidget {
  FavoritesProvider? provider;
  String? integrationId;
  String? type;
  final double size;
  final bool isFixedState;
  void Function(String)? voidCallback;

  BookmarkButton(
    this.size,
    this.integrationId,
    this.type,
    this.provider,
    this.voidCallback,
    this.isFixedState, {
    super.key,
  });

  @override
  State<BookmarkButton> createState() => _BookmarkButtonState();
}

class _BookmarkButtonState extends State<BookmarkButton> {
  var _isBookmarked = false;
  ContentfulItem? item;

  @override
  void initState() {
    checkInFavorites();

    super.initState();
  }

  void checkInFavorites() async {
    await loadItem();

    updateIconState();
  }

  Future<void> loadItem() async {
    item = await widget.provider
        ?.itemWith(widget.integrationId ?? '')
        .then((value) => value);
  }

  void updateIconState() {
    setState(() {
      _isBookmarked = item?.isFavorite ?? false;
    });
  }

  void changeIconState() {
    if (!widget.isFixedState) {
      setState(() {
        _isBookmarked = !_isBookmarked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      child: IconButton(
        iconSize: widget.size,
        alignment: Alignment.center,
        padding: EdgeInsets.zero,
        icon: Icon(
          _isBookmarked ? Icons.bookmark : Icons.bookmark_border_outlined,
          color: ColorConstants.onSurfaceWhite,
        ),
        onPressed: () {
          if (item != null) {
            widget.provider?.change(item?.id ?? 0);
            changeIconState();
          } else {
            final integrationId = widget.integrationId;
            final type = widget.type;
            if (integrationId != null && type != null) {
              widget.provider
                  ?.createContentfulItem(integrationId, type)
                  .then((value) {
                loadItem().then((value) {
                  widget.provider?.change(item?.id ?? 0);
                  changeIconState();
                });
              });
            }
          }

          final callback = widget.voidCallback;
          if (callback != null) {
            callback(widget.integrationId ?? '');
          }
        },
      ),
    );
  }
}
