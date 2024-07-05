import 'package:flutter/material.dart';
import 'package:rick_and_morty/features/home/view/widget/character_list.dart';
import 'package:rick_and_morty/features/home/view/widget/location_list.dart';

import 'shared_scaffold.dart';
import '../../followed/view/followed_screen.dart';

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({super.key, required this.title});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = [
    CharacterList(),
    LocationList(),
    FollowedScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SharedScaffold(
      body: _widgetOptions[_selectedIndex],
      currentIndex: _selectedIndex,
    );
  }
}
