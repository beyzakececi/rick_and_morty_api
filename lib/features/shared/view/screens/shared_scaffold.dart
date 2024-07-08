import 'package:flutter/material.dart';
import '../../../locations/viewmodel/data_provider.dart';
import '../widgets/search_bar_custom.dart';

class SharedScaffold extends StatelessWidget {
  final Widget body;
  final int currentIndex;
  final Function(int) onTap;
  final DataProvider dataProvider;

  const SharedScaffold({
    Key? key,
    required this.body,
    required this.currentIndex,
    required this.onTap,
    required this.dataProvider,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rick and Morty'),
      ),
      body: body,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: onTap,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
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
      ),
    );
  }
}
