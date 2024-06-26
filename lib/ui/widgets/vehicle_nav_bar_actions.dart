import 'dart:io';

import 'package:flutter/material.dart';
import 'package:help_my_truck/const/colors.dart';
import 'package:help_my_truck/services/API/favorites_provider.dart';
import 'package:help_my_truck/ui/widgets/bookmark_button.dart';
import 'package:share_plus/share_plus.dart';

class VehicleNavBarActions extends StatelessWidget {
  final String? integrationId;
  final String? type;
  final bool hideBookmark;
  final FavoritesProvider? provider;

  const VehicleNavBarActions({
    super.key,
    this.hideBookmark = false,
    this.integrationId,
    this.type,
    this.provider,
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          SizedBox(
            width: 32,
            child: IconButton(
              padding: EdgeInsets.zero,
              icon: Icon(
                Icons.ios_share_rounded,
                color: ColorConstants.onSurfaceWhite,
              ),
              onPressed: _openAppPage,
            ),
          ),
          const SizedBox(
            width: 4,
          ),
          if (!hideBookmark)
            SizedBox(
              width: 32,
              child: BookmarkButton(
                28,
                integrationId,
                type,
                provider,
                null,
                false,
              ),
            ),
        ],
      ),
    );
  }
}
