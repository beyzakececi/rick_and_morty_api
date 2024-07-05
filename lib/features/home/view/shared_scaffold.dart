import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: const Text('App Title'),
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
