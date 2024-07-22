import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/character_model.dart';
import '../../viewmodel/character_viewmodel.dart';
import '../../../../product/constants/colors.dart'; // Doğru yolu kontrol edin

class CharacterCard extends StatelessWidget {
  final CharacterModel character;

  const CharacterCard({Key? key, required this.character}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<CharacterViewModel>(context);

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
                  Text(
                    'Last known location:',
                    style: const TextStyle(
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
                  Text(
                    'First seen in:',
                    style: const TextStyle(
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
            IconButton(
              icon: viewModel.isFollowed(character.name)
                  ? const Icon(Icons.favorite, color: Colors.red, size: 30)
                  : const Icon(Icons.favorite_border, color: Colors.white, size: 30),
              onPressed: () async {
                if (viewModel.isFollowed(character.name)) {
                  await viewModel.removeFollowedCharacter(character.name);
                } else {
                  await viewModel.addFollowedCharacter(character.name);
                }
              },
            ),
        ],
      ),
    );
  }
}
