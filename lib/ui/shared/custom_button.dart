import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:help_my_truck/const/colors.dart';

enum CustomButtonStates { outlined, filled }

class CustomButtonTitle {
  final String? text;
  final Widget? widget;

  CustomButtonTitle({required this.text, this.widget});
}

class CustomButton extends StatelessWidget {
  final CustomButtonTitle title;
  final CustomButtonStates state;
  final VoidCallback? onPressed;
  final double width;
  final double height;
  final bool isNeedWidth;

  final double borderRadius;
  final Color? mainColor;
  final Color? borderColor;
  final Color? textColor;
  late final _isOutlined = state == CustomButtonStates.outlined;

  CustomButton({
    super.key,
    required this.title,
    required this.state,
    required this.onPressed,
    this.mainColor,
    this.borderColor,
    this.textColor,
    this.borderRadius = 12,
    this.width = double.infinity,
    this.height = 40,
    this.isNeedWidth = false,
  });

  @override
  Widget build(BuildContext context) {
    final styles = Theme.of(context).textTheme;

    return SizedBox(
      height: height,
      width: isNeedWidth ? width : null,
      child: PlatformWidget(
        cupertino: ((context, platform) =>
            _cupertinoButton(styles: styles, onPressed: onPressed)),
        material: ((context, platform) =>
            _materialButton(styles: styles, onPressed: onPressed)),
      ),
    );
  }

  Widget _materialButton(
      {required TextTheme styles, required VoidCallback? onPressed}) {
    final buttonColor = mainColor ?? ColorConstants.onSurfaceSecondary;

    ButtonStyle style = ElevatedButton.styleFrom(
      padding: isNeedWidth
          ? const EdgeInsets.all(0)
          : const EdgeInsets.symmetric(horizontal: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        side: BorderSide(
          width: _isOutlined ? 1.0 : 0,
          color: borderColor ?? buttonColor,
        ),
      ),
      backgroundColor: _isOutlined ? Colors.transparent : buttonColor,
      elevation: 0,
    );

    return ElevatedButton(
      onPressed: onPressed,
      style: style,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          title.text != null
              ? _buttonText(
                  title.text!,
                  styles,
                  _isOutlined ? buttonColor : ColorConstants.onSurfaceWhite,
                )
              : title.widget!
        ],
      ),
    );
  }

  Widget _cupertinoButton({
    required TextTheme styles,
    required VoidCallback? onPressed,
  }) {
    final buttonColor = mainColor ?? ColorConstants.onSurfaceSecondary;

    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: onPressed,
      color: _isOutlined ? Colors.transparent : buttonColor,
      disabledColor: _isOutlined ? Colors.transparent : buttonColor,
      borderRadius: BorderRadius.circular(borderRadius),
      child: Container(
        height: height,
        padding: isNeedWidth
            ? EdgeInsets.zero
            : const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          border: Border.all(
            width: _isOutlined ? 1.0 : 0,
            color: borderColor ?? buttonColor,
          ),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Center(
            child: title.text != null
                ? _buttonText(
                    title.text!,
                    styles,
                    _isOutlined ? buttonColor : ColorConstants.onSurfaceWhite,
                  )
                : title.widget!),
      ),
    );
  }

  Widget _buttonText(String title, TextTheme styles, Color color) {
    return Text(
      title,
      style: styles.button?.merge(
        TextStyle(color: textColor ?? color),
      ),
    );
  }
}
