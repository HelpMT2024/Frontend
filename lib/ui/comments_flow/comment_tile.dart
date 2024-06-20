import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:help_my_truck/const/colors.dart';
import 'package:help_my_truck/services/API/item_provider.dart';

class CommentTile extends StatefulWidget {
  final CommentsListItem item;

  const CommentTile({super.key, required this.item});

  @override
  State<CommentTile> createState() => _CommentTileState();
}

class _CommentTileState extends State<CommentTile> {
  bool isCollapsed = true;

  String formattedDateDifference(DateTime pastDate, AppLocalizations? l10n) {
    final toLocalDifference = pastDate.toLocal().timeZoneOffset;
    pastDate = pastDate.add(toLocalDifference);
    DateTime currentDate = DateTime.now();
    Duration difference = currentDate.difference(pastDate);

    int years = currentDate.year - pastDate.year;
    if (pastDate.month > currentDate.month ||
        (pastDate.month == currentDate.month &&
            pastDate.day > currentDate.day)) {
      years--;
    }
    if (years > 0)
      return "$years ${years == 1 ? l10n?.year : l10n?.years} ${l10n?.ago}";

    int months = (currentDate.year - pastDate.year) * 12 +
        currentDate.month -
        pastDate.month;
    if (currentDate.day < pastDate.day) {
      months--;
    }
    if (months > 0)
      return "$months ${months == 1 ? l10n?.month : l10n?.months} ${l10n?.ago}";

    int weeks = difference.inDays ~/ 7;
    if (weeks > 0)
      return "$weeks ${weeks == 1 ? l10n?.week : l10n?.weeks} ${l10n?.ago}";

    int days = difference.inDays;
    if (days > 0)
      return "$days ${days == 1 ? l10n?.day : l10n?.days} ${l10n?.ago}";

    int hours = difference.inHours;
    if (hours > 0)
      return "$hours ${hours == 1 ? l10n?.hour : l10n?.hours} ${l10n?.ago}";

    int minutes = difference.inMinutes;
    return "$minutes ${minutes == 1 ? l10n?.minute : l10n?.minutes} ${l10n?.ago}";
  }

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
          SizedBox(
            width: MediaQuery.of(context).size.width - 64,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      widget.item.ownerUsername,
                      style: styles.labelLarge?.copyWith(
                        color: ColorConstants.onSurfaceWhite,
                      ),
                      softWrap: true,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      formattedDateDifference(widget.item.createdAt, l10n),
                      style: styles.bodySmall?.copyWith(
                        color: ColorConstants.onSurfaceWhite80,
                      ),
                      softWrap: true,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                LayoutBuilder(builder: (context, constraints) {
                  final span = TextSpan(
                      text: widget.item.text, style: styles.bodyMedium);
                  final tp =
                      TextPainter(text: span, textDirection: TextDirection.ltr);
                  tp.layout(maxWidth: constraints.maxWidth);
                  final numLines = tp.computeLineMetrics().length;

                  if (numLines > 4) {
                    return Column(
                      children: [
                        _content(),
                        _showMoreButton(context),
                      ],
                    );
                  } else {
                    return _content();
                  }
                }),
              ],
            ),
          ),
          InkWell(
            onTap: () {},
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
          ),
        ],
      ),
    );
  }

  Widget _content() {
    final styles = Theme.of(context).textTheme;

    return Text(
      maxLines: isCollapsed ? 4 : null,
      overflow: isCollapsed ? TextOverflow.ellipsis : null,
      widget.item.text,
      style: styles.bodyMedium?.copyWith(
        color: ColorConstants.onSurfaceWhite,
      ),
    );
  }

  Widget _showMoreButton(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final styles = Theme.of(context).textTheme;

    var text = isCollapsed ? l10n!.read_more : l10n!.collapse;
    return InkWell(
      onTap: () {
        setState(() {
          isCollapsed = !isCollapsed;
        });
      },
      child: Row(
        children: [
          Text(
            text,
            style: styles.labelMedium?.copyWith(
              color: ColorConstants.onSurfaceWhite,
            ),
          ),
          Icon(
            isCollapsed ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_up,
            color: ColorConstants.onSurfaceWhite,
          ),
        ],
      ),
    );
  }
}
