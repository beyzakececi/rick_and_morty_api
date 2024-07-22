import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/character/view/screens/character_list_screen.dart';
import '../../features/character/view/screens/character_detail_screen.dart';
import '../../features/locations/view/screens/location_list_screen.dart';
import '../../features/followed/view/followed_screen.dart';
import '../../features/shared/view/widgets/scaffold_with_nav_bar.dart';
import '../../features/splash/view/splash_screen.dart';
import '../../features/character/models/character_model.dart';

final GlobalKey<NavigatorState> _shellNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) {
        return ScaffoldWithNavBar(child: child);
      },
      routes: [
        GoRoute(
          path: '/characters',
          builder: (context, state) => const CharacterListScreen(),
          routes: [
            GoRoute(
              path: 'character-detail/:id',
              builder: (context, state) {
                final character = state.extra as CharacterModel;
                return CharacterDetailScreen(character: character);
              },
            ),
          ],
        ),
        GoRoute(
          path: '/locations',
          builder: (context, state) => const LocationListScreen(),
        ),
        GoRoute(
          path: '/followed',
          builder: (context, state) => const FollowedScreen(),
        ),
      ],
    ),
  ],
);

