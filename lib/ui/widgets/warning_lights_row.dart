import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:help_my_truck/const/colors.dart';
import 'package:help_my_truck/data/models/child_problem.dart';

class WarningLightsRow extends StatelessWidget {
  final List<ChildWarningLight> warnings;

  const WarningLightsRow({super.key, required this.warnings});

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.labelSmall?.copyWith(
          color: ColorConstants.onSurfaceWhite,
          fontSize: 8,
          overflow: TextOverflow.ellipsis,
        );

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          ...warnings.map((e) {
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
                  children: [
                    const SizedBox(height: 2),
                    SvgPicture.network(
                      e.icon?.url ?? '',
                      height: 32,
                      width: 32,
                    ),
                    const SizedBox(height: 4),
                    Flexible(child: Text(e.name, style: style)),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
