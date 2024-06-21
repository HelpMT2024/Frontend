// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:help_my_truck/const/colors.dart';
import 'package:help_my_truck/extensions/widget_error.dart';
import 'package:help_my_truck/services/API/item_provider.dart';

class BookmarkButton extends StatefulWidget {
  ItemProvider? provider;
  ContentfulItem? item;
  final int? contentfulId;
  final double size;
  final bool isInitMarked;

  BookmarkButton(
    this.size,
    this.item,
    this.contentfulId,
    this.provider,
    this.isInitMarked, {
    super.key,
  });

  @override
  State<BookmarkButton> createState() => _BookmarkButtonState();
}

class _BookmarkButtonState extends State<BookmarkButton> with ErrorHandable {
  var _isBookmarked = false;

  @override
  void initState() {
    updateIconState();
    super.initState();
  }

  void updateIconState() {
    setState(() {
      _isBookmarked =
          widget.isInitMarked ? true : widget.item?.isFavorite ?? false;
    });
  }

  void changeIconState() {
    setState(() {
      _isBookmarked = !_isBookmarked;
    });
  }

  void change(int id) {
    widget.provider?.change(id).catchError((error) {
        showAlertDialog(null, error.message);
      });
    changeIconState();
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
            change(widget.item?.id ?? 0);
          } else if (widget.contentfulId != null) {
            change(widget.contentfulId ?? 0);
          }
        },
      ),
    );
  }
}
