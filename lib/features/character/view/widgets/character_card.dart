import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/character_bloc.dart';
import '../../bloc/character_event.dart';
import '../../bloc/character_state.dart';
import '../../models/character_model.dart';

class CharacterCard extends StatelessWidget {
  final CharacterModel character;

  const CharacterCard({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    // Extract episode number from the URL
    String episodeNumber = character.episode.isNotEmpty
        ? character.episode.first.split('/').last
        : 'Unknown';

    // Determine the color based on the status
    Color getStatusColor(String status) {
      switch (status.toLowerCase()) {
        case 'alive':
          return Colors.green;
        case 'dead':
          return Colors.red;
        default:
          return Colors.grey;
      }
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.black54, // Card background color
        border: Border.all(color: Colors.grey.shade800, width: 2), // Border color and width
        borderRadius: BorderRadius.circular(8),
      ),
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(0), // Remove padding to align image with edges
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Character image
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(6),
              bottomLeft: Radius.circular(6),
            ),
            child: Image.network(
              character.image,
              width: 160, // Increase width if needed
              height: 210, // Increase height to match the card height
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 10),
          // Character details
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    character.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(
                        Icons.circle,
                        color: getStatusColor(character.status),
                        size: 12,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${character.status} - ${character.species}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Last known location:',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    character.location.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'First seen in:',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    'Episode $episodeNumber', // Display episode number
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Conditional Favorite icon button
          if (character.status.toLowerCase() == 'alive')
            BlocBuilder<CharacterBloc, CharacterState>(
              builder: (context, state) {
                bool isFollowed = state is CharacterLoaded
                    && state.followedCharacters.contains(character.name);

                return IconButton(
                  icon: isFollowed
                      ? const Icon(Icons.favorite, color: Colors.red, size: 30)
                      : const Icon(Icons.favorite_border, color: Colors.white, size: 30),
                  onPressed: () {
                    if (isFollowed) {
                      context.read<CharacterBloc>().add(UnfollowCharacterEvent(character.name));
                    } else {
                      context.read<CharacterBloc>().add(FollowCharacterEvent(character.name));
                    }
                  },
                );
              },
            ),
        ],
      ),
    );
  }
}
