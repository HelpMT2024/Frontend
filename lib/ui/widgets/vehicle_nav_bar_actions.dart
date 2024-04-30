import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:help_my_truck/const/colors.dart';

class VehicleNavBarActions extends StatelessWidget {
  final bool hideBookmark;

  const VehicleNavBarActions({
    super.key,
    this.hideBookmark = false,
  });

  _openAppPage() {
    String stringUrl;
    if (Platform.isAndroid) {
      stringUrl = 'https://play.google.com/store/apps/details?id=com.duolingo';
    } else {
      stringUrl =
          'https://apps.apple.com/ua/app/duolingo-languages-more/id570060128';
    }

    Uri url = Uri.parse(stringUrl);
    _launchURL(url);
  }

  void _launchURL(Uri url) async {
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
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
