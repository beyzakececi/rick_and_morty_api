import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../product/constants/colors.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 2), () {
      context.go('/characters');
    });

    return Scaffold(
      backgroundColor: RickAndMortyColors.yellow, // Splash ekran rengi
      body: Center(
        child: Text(
          'Rick and Morty',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: RickAndMortyColors.brown, // Metin rengi
          ),
        ),
      ),
    );
  }
}
