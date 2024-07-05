import 'package:flutter/material.dart';

import '../models/character_model.dart';

class CharacterDetailScreen extends StatelessWidget {
  final CharacterModel character;

  const CharacterDetailScreen({Key? key, required this.character}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(character.name),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(character.image, height: 300, width: 300),
            ),
            const SizedBox(height: 24),
            Text('Name: ${character.name}', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text('Status: ${character.status}', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text('Species: ${character.species}', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text('Type: ${character.type}', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text('Gender: ${character.gender}', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text('Origin: ${character.origin.name}', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text('Last Known Location: ${character.location.name}', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text('Number of Episodes: ${character.episode.length}', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text('Created: ${character.created.substring(0,10)}', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 16),

          ],
        ),
      ),
    );
  }
}
