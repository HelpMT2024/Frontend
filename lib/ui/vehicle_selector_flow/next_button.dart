import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:help_my_truck/const/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NextButton extends StatelessWidget {
  final Function()? onPressed;

  const NextButton({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    final styles = Theme.of(context).textTheme;
    final l10n = AppLocalizations.of(context);

    return PlatformTextButton(
      onPressed: onPressed,
      color: ColorConstants.surfaceWhite,
      material: (_, __) => MaterialTextButtonData(
        style: TextButton.styleFrom(
          backgroundColor: ColorConstants.surfaceWhite,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      cupertino: (_, __) => CupertinoTextButtonData(
        color: ColorConstants.surfaceWhite,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        alignment: Alignment.center,
        width: double.infinity,
        child: Text(
          l10n?.next ?? '',
          style: styles.labelLarge?.copyWith(
            color: ColorConstants.onSurfaceHigh,
          ),
        ),
      ),
    );
  }
}
