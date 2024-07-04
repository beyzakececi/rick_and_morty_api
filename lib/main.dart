import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'features/home/viewmodel/data_provider.dart';
import 'features/splash/view/splash_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DataProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Rick & Morty',
      home: SplashScreen(),
    );
  }
}

