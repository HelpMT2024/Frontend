import 'package:flutter/material.dart';
import 'package:help_my_truck/const/colors.dart';
import 'package:help_my_truck/data/models/contentfull_entnities.dart';
import 'package:help_my_truck/ui/widgets/videos/video_screen.dart';

class VideoRow extends StatelessWidget {
  final bool isFullWidth;
  final IDPVideo video;

  const VideoRow({super.key, required this.isFullWidth, required this.video});

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.labelLarge?.copyWith(
          color: ColorConstants.onSurfaceWhite,
        );
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => VideoScreen(url: video.url),
          ),
        );
      },
      child: Padding(
        padding: EdgeInsets.only(right: !isFullWidth ? 12 : 0),
        child: Stack(
          alignment: Alignment.center,
          children: [
            _video(video, style, context),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 51),
                child: Icon(
                  Icons.play_circle_fill,
                  color: ColorConstants.onSurfaceWhite,
                  size: 56,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _video(IDPVideo e, TextStyle? style, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: !isFullWidth ? 2 : 0,
          child: _image(e),
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: isFullWidth ? MediaQuery.of(context).size.width : 260,
          child: SizedBox(
            height: 40,
            child: Text(
              e.title,
              style: style,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.start,
              maxLines: 2,
            ),
          ),
        ),
      ],
    );
  }

  Container _image(IDPVideo e) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: ColorConstants.onSurfacePrimary.withAlpha(143),
          width: 2,
        ),
        backgroundBlendMode: BlendMode.darken,
        borderRadius: BorderRadius.circular(12),
        color: ColorConstants.onSurfacePrimary,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.network(
          _getYoutubeThumbnail(e.url)!,
          height: 150,
          width: 260,
          fit: BoxFit.fitWidth,
        ),
      ),
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
