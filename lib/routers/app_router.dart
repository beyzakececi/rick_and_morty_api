import 'package:go_router/go_router.dart';
import '../features/followed/view/followed_screen.dart';
import '../features/home/view/homepage_screen.dart';
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
      path: '/locations',
      builder: (context, state) => LocationList(),
    ),
    GoRoute(
      path: '/followed',
      builder: (context, state) => FollowedScreen(),
    ),
  ],
);
