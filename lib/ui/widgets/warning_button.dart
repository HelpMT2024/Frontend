import 'package:flutter/material.dart';
import 'package:help_my_truck/const/colors.dart';
import 'package:help_my_truck/ui/shared/custom_button.dart';

class WarningButton extends StatelessWidget {
  const WarningButton({super.key});

  @override
  Widget build(BuildContext context) {
    final styles = Theme.of(context).textTheme;

    return SizedBox(
      height: 48,
      child: CustomButton(
        title: CustomButtonTitle(
          text: null,
          widget: Expanded(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.nearby_error,
                  size: 20,
                  color: ColorConstants.warningColor,
                ),
                const SizedBox(width: 6),
                Text(
                  'Some error text...',
                  style: styles.labelLarge?.copyWith(
                    color: ColorConstants.onSurfaceWhite,
                  ),
                ),
              ],
            ),
          ),
        ),
        mainColor: ColorConstants.onSurfaceSecondary,
        state: CustomButtonStates.filled,
        onPressed: () => {},
      ),
    );
  }
}
