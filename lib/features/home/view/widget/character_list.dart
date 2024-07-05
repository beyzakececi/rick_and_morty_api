import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodel/data_provider.dart';
import 'character_card.dart';

class CharacterList extends StatelessWidget {
  const CharacterList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final characters = Provider.of<DataProvider>(context).characters;

    return ListView.builder(
      itemCount: characters.length,
      itemBuilder: (context, index) {
        final character = characters[index];
        return CharacterCard(character: character);
      },
    );
  }
}
