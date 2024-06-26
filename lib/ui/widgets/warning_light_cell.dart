import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:help_my_truck/const/colors.dart';
import 'package:help_my_truck/data/models/child_problem.dart';

class WarningLightCell extends StatelessWidget {
  final ChildWarningLight warning;
  final double? fixedWidth;
  final double? fixedHeight;

  const WarningLightCell({
    super.key,
    required this.warning,
    this.fixedWidth,
    this.fixedHeight,
  });

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.labelSmall?.copyWith(
          color: ColorConstants.onSurfaceWhite,
          fontSize: 8,
          overflow: TextOverflow.ellipsis,
        );
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: ColorConstants.onSurfaceHigh,
      ),
      height: fixedHeight ?? 52,
      width: fixedWidth ?? 64,
      padding: const EdgeInsets.all(4),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          SvgPicture.network(
            warning.icon?.url ?? '',
            height: 30,
            width: 30,
          ),
          const Spacer(),
          LayoutBuilder(builder: (context, constraints) {
            final span = TextSpan(text: warning.name, style: style);
            final tp =
                TextPainter(text: span, textDirection: TextDirection.ltr);
            tp.layout(maxWidth: constraints.maxWidth);
            final numLines = tp.computeLineMetrics().length;
            if (numLines > 2) {
              return Text(
                warning.name,
                maxLines: fixedWidth != null ? 2 : 1,
                style: style,
                overflow: TextOverflow.ellipsis,
              );
            } else {
              return Text(
                warning.name,
                maxLines: fixedWidth != null ? 2 : 1,
                textAlign: TextAlign.center,
                style: style,
                overflow: TextOverflow.visible,
              );
            }
          }),
          const Spacer(),
        ],
      ),
    );
  }
}
