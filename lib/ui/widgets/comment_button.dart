import 'package:flutter/material.dart';
import 'package:help_my_truck/const/colors.dart';
import 'package:help_my_truck/services/purchase_service.dart';
import 'package:help_my_truck/ui/comments_flow/comments_screen.dart';
import 'package:help_my_truck/ui/comments_flow/comments_screen_view_model.dart';
import 'package:help_my_truck/ui/widgets/custom_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CommentButton extends StatelessWidget {
  final bool disableFlex;
  final int? id;

  const CommentButton({
    super.key,
    this.disableFlex = false,
    required this.id,
  });

  void _showCommentsModal(BuildContext context) {
    PurchaseService.processAfterPayment(
      () {
        final viewModel = CommentsScreenViewModel(contentfulId: id);
        showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          builder: (BuildContext context) {
            return CommentsScreen(viewModel: viewModel);
          },
        );
      },
      context,
    );
  }

  @override
  Widget build(BuildContext context) {
    final styles = Theme.of(context).textTheme;
    final l10n = AppLocalizations.of(context);

    return CustomButton(
      height: 40,
      title: CustomButtonTitle(
        text: null,
        widget: Expanded(
          flex: disableFlex ? 0 : 1,
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
      borderColor: ColorConstants.onSurfaceWhite64,
      state: CustomButtonStates.outlined,
      onPressed: () => _showCommentsModal(context),
    );
  }
}
