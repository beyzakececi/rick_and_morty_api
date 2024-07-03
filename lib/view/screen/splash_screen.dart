// view/splash_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import '../../viewmodel/splash_screen_view_model.dart';
import 'homepage_screen.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SplashScreenViewModel(
        onVideoEnd: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => MyHomePage(title: 'Rick & Morty')),
          );
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
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
