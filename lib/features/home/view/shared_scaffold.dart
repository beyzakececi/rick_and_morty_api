import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty/features/home/view/widget/search_bar_custom.dart';

import '../viewmodel/data_provider.dart';

class SharedScaffold extends StatefulWidget {
  final Widget body;
  final int currentIndex;

  const SharedScaffold({super.key, required this.body, required this.currentIndex});

  @override
  _SharedScaffoldState createState() => _SharedScaffoldState();
}

class _SharedScaffoldState extends State<SharedScaffold> {
  void _onItemTapped(int index) {
    switch (index) {
      case 0:
        GoRouter.of(context).go('/home');
        break;
      case 1:
        GoRouter.of(context).go('/locations');
        break;
      case 2:
        GoRouter.of(context).go('/followed');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {

    final dataProvider = Provider.of<DataProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Rick and Morty'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(56.0),
          child: SearchBarCustom(dataProvider: dataProvider),
        ),
      ),
      body: widget.body,
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Characters',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on),
            label: 'Locations',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Followed',
          ),
        ],
        currentIndex: widget.currentIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
