import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodel/data_provider.dart';
import '../shared_scaffold.dart';
import 'location_card.dart';

class LocationList extends StatelessWidget {
  const LocationList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final locations = Provider.of<DataProvider>(context).locations;

    return SharedScaffold(
      body: ListView.builder(
        itemCount: locations.length,
        itemBuilder: (context, index) {
          final location = locations[index];
          return LocationCard(location: location);
        },
      ),
      currentIndex: 1,
    );
  }
}
