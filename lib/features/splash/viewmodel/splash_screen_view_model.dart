import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class SplashScreenViewModel extends ChangeNotifier {
  late VideoPlayerController controller;
  bool isError = false;

  SplashScreenViewModel({required VoidCallback onVideoEnd}) {
    controller = VideoPlayerController.asset('assets/videos/splash.mp4')
      ..initialize().then((_) {
        notifyListeners();
        controller.play();
        Future.delayed(const Duration(seconds: 9), onVideoEnd);
      }).catchError((error) {
        isError = true;
        notifyListeners();
        debugPrint('VideoPlayerController initialization error: $error');
      })
      ..setLooping(false);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
