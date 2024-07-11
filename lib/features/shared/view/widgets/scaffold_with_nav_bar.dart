import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ScaffoldWithNavBar extends StatelessWidget {
  final Widget child;
  final String location;

  const ScaffoldWithNavBar({
    required this.child,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rick and Morty'),
      ),
      body: child,
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
        currentIndex: location.contains('/locations')
            ? 1
            : location.contains('/followed')
            ? 2
            : 0,
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
      ),
    );
  }
}