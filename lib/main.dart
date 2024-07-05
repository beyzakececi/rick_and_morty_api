import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'features/followed/view/followed_screen.dart';
import 'features/home/view/homepage_screen.dart';
import 'features/home/view/widget/character_list.dart';
import 'features/home/view/widget/location_list.dart';
import 'features/home/viewmodel/data_provider.dart';

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
  final GoRouter _router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => MyHomePage(title: 'Home'),
      ),
      GoRoute(
        path: '/characters',
        builder: (context, state) => CharacterList(),
      ),
      GoRoute(
        path: '/locations',
        builder: (context, state) => LocationList(),
      ),
      GoRoute(
        path: '/followed',
        builder: (context, state) => FollowedScreen(),
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: _router.routerDelegate,
      routeInformationParser: _router.routeInformationParser,
      routeInformationProvider: _router.routeInformationProvider,
    );
  }
}
