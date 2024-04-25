import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:help_my_truck/const/colors.dart';
import 'package:help_my_truck/data/models/child_problem.dart';

class WarningLightCell extends StatelessWidget {
  final ChildWarningLight warning;

  const WarningLightCell({
    super.key,
    required this.warning,
  });

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.labelSmall?.copyWith(
          color: ColorConstants.onSurfaceWhite,
          fontSize: 8,
          overflow: TextOverflow.ellipsis,
        );
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: ColorConstants.onSurfaceHigh,
        ),
        height: 60,
        width: 80,
        padding: const EdgeInsets.all(4),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 2),
            SvgPicture.network(
              warning.icon?.url ?? '',
              height: 33,
              width: 33,
            ),
            const SizedBox(height: 4),
            Flexible(child: Text(warning.name, style: style)),
          ],
        ),
      ),
    );
  }
}
