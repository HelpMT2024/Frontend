// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:help_my_truck/const/colors.dart';
import 'package:help_my_truck/services/API/favorites_provider.dart';

class BookmarkButton extends StatefulWidget {
  FavoritesProvider? provider;
  int? id;

  BookmarkButton(this.id, this.provider, {super.key});

  @override
  State<BookmarkButton> createState() => _BookmarkButtonState();
}

class _BookmarkButtonState extends State<BookmarkButton> {
  var _isBookmarked;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        _isBookmarked
        ? Icons.bookmark_border_outlined
        : Icons.bookmark_border,
        color: ColorConstants.onSurfaceWhite,
      ),
      onPressed: () {
        setState(() {
          _isBookmarked = !_isBookmarked;
        });
        widget.provider?.change(widget.id ?? 0);
      },
    );
  }
}
