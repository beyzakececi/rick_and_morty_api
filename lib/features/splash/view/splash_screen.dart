import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../viewmodel/splash_screen_view_model.dart';
import 'package:video_player/video_player.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SplashScreenViewModel(
        onVideoEnd: () {
          context.go('/home'); // Use GoRouter for navigation
        },
      ),
      child: Consumer<SplashScreenViewModel>(
        builder: (context, model, child) {
          return Scaffold(
            body: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                model.controller.value.isInitialized
                    ? AspectRatio(
                  aspectRatio: model.controller.value.aspectRatio,
                  child: VideoPlayer(model.controller),
                )
                    : Container(
                  color: Colors.black,
                  child: const Center(
                    child: Text(
                      'Initializing video...',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
