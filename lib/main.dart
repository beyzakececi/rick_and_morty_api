import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart'; // Hive için import edilmiştir.
import 'package:provider/provider.dart';

import 'features/character/viewmodel/character_viewmodel.dart';
import 'features/followed/viewmodel/followed_viewmodel.dart';
import 'features/locations/viewmodel/data_provider.dart';
import 'features/locations/viewmodel/location_viewmodel.dart';
import 'product/routers/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter(); // Hive başlat

  // Hive kutularını aç
  await Hive.openBox<List<String>>('followed_characters');
  await Hive.openBox<List<String>>('followed_locations');

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

  // Uygulama tamamen kapandığında Hive'i kapat
  //await Hive.close();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Rick and Morty',
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}
