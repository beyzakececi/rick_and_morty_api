import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../features/character/view/screens/character_list_screen.dart';
import '../features/character/view/screens/character_detail_screen.dart';
import '../features/locations/view/screens/location_list_screen.dart';
import '../features/followed/view/followed_screen.dart';
import '../features/shared/view/screens/shared_scaffold.dart';
import '../features/splash/view/splash_screen.dart';
import '../features/locations/viewmodel/data_provider.dart';
import '../features/character/models/character_model.dart';

final DataProvider dataProvider = DataProvider();

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/characters',
      builder: (context, state) => SharedScaffold(
        body: const CharacterListScreen(),
        currentIndex: 0,
        onTap: (index) {
          switch (index) {
            case 0:
              context.go('/characters');
              break;
            case 1:
              context.go('/locations');
              break;
            case 2:
              context.go('/followed');
              break;
          }
        },
        dataProvider: dataProvider,
      ),
    ),
    GoRoute(
      path: '/locations',
      builder: (context, state) => SharedScaffold(
        body: const LocationListScreen(),
        currentIndex: 1,
        onTap: (index) {
          switch (index) {
            case 0:
              context.go('/characters');
              break;
            case 1:
              context.go('/locations');
              break;
            case 2:
              context.go('/followed');
              break;
          }
        },
        dataProvider: dataProvider,
      ),
    ),
    GoRoute(
      path: '/followed',
      builder: (context, state) => SharedScaffold(
        body: const FollowedScreen(),
        currentIndex: 2,
        onTap: (index) {
          switch (index) {
            case 0:
              context.go('/characters');
              break;
            case 1:
              context.go('/locations');
              break;
            case 2:
              context.go('/followed');
              break;
          }
        },
        dataProvider: dataProvider,
      ),
    ),
    GoRoute(
      path: '/characterDetail',
      builder: (context, state) {
        final character = state.extra as CharacterModel;
        return CharacterDetailScreen(character: character);
      },
    ),
  ],
);
