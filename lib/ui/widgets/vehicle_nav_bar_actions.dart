import 'package:flutter/material.dart';
import 'package:help_my_truck/const/colors.dart';

class VehicleNavBarActions extends StatelessWidget {
  final bool hideBookmark;

  const VehicleNavBarActions({
    super.key,
    this.hideBookmark = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: Icon(
            Icons.ios_share_rounded,
            color: ColorConstants.onSurfaceWhite,
          ),
          onPressed: () {},
        ),
        if (!hideBookmark)
          IconButton(
            icon: Icon(
              Icons.bookmark_border_outlined,
              color: ColorConstants.onSurfaceWhite,
            ),
            onPressed: () {},
          ),
      ],
    );
  }
}
