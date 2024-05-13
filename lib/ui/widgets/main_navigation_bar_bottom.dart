import 'package:flutter/material.dart';
import 'package:help_my_truck/const/colors.dart';

PreferredSize mainNavigationBarBottom({
  required BuildContext context,
  required String title,
}) {
  final styles = Theme.of(context).textTheme;

  return PreferredSize(
    preferredSize: const Size(double.infinity, 35),
    child: Padding(
      padding: const EdgeInsets.fromLTRB(12, 0, 0, 14),
      child: Wrap(
        children: [
          Text(
            title,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            textAlign: TextAlign.left,
            style: styles.titleLarge?.copyWith(
              color: ColorConstants.onSurfaceWhite,
            ),
          ),
        ],
      ),
    ),
  );
}
