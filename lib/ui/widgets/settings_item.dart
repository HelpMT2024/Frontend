import 'package:flutter/material.dart';
import 'package:help_my_truck/const/colors.dart';

class SettingsItem extends StatelessWidget {
  final String title;
  final IconData? icon;
  final bool hasArrow;
  final VoidCallback onTap;

  const SettingsItem({
    super.key,
    required this.title,
    required this.icon,
    this.hasArrow = true,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final styles = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 48,
        padding: const EdgeInsets.fromLTRB(16, 12, 12, 12),
        decoration: BoxDecoration(
          color: ColorConstants.surfaceSecondary,
          borderRadius: const BorderRadius.all(Radius.circular(12)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            if (icon != null)
              Icon(
                icon,
                size: 20,
                color: ColorConstants.onSurfaceWhite,
              ),
            const SizedBox(width: 8),
            Text(
              title,
              style: styles.bodyLarge?.copyWith(
                color: ColorConstants.onSurfaceWhite,
                fontWeight: FontWeight.w400,
              ),
            ),
            const Spacer(),
            if (hasArrow)
              Icon(
                Icons.keyboard_arrow_right,
                size: 20,
                color: ColorConstants.onSurfaceWhite,
              ),
          ],
        ),
      ),
    );
  }
}
