import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:help_my_truck/main.dart';

abstract class AppConsts {
  static const String pathToConnectServer = kDebugMode || flavor == 'Firebase'
      ? 'https://graphql.contentful.com/content/v1/spaces/k5pf3rtqc5px/environments/develop'
      : 'https://graphql.contentful.com/content/v1/spaces/k5pf3rtqc5px/environments/master';

  static const String accessToken = kDebugMode || flavor == 'Firebase'
      ? 'Bearer DBSmrNo64KHraOylV1gVv36GXHjKlUdaPbOAbywqDZQ'
      : 'Bearer Hj6XZHCOMZZ79G39-iWX-jASZ5joUn5CaXm5rC3v-vw';

  static final revenueCatApiKey = Platform.isAndroid
      ? 'goog_gQMueykzFjrmvsBSCAUkFUoDZEt'
      : 'appl_qjhiJWYvaUZWStmUmpDfsXcXDeV';

  static const revenueEntitlement = 'Main';

  static EdgeInsets componentObserverPadding({required bool isNeedTop}) {
    return EdgeInsets.fromLTRB(12, isNeedTop ? 16 : 0, 12, 24);
  }
}
