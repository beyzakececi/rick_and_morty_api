// viewmodel/splash_screen_view_model.dart
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class SplashScreenViewModel extends ChangeNotifier {
  late VideoPlayerController _controller;
  final VoidCallback onVideoEnd;

  VideoPlayerController get controller => _controller;

  SplashScreenViewModel({required this.onVideoEnd}) {
    _controller = VideoPlayerController.asset('assets/videos/splash.mp4')
      ..initialize().then((_) {
        _controller.play();
        notifyListeners();
      });

    _controller.addListener(_videoListener);
  }

  void _videoListener() {
    if (_controller.value.position.inSeconds >= 9) {
      onVideoEnd();
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_videoListener);
    _controller.dispose();
    super.dispose();
  }
}
