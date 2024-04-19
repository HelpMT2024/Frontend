import 'package:flutter/material.dart';
import 'package:help_my_truck/const/colors.dart';

class VehicleTitle extends StatelessWidget {
  final String? text;

  const VehicleTitle({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    final styles = Theme.of(context).textTheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 32),
        Text(
          text ?? '',
          textAlign: TextAlign.left,
          style: styles.titleMedium?.merge(
            TextStyle(color: ColorConstants.onSurfaceWhite),
          ),
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}
