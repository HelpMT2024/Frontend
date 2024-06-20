import 'package:flutter/material.dart';
import 'package:help_my_truck/const/colors.dart';
import 'package:popover/popover.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PopOverButton extends StatelessWidget {
  final VoidCallback callback;

  const PopOverButton({super.key, required this.callback});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final styles = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: () => showPopover(
        context: context,
        bodyBuilder: (context) {
          return GestureDetector(
            onTap: () => callback(),
            child: Container(
              height: 56,
              width: 200,
              padding: const EdgeInsets.fromLTRB(12, 14, 12, 14),
              decoration: BoxDecoration(
                color: ColorConstants.surfaceSecondary,
                borderRadius: const BorderRadius.all(Radius.circular(12)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.report,
                    color: ColorConstants.statesError,
                    size: 24,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    l10n?.report ?? '',
                    style: styles.bodyLarge?.copyWith(
                      color: ColorConstants.onSurfaceWhite,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        backgroundColor: Colors.transparent,
      ),
      child: Container(
        width: 24,
        height: 24,
        padding: const EdgeInsets.all(2),
        child: Icon(
          Icons.more_vert,
          size: 20,
          color: ColorConstants.onSurfaceMedium,
        ),
      ),
    );
  }
}
