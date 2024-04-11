import 'package:flutter/material.dart';
import 'package:help_my_truck/const/colors.dart';
import 'package:help_my_truck/ui/shared/custom_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CommentButton extends StatelessWidget {
  const CommentButton({super.key});

  @override
  Widget build(BuildContext context) {
    final styles = Theme.of(context).textTheme;
    final l10n = AppLocalizations.of(context);

    return CustomButton(
      title: CustomButtonTitle(
        text: null,
        widget: Expanded(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.chat_bubble,
                size: 20,
                color: ColorConstants.onSurfaceWhite,
              ),
              const SizedBox(width: 6),
              Text(
                l10n?.comments_title ?? '',
                style: styles.labelLarge?.copyWith(
                  color: ColorConstants.onSurfaceWhite,
                ),
              ),
            ],
          ),
        ),
      ),
      mainColor: null,
      state: CustomButtonStates.outlined,
      onPressed: () => {},
    );
  }
}
