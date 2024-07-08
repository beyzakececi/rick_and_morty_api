import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../locations/viewmodel/data_provider.dart';
import '../../../shared/view/widgets/search_bar_custom.dart';
import '../widget/location_card.dart';

class LocationListScreen extends StatelessWidget {
  const LocationListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<DataProvider>(context);
    return Scaffold(
      appBar:  PreferredSize(
          preferredSize: const Size.fromHeight(50.0),
          child: SearchBarCustom(dataProvider: dataProvider),
        ),

      body: dataProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: dataProvider.locations.length,
        itemBuilder: (context, index) {
          return LocationCard(location: dataProvider.locations[index]);
        },
      ),
    );
  }
}
