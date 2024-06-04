import 'package:flutter/material.dart';
import 'package:help_my_truck/const/colors.dart';
import 'package:help_my_truck/ui/widgets/custom_button.dart';

class CustomTabButton extends StatelessWidget {
  final int index;
  final String title;
  final void Function(int) callback;
  final bool isSelected;

  const CustomTabButton({
    super.key,
    required this.title,
    required this.callback,
    required this.isSelected,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      height: 28,
      textColor: isSelected
          ? ColorConstants.surfacePrimaryDark
          : ColorConstants.onSurfaceWhite,
      borderColor: ColorConstants.stroke,
      mainColor: ColorConstants.onSurfaceWhite,
      borderRadius: 8,
      title: CustomButtonTitle(
        text: title,
      ),
      state: isSelected
          ? CustomButtonStates.filled
          : CustomButtonStates.outlined,
      onPressed: () {
        callback(index);
      },
    );
  }
}
