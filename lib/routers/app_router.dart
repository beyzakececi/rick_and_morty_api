import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../features/followed/view/followed_screen.dart';
import '../features/home/models/character_model.dart';
import '../features/home/view/character_detail_screen.dart';
import '../features/home/view/homepage_screen.dart';
import '../features/home/view/widget/character_list.dart';
import '../features/home/view/widget/location_list.dart';
import '../features/splash/view/splash_screen.dart';


final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => SplashScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => MyHomePage(title: 'Rick & Morty'),
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
    GoRoute(
      path: '/characterDetail',
      builder: (context, state) => CharacterDetailScreen(character: state.extra as CharacterModel),
    ),
  ],
);
