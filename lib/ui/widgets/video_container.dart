import 'package:flutter/material.dart';
import 'package:help_my_truck/const/colors.dart';
import 'package:help_my_truck/data/models/contentfull_entnities.dart';
import 'package:help_my_truck/ui/widgets/vehicle_title.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class VideoContainer extends StatelessWidget {
  final List<IDPVideo> videos;
  const VideoContainer({super.key, required this.videos});

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.labelLarge?.copyWith(
          color: ColorConstants.onSurfaceWhite,
        );
    final l10n = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (videos.isNotEmpty) VehicleTitle(text: l10n?.tips_and_hinst_video),
        if (videos.length > 1)
          SizedBox(
            height: 240,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                ...videos.map((e) {
                  return _frame(e, style);
                })
              ],
            ),
          ),
        if (videos.length == 1) _frame(videos.first, style),
      ],
    );
  }

  GestureDetector _frame(IDPVideo e, TextStyle? style) {
    return GestureDetector(
      onTap: () => launchUrlString(e.url),
      child: Padding(
        padding: EdgeInsets.only(right: videos.length > 1 ? 12 : 0),
        child: Stack(
          alignment: Alignment.center,
          children: [
            _video(e, style),
            Align(
              alignment: Alignment.center,
              child: Icon(
                Icons.play_circle_fill,
                color: ColorConstants.onSurfaceWhite,
                size: 56,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _video(IDPVideo e, TextStyle? style) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: videos.length > 1 ? 2 : 0,
          child: Image.network(
            _getYoutubeThumbnail(e.url)!,
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: 240,
          child: Text(
            e.title,
            style: style,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.start,
            maxLines: 1,
          ),
        ),
      ],
    );
  }

  String? _getYoutubeThumbnail(String videoUrl) {
    final uri = Uri.tryParse(videoUrl);
    if (uri == null) {
      return null;
    }

    return 'https://img.youtube.com/vi/${uri.queryParameters['v']}/0.jpg';
  }
}
