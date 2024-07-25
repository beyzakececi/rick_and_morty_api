// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart'; // Hive için import edilmiştir.
import 'package:rick_and_morty/features/followed/bloc/followed_bloc.dart';
import 'package:rick_and_morty/features/locations/bloc/location_bloc.dart';

import 'features/character/bloc/character_bloc.dart';
import 'features/character/services/character_service.dart';
import 'features/followed/view/followed_screen.dart';
import 'features/locations/services/location_service.dart';
import 'features/locations/view/screens/location_list_screen.dart';
import 'features/shared/bloc/search_bloc.dart';
import 'product/routers/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter(); // Hive başlat

  // Hive kutularını aç
  await Hive.openBox<List<String>>('followed_characters');
  await Hive.openBox<List<String>>('followed_locations');

  runApp(
    MyApp(),
  );

  // Uygulama tamamen kapandığında Hive'i kapat
  //await Hive.close();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CharacterBloc(CharacterService(),
              characterService: CharacterService()),
        ),
        BlocProvider(
          create: (context) => LocationBloc(LocationService(),CharacterService(),
              locationService: LocationService(),
              characterService: CharacterService()),

        ),
        BlocProvider(
            create: (context)=> FollowedBloc(),
        ),
        BlocProvider(
            create: (context) => SearchBloc(),
        ),
        // Diğer BlocProvider'lar buraya eklenebilir
      ],
      child: MaterialApp.router(
        title: 'Rick and Morty',
        routerConfig: router,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
