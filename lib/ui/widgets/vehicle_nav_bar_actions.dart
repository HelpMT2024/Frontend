import 'dart:io';

import 'package:flutter/material.dart';
import 'package:help_my_truck/const/colors.dart';
import 'package:share_plus/share_plus.dart';

class VehicleNavBarActions extends StatelessWidget {
  final bool hideBookmark;

  const VehicleNavBarActions({
    super.key,
    this.hideBookmark = false,
  });

  _openAppPage() {
    String stringUrl;
    if (Platform.isAndroid) {
      stringUrl =
          'https://app.contentful.com/spaces/k5pf3rtqc5px/environments/develop/views/assets';
    } else {
      stringUrl =
          'https://app.contentful.com/spaces/k5pf3rtqc5px/environments/develop/views/assets';
    }

    Uri url = Uri.parse(stringUrl);
    Share.shareUri(url);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: Icon(
            Icons.ios_share_rounded,
            color: ColorConstants.onSurfaceWhite,
          ),
          onPressed: _openAppPage,
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
