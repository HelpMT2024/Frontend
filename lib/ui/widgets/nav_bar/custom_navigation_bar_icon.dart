import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:help_my_truck/const/colors.dart';

class CustomNavigationBarIcon extends StatelessWidget {
  final String? asset;
  final IconData? icon;
  final bool isCenterItem;
  final bool isActiveItem;
  final String? text;
  final double size;
  final double padding;

  const CustomNavigationBarIcon({
    super.key,
    this.asset,
    this.icon,
    this.isCenterItem = false,
    this.isActiveItem = false,
    this.text,
    this.size = 24,
    this.padding = 0,
  });

  @override
  Widget build(BuildContext context) {
    final color = isCenterItem
        ? ColorConstants.onSurfaceHigh
        : isActiveItem
            ? ColorConstants.onSurfaceWhite
            : ColorConstants.onSurfaceWhite64;
    final bgColor = isCenterItem
        ? ColorConstants.statesDanger
        : Colors.transparent;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: isCenterItem ? 2.0 : 4.0),
      padding: const EdgeInsets.symmetric(horizontal: 6),
      constraints: BoxConstraints(
        minHeight: isCenterItem ? 50 : 34,
      ),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(8.0),
          ),
          color: bgColor),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 2),
          _image(asset: asset, icon: icon, color: color),
          SizedBox(height: padding),
          Text(
            text ?? '',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w500,
              height: 1.21,
              letterSpacing: 0,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
        ],
      ),
    );
  }

  Widget _image({String? asset, IconData? icon, required Color color}) {
    if (asset != null) {
      return SvgPicture.asset(
        asset,
        height: size,
        width: size,
        fit: BoxFit.scaleDown,
        color: color,
      );
    }
    return Icon(icon, size: size, color: color);
  }
}
