import 'package:flutter/material.dart';
import 'package:help_my_truck/data/models/child_problem.dart';
import 'package:help_my_truck/ui/widgets/warning_light_cell.dart';

class WarningLightsRow extends StatelessWidget {
  final List<ChildWarningLight> warnings;

  const WarningLightsRow({super.key, required this.warnings});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          ...warnings.map((e) {
            return WarningLightCell(warning: e);
          }),
        ],
      ),
    );
  }
}
