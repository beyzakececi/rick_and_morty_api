// lib/features/home/view/location_list.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/helpers/local_storage_helper.dart';
import '../../viewmodel/data_provider.dart';
import 'location_card.dart';

class LocationList extends StatelessWidget {
  const LocationList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final locations = Provider.of<DataProvider>(context).locations;
    final localStorageHelper = LocalStorageHelper();

    return ListView.builder(
      itemCount: locations.length,
      itemBuilder: (context, index) {
        final location = locations[index];
        return ListTile(
          title: LocationCard(location: location),
          trailing: IconButton(
            icon: Icon(Icons.add),
            onPressed: () async {
              await localStorageHelper.addFollowedCharacter(location.name);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('${location.name} followed!')),
              );
            },
          ),
        );
      },
    );
  }
}
