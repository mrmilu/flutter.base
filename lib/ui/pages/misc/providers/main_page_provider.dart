import 'package:riverpod/riverpod.dart';
import 'package:video_player/video_player.dart';

final mainPageProvider =
    FutureProvider.autoDispose<VideoPlayerController>((ref) async {
  final videoPlayerController = VideoPlayerController.network(
    'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
  );
  await videoPlayerController.initialize();
  videoPlayerController.setLooping(true);
  videoPlayerController.setVolume(0);
  videoPlayerController.play();

  ref.onDispose(() {
    videoPlayerController.pause();
    videoPlayerController.dispose();
  });

  return videoPlayerController;
});
