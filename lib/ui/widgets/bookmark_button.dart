// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:help_my_truck/const/colors.dart';
import 'package:help_my_truck/services/API/favorites_provider.dart';

class BookmarkButton extends StatefulWidget {
  FavoritesProvider? provider;
  ContentfulItem? item;
  final double size;
  final bool isFixedState;
  void Function(String)? voidCallback;

  BookmarkButton(
    this.size,
    this.item,
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

  @override
  void initState() {
    print('<!> ITEM ${widget.item}');
    updateIconState(widget.item?.isFavorite ?? false);

    super.initState();
  }

  void updateIconState(bool isFavorite) {
    setState(() {
      _isBookmarked = isFavorite;
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
          if (widget.item != null) {
            widget.provider?.change(widget.item?.id ?? 0);
            changeIconState();
          }
        },
      ),
    );
  }
}
