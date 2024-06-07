import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:help_my_truck/const/colors.dart';

PreferredSize mainNavigationBarBottom({
  required BuildContext context,
  required String title,
  required Color backgroundColor,
}) {
  final styles = Theme.of(context).textTheme;

  return PreferredSize(
    preferredSize: const Size(double.infinity, 39),
    child: Container(
      padding: const EdgeInsets.only(left: 12),
      decoration: BoxDecoration(
        color: backgroundColor,
        boxShadow: [
          BoxShadow(
            spreadRadius: 1,
            color: backgroundColor,
          ),
        ],
      ),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Text(
          title,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          textAlign: TextAlign.left,
          style: styles.titleLarge?.copyWith(
            color: ColorConstants.onSurfaceWhite,
          ),
        ),
      ),
    ),
  );
}
