import 'package:riverpod/riverpod.dart';
import 'package:video_player/video_player.dart';

final mainPageProvider = FutureProvider.autoDispose<VideoPlayerController>(
  (ref) async {
    final videoPlayerController = VideoPlayerController.networkUrl(
      Uri.https(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
      ),
    );

    ref.onDispose(() {
      videoPlayerController.pause();
      videoPlayerController.dispose();
    });

    return videoPlayerController;
  },
);
