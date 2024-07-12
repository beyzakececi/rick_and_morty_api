import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../locations/viewmodel/data_provider.dart';
import '../../../shared/view/widgets/search_bar_custom.dart';
import '../widgets/character_card.dart';

class CharacterListScreen extends StatefulWidget {
  const CharacterListScreen({Key? key}) : super(key: key);

  @override
  _CharacterListScreenState createState() => _CharacterListScreenState();
}

class _CharacterListScreenState extends State<CharacterListScreen> {
  bool showAliveOnly = false;

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<DataProvider>(context);
    final filteredCharacters = showAliveOnly
        ? dataProvider.characters.where((char) => char.status.toLowerCase() == 'alive').toList()
        : dataProvider.characters;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50.0),
        child: Row(
          children: [
            Expanded(
              child: SearchBarCustom(dataProvider: dataProvider),
            ),
            Switch(
              activeColor: Colors.green,
              value: showAliveOnly,
              onChanged: (value) {
                setState(() {
                  showAliveOnly = value;
                });
              },
            ),
          ],
        ),
      ),
      body: dataProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: filteredCharacters.length,
        itemBuilder: (context, index) {
          final character = filteredCharacters[index];
          return GestureDetector(
            onTap: () {
              context.go('/characters/character-detail/${character.id}', extra: character);
            },
            child: CharacterCard(character: character),
          );
        },
      ),
    );
  }
}
