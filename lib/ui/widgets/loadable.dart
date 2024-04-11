import 'package:flutter/material.dart';
import 'package:help_my_truck/const/colors.dart';
import 'package:help_my_truck/ui/widgets/mesure_size.dart';

class Loadable extends StatefulWidget {
  final Widget child;
  final bool forceLoad;
  final double? topOffset;
  final Alignment? alignment;
  final bool isBackground;

  const Loadable({
    super.key,
    required this.child,
    this.forceLoad = false,
    this.topOffset,
    this.alignment,
    this.isBackground = false,
  });

  @override
  State<Loadable> createState() => _LoadableState();
}

class _LoadableState extends State<Loadable> {
  Size _childSize = Size.zero;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: widget.alignment ?? Alignment.center,
      children: widget.forceLoad
          ? [
              MeasureSize(
                onChange: (size) {
                  setState(() {
                    _childSize = size;
                  });
                },
                child: widget.child,
              ),
              Container(
                decoration: BoxDecoration(
                  color: widget.isBackground
                      ? Colors.black.withOpacity(0.08)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                ),
                height: _childSize.height,
                width: _childSize.width,
                child: Center(
                  child: CircularProgressIndicator(
                    color: ColorConstants.surfaceWhite,
                  ),
                ),
              ),
            ]
          : [widget.child],
    );
  }
}
