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
      padding: const EdgeInsets.only(right: 4),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: ColorConstants.onSurfaceHigh,
        ),
        height: 52,
        width: (MediaQuery.of(context).size.width - 68) / 4,
        padding: const EdgeInsets.all(4),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 2),
            SvgPicture.network(
              warning.icon?.url ?? '',
              height: 30,
              width: 30,
            ),
            const SizedBox(height: 2),
            Flexible(child: Text(warning.name, style: style)),
          ],
        ),
      ),
    );
  }
}
