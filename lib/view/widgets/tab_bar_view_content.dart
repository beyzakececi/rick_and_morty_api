import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/data_provider.dart';
import 'character_list.dart';
import 'location_list.dart';

class TabBarViewContent extends StatelessWidget {
  final DataProvider dataProvider;

  const TabBarViewContent({Key? key, required this.dataProvider}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return dataProvider.isLoading
        ? const Center(child: CircularProgressIndicator())
        : const TabBarView(
      children: [
        CharacterList(),
        LocationList(),
      ],
    );
  }
}
