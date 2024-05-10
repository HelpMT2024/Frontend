import 'package:flutter/material.dart';

abstract class AppConsts {
  static const String pathToConnectServer =
      'https://graphql.contentful.com/content/v1/spaces/k5pf3rtqc5px/environments/develop';
  static const String accessToken =
      'Bearer DBSmrNo64KHraOylV1gVv36GXHjKlUdaPbOAbywqDZQ';

  static EdgeInsets componentObserverPadding({required bool isNeedTop}) {
    return EdgeInsets.fromLTRB(
      12,
      isNeedTop ? 24 : 0,
      12,
      24,
    );
  }
}
