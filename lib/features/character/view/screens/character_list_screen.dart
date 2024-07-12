import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../locations/viewmodel/data_provider.dart';
import '../../../shared/view/widgets/search_bar_custom.dart';
import '../widgets/character_card.dart';

class CharacterListScreen extends StatelessWidget {
  const CharacterListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<DataProvider>(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50.0),
        child: SearchBarCustom(dataProvider: dataProvider),
      ),
      body: dataProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: dataProvider.characters.length,
              itemBuilder: (context, index) {
                final character = dataProvider.characters[index];
                return GestureDetector(
                  onTap: () {
                    context.go('/characters/character-detail/${character.id}',
                        extra: character);
                  },
                  child: CharacterCard(character: character),
                );
              },
            ),
    );
  }
}
