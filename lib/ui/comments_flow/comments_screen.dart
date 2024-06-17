import 'package:flutter/material.dart';
import 'package:help_my_truck/const/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CommentsScreen extends StatefulWidget {
  const CommentsScreen({super.key});

  @override
  State<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height - 122,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        color: ColorConstants.surfacePrimaryDark,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _header(context),
        ],
      ),
    );
  }

  _header(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final styles = Theme.of(context).textTheme;

    return Stack(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Container(
                    height: 4,
                    width: 32,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      color: ColorConstants.onSurfaceMedium,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  l10n?.comments_title ?? '',
                  style: styles.titleMedium
                      ?.copyWith(color: ColorConstants.onSurfaceWhite),
                ),
                const SizedBox(height: 15),
                Container(
                  height: 1,
                  width: MediaQuery.of(context).size.width,
                  color: ColorConstants.stroke,
                ),
              ],
            ),
          ],
        ),
        Positioned(
          top: 10,
          right: 10,
          child: InkWell(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: const EdgeInsets.all(2),
              height: 24,
              width: 24,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                color: ColorConstants.surfaceSecondary,
              ),
              child: Icon(
                Icons.close,
                size: 20,
                color: ColorConstants.onSurfaceMedium,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
