import 'package:flutter/material.dart';
import '../../constants/colors.dart';

class CustomTabBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomTabBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const TabBar(
      indicatorColor: RickAndMortyColors.brown,
      labelStyle: TextStyle(color: RickAndMortyColors.brown, fontSize: 18),
      unselectedLabelStyle: TextStyle(color: RickAndMortyColors.brown, fontSize: 18),
      tabs: [
        Tab(text: 'Characters'),
        Tab(text: 'Locations'),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
