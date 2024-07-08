import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'features/locations/viewmodel/data_provider.dart';
import 'features/locations/viewmodel/location_viewmodel.dart';
import 'routers/app_router.dart';
import 'features/character/viewmodel/character_viewmodel.dart';
import 'features/followed/viewmodel/followed_viewmodel.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DataProvider()),
        ChangeNotifierProvider(create: (_) => CharacterViewModel()),
        ChangeNotifierProvider(create: (_) => LocationViewModel()),
        ChangeNotifierProvider(create: (_) => FollowedViewModel()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerDelegate: router.routerDelegate,
      routeInformationParser: router.routeInformationParser,
      routeInformationProvider: router.routeInformationProvider,
    );
  }
}
