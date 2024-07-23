import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty/product/localdb/operations.dart';
import '../../../../product/constants/colors.dart';
import '../../../../product/localdb/hive_manager.dart';
import '../../../character/models/character_model.dart';
import '../../models/location_model.dart';
import '../../viewmodel/data_provider.dart';

class LocationCard extends StatefulWidget {
  final LocationModel location;

  const LocationCard({super.key, required this.location});

  @override
  _LocationCardState createState() => _LocationCardState();
}

class _LocationCardState extends State<LocationCard> {
  List<CharacterModel> charactersInLocation = [];
  bool isFollowed = false;
  final HiveManager _hiveManager = HiveManager();
  final HiveOperations _hiveOperations = HiveOperations();
  @override
  void initState() {
    super.initState();
    _fetchCharacters();
    _checkIfFollowed();
  }

  void _fetchCharacters() {
    final dataProvider = Provider.of<DataProvider>(context, listen: false);
    charactersInLocation = dataProvider.characters.results
        .where((character) => character.location.name == widget.location.name)
        .toList();
  }

  Future<void> _checkIfFollowed() async {
    final followedLocations =
        await _hiveOperations.getFollowedItems('locations');
    setState(() {
      isFollowed = followedLocations.contains(widget.location.name);
    });
  }

  Future<void> _toggleFollow() async {
    if (isFollowed) {
      await _hiveManager.removeFollow(widget.location.name, 'locations');
    } else {
      await _hiveManager.addFollow(widget.location.name, 'locations');
    }
    setState(() {
      isFollowed = !isFollowed;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: RickAndMortyColors.yellow, width: 4.0),
        borderRadius: BorderRadius.circular(5),
      ),
      margin: const EdgeInsets.all(10),
      child: Card(
        elevation: 0,
        child: ExpansionTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.location.name),
              IconButton(
                icon: Icon(
                  isFollowed ? Icons.favorite : Icons.favorite_border,
                  color: isFollowed ? Colors.red : Colors.grey,
                ),
                onPressed: _toggleFollow,
              ),
            ],
          ),
          leading: const Icon(Icons.location_on),
          children: [
            ...charactersInLocation.map((character) => ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(character.image),
                  ),
                  title: Text(character.name),
                )),
          ],
        ),
      ),
    );
  }
}
