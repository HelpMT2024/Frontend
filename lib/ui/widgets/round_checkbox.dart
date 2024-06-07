import 'package:flutter/material.dart';
import 'package:help_my_truck/const/colors.dart';

class RoundCheckbox extends StatelessWidget {
  final bool isChecked;
  final void Function(bool) onTap;

  const RoundCheckbox({
    super.key,
    required this.isChecked,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(!isChecked),
      child: isChecked
          ? Icon(
              Icons.check_circle,
              size: 20,
              color: ColorConstants.onSurfacePrimaryLighter,
            )
          : Icon(
              Icons.circle_outlined,
              size: 20,
              color: ColorConstants.onSurfaceWhite.withAlpha(161),
            ),
    );
  }
}
