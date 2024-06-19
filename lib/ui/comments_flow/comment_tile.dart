import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:help_my_truck/const/colors.dart';

class CommentTile extends StatelessWidget {
  const CommentTile({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final styles = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Nickname',
                    style: styles.labelLarge?.copyWith(
                      color: ColorConstants.onSurfaceWhite,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    '1d ago',
                    style: styles.bodySmall?.copyWith(
                      color: ColorConstants.onSurfaceWhite80,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'Lorem ipsum dolor sit amet consectetur. Bibendum nulla purus egestas faucibus. Lacinia netus sit lorem urna eget. Nec consequat egestas vestibulum habitant.',
                style: styles.bodyMedium?.copyWith(
                  color: ColorConstants.onSurfaceWhite,
                ),
              ),
            ],
          ),
          InkWell(
            onTap: () {},
            child: const Padding(
              padding: EdgeInsets.all(2),
              child: Icon(Icons.more_vert, size: 20),
            ),
          ),
        ],
      ),
    );
  }
}
