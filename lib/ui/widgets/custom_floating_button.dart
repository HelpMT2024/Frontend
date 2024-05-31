import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:help_my_truck/const/colors.dart';

class CustomFloatingButton extends StatelessWidget {
  final void Function()? onPressed;

  const CustomFloatingButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations? l10n = AppLocalizations.of(context);
    final TextTheme styles = Theme.of(context).textTheme;
    return FloatingActionButton(
      backgroundColor: ColorConstants.statesDanger,
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          children: [
            const Icon(Icons.search_rounded, size: 24),
            Text(
              l10n?.spn_fmi_title ?? '',
              style: styles.bodySmall?.copyWith(
                fontSize: 10,
                color: ColorConstants.surfacePrimaryDark,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
