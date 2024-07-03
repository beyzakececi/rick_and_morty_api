import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants/colors.dart';
import '../../services/data_provider.dart';
import '../../models/character_model.dart';
import '../../models/location_model.dart';

class LocationCard extends StatefulWidget {
  final Location location;

  const LocationCard({required this.location});

  @override
  _LocationCardState createState() => _LocationCardState();
}

class _LocationCardState extends State<LocationCard> {
  List<CharacterModel> charactersInLocation = [];

  @override
  void initState() {
    super.initState();
    _fetchCharacters();
  }

  void _fetchCharacters() async {
    final dataProvider = Provider.of<DataProvider>(context, listen: false);
    charactersInLocation = dataProvider.characters
        .where((character) => character.location.name == widget.location.name)
        .toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: RickAndMortyColors.yellow, width: 4),
        borderRadius: BorderRadius.circular(5),
      ),
      margin: const EdgeInsets.all(10),
      child: Card(
        elevation: 0, // Kartın gölgesini kaldırmak için
        child: ExpansionTile(
          title: Text(widget.location.name),
          leading: const Icon(Icons.location_on),
          children: charactersInLocation
              .map((character) => ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(character.image),
            ),
            title: Text(character.name),
          ))
              .toList(),
        ),
      ),
    );
  }
}