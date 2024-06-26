import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:help_my_truck/const/colors.dart';
import 'package:help_my_truck/data/models/fault.dart';
import 'package:help_my_truck/services/router/faults_router.dart';
import 'package:help_my_truck/ui/widgets/custom_button.dart';

import '../../const/resource.dart';

class FaultCodeButton extends StatelessWidget {
  final ChildFault fault;

  const FaultCodeButton({super.key, required this.fault});

  @override
  Widget build(BuildContext context) {
    final styles = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: _button(
        leading: fault.showAsPdf
            ? SvgPicture.asset(R.ASSETS_PDF_FILE_SVG, height: 20, width: 20)
            : Icon(Icons.error, color: ColorConstants.statesError, size: 20),
        styles: styles,
        title: fault.text,
        onPressed: () {
          Navigator.of(context).pushNamed(
            FaultsRouteKeys.faultScreen,
            arguments: fault,
          );
        },
      ),
    );
  }

  Widget _button({
    required String title,
    required VoidCallback onPressed,
    required TextTheme styles,
    bool isOutlined = false,
    Widget? leading,
    Widget? trailing,
    Color? color,
  }) {
    return CustomButton(
      height: 48,
      title: CustomButtonTitle(
        text: null,
        widget: Expanded(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              if (leading != null) ...{
                leading,
                const SizedBox(width: 6),
              },
              Text(
                title,
                style: styles.labelLarge?.copyWith(
                  color: ColorConstants.onSurfaceWhite,
                ),
              ),
              if (trailing != null) ...{const SizedBox(width: 6), trailing}
            ],
          ),
        ),
      ),
      mainColor: color ?? ColorConstants.onSurfaceSecondary,
      state:
          isOutlined ? CustomButtonStates.outlined : CustomButtonStates.filled,
      onPressed: onPressed,
    );
  }
}
