import 'package:flutter/material.dart';
import 'package:help_my_truck/data/models/contentfull_entnities.dart';
import 'package:help_my_truck/ui/widgets/vehicle_title.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:help_my_truck/ui/widgets/videos/video_row.dart';

class HorizontalVideoContainer extends StatelessWidget {
  final List<IDPVideo> videos;
  const HorizontalVideoContainer({super.key, required this.videos});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (videos.isNotEmpty) VehicleTitle(text: l10n?.tips_and_hinst_video),
        if (videos.length > 1)
          SizedBox(
            height: 198,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: videos.map((e) {
                return _frame(e);
              }).toList(),
            ),
          ),
        if (videos.length == 1) _frame(videos.first),
      ],
    );
  }

  Widget _frame(IDPVideo e) {
    return VideoRow(isFullWidth: videos.length == 1, video: e);
  }
}
