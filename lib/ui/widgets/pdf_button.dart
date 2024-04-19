import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:help_my_truck/const/colors.dart';
import 'package:help_my_truck/const/resource.dart';
import 'package:help_my_truck/data/models/contentfull_entnities.dart';
import 'package:help_my_truck/ui/shared/custom_button.dart';
import 'package:url_launcher/url_launcher_string.dart';

class PDFButton extends StatelessWidget {
  final PdfFile file;
  const PDFButton({super.key, required this.file});

  @override
  Widget build(BuildContext context) {
    final styles = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: _button(
        trailing: SvgPicture.asset(
          R.ASSETS_PDF_FILE_SVG,
          height: 20,
          width: 20,
        ),
        styles: styles,
        title: file.title,
        onPressed: () => file.url == null ? null : launchUrlString(file.url!),
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
      title: CustomButtonTitle(
        text: null,
        widget: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
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
      mainColor: color ?? ColorConstants.onSurfaceSecondary,
      state:
          isOutlined ? CustomButtonStates.outlined : CustomButtonStates.filled,
      onPressed: onPressed,
    );
  }
}
