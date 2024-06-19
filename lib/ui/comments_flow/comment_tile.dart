import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:help_my_truck/const/colors.dart';
import 'package:help_my_truck/services/API/item_provider.dart';

class CommentTile extends StatelessWidget {
  final CommentsListItem item;

  const CommentTile({super.key, required this.item});

  String formattedDateDifference(DateTime pastDate) {
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
    if (years > 0) return "$years ${years == 1 ? 'year' : 'years'} ago";

    int months = (currentDate.year - pastDate.year) * 12 +
        currentDate.month -
        pastDate.month;
    if (currentDate.day < pastDate.day) {
      months--;
    }
    if (months > 0) return "$months ${months == 1 ? 'month' : 'months'} ago";

    int weeks = difference.inDays ~/ 7;
    if (weeks > 0) return "$weeks ${weeks == 1 ? 'week' : 'weeks'} ago";

    int days = difference.inDays;
    if (days > 0) return "$days ${days == 1 ? 'day' : 'days'} ago";

    int hours = difference.inHours;
    if (hours > 0) return "$hours ${hours == 1 ? 'hour' : 'hours'} ago";

    int minutes = difference.inMinutes;
    return "$minutes ${minutes == 1 ? 'minute' : 'minutes'} ago";
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
                      item.ownerUsername,
                      style: styles.labelLarge?.copyWith(
                        color: ColorConstants.onSurfaceWhite,
                      ),
                      softWrap: true,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      formattedDateDifference(item.createdAt),
                      style: styles.bodySmall?.copyWith(
                        color: ColorConstants.onSurfaceWhite80,
                      ),
                      softWrap: true,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  item.text,
                  style: styles.bodyMedium?.copyWith(
                    color: ColorConstants.onSurfaceWhite,
                  ),
                ),
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
}
