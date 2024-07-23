import 'package:flutter/material.dart';
import '../../../locations/models/location_model.dart';
import '../../../character/models/character_model.dart';
import '../../../../product/constants/colors.dart'; // Ensure correct import path

class FollowedCard extends StatelessWidget {
  final CharacterModel? character;
  final LocationModel? location;
  final bool isCharacter;
  final VoidCallback? onRemove;

  const FollowedCard({
    super.key,
    this.character,
    this.location,
    required this.isCharacter,
    this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: RickAndMortyColors.yellow, width: 4),
        borderRadius: BorderRadius.circular(4),
      ),
      margin: const EdgeInsets.all(10),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(isCharacter ? character!.image : location!.url),
        ),
        title: Text(isCharacter ? character!.name : location!.name),
        trailing: IconButton(
          icon: const Icon(Icons.remove_circle),
          onPressed: onRemove,
        ),
      ),
    );
  }
}
