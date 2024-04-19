import 'package:flutter/material.dart';
import 'package:help_my_truck/const/colors.dart';

PreferredSize mainNavigationBarBottom({
  required BuildContext context,
  required String title,
}) {
  final styles = Theme.of(context).textTheme;

  return PreferredSize(
    preferredSize: const Size(double.infinity, 30),
    child: Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(width: 16),
          Text(
            title,
            textAlign: TextAlign.left,
            style: styles.titleLarge?.merge(
              TextStyle(color: ColorConstants.onSurfaceWhite),
            ),
          ),
        ],
      ),
    ),
  );
}
