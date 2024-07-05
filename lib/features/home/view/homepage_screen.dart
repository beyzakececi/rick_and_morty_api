import 'package:flutter/material.dart';
import 'widget/character_list.dart';
import 'widget/location_list.dart';
import '../../followed/view/followed_screen.dart';
import 'shared_scaffold.dart';

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
