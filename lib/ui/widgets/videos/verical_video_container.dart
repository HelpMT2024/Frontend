import 'package:flutter/cupertino.dart';
import 'package:help_my_truck/data/models/contentfull_entnities.dart';
import 'package:help_my_truck/ui/widgets/vehicle_title.dart';
import 'package:help_my_truck/ui/widgets/videos/video_row.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class VerticalVideoContainer extends StatelessWidget {
  final List<IDPVideo> videos;
  const VerticalVideoContainer({super.key, required this.videos});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Wrap(
      runSpacing: 12,
      children: [
        if (videos.isNotEmpty) VehicleTitle(text: l10n?.tips_and_hinst_video),
        for (final video in videos) VideoRow(isFullWidth: true, video: video),
      ],
    );
  }
}
