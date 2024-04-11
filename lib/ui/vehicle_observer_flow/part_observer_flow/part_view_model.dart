import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:help_my_truck/data/models/component.dart';
import 'package:help_my_truck/data/models/contentfull_entnities.dart';
import 'package:help_my_truck/data/models/part.dart';
import 'package:help_my_truck/services/API/vehicle_provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:video_player/video_player.dart';

class PartViewModel {
  final VehicleProvider provider;
  final ChildrenPart config;

  late final part = BehaviorSubject<Part>()
    ..addStream(Stream.fromFuture(provider.part(config.id)));

  int currentTruckIndex = 0;

  PartViewModel({
    required this.provider,
    required this.config,
  });

  ChewieController getChewieController(IDPVideo video) {
    final videoPlayer = VideoPlayerController.networkUrl(Uri.parse(video.url),
        videoPlayerOptions: VideoPlayerOptions(allowBackgroundPlayback: true));
    return ChewieController(
      videoPlayerController: videoPlayer,
      aspectRatio: 16 / 9,
      autoPlay: false,
      autoInitialize: true,
      looping: false,
      deviceOrientationsAfterFullScreen: [DeviceOrientation.portraitUp],
      errorBuilder: (context, errorMessage) {
        return Center(
          child: Text(
            errorMessage,
          ),
        );
      },
    );
  }

  void openPdf(PdfFile file) {}
}
