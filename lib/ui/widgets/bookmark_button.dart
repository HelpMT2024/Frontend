// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:help_my_truck/const/colors.dart';
import 'package:help_my_truck/services/API/favorites_provider.dart';

class BookmarkButton extends StatefulWidget {
  FavoritesProvider? provider;
  String? integrationId;

  BookmarkButton(this.integrationId, this.provider, {super.key});

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
    item = await widget.provider
        ?.itemWith(widget.integrationId ?? '')
        .then((value) => value);

    updateIconState();
  }

  void updateIconState() {
    setState(() {
      print('ITEM ISFAV ${item?.isFavorite}');
      _isBookmarked = item?.isFavorite ?? false;
    });
  }

  void changeIconState() {
    setState(() {
      _isBookmarked = !_isBookmarked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        _isBookmarked ? Icons.bookmark : Icons.bookmark_border_outlined,
        color: ColorConstants.onSurfaceWhite,
      ),
      onPressed: () {
        if (item != null) {
          widget.provider?.change(item?.id ?? 0);
          changeIconState();
        } else {
          final id = widget.integrationId;
          if (id != null) {
            widget.provider?.createContentfulItem(id);
            widget.provider?.change(item?.id ?? 0);
            changeIconState();
          }
        }
      },
    );
  }
}
