import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:help_my_truck/main.dart';

abstract class AppConsts {
  static const String pathToConnectServer = kDebugMode || flavor == 'Firebase'
      ? 'https://graphql.contentful.com/content/v1/spaces/k5pf3rtqc5px/environments/develop'
      : 'https://graphql.contentful.com/content/v1/spaces/k5pf3rtqc5px/environments/master';

  static const String accessToken = kDebugMode || flavor == 'Firebase'
      ? 'Bearer DBSmrNo64KHraOylV1gVv36GXHjKlUdaPbOAbywqDZQ'
      : 'Bearer 0-QdA21PQJqJVGA1P2hB6yAyCxHJ_64ZR3m-bUlscZc';

  static EdgeInsets componentObserverPadding({required bool isNeedTop}) {
    return EdgeInsets.fromLTRB(12, isNeedTop ? 24 : 0, 12, 24);
  }
}
