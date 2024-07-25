// lib/features/character/view/screens/character_list_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../bloc/character_bloc.dart';
import '../../bloc/character_event.dart';
import '../../bloc/character_state.dart';
import '../widgets/character_card.dart';

class CharacterListScreen extends StatefulWidget {
  const CharacterListScreen({Key? key}) : super(key: key);

  @override
  _CharacterListScreenState createState() => _CharacterListScreenState();
}

class _CharacterListScreenState extends State<CharacterListScreen> {
  bool showAliveOnly = false;

  @override
  void initState() {
    super.initState();
    context.read<CharacterBloc>().add(FetchCharacters());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50.0),
        child: BlocBuilder<CharacterBloc, CharacterState>(
            builder: (context, state) {

          return Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    contentPadding: EdgeInsets.zero,
                    fillColor: Colors.grey[200],
                  ),
                  onChanged: (query) {
                    context.read<CharacterBloc>().add(SearchCharacters(query));
                    context
                        .read<CharacterBloc>()
                        .add(SearchCharacters(query));

                    // TODO: Implement search functionality
                  },
                ),
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
          );
        }),
      ),
      body: BlocBuilder<CharacterBloc, CharacterState>(
        builder: (context, state) {
          if (state is CharacterLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CharacterLoaded) {
            final filteredCharacters = showAliveOnly
                ? state.characters
                    .where((character) => character.status == 'Alive')
                    .toList()
                : state.characters;
            return ListView.builder(
              itemCount: filteredCharacters.length,
              itemBuilder: (context, index) {
                final character = filteredCharacters[index];
                return GestureDetector(
                  onTap: () {
                    context.go('/characters/character-detail/${character.id}',
                        extra: character);
                  },
                  child: CharacterCard(character: character),
                );
              },
            );
          } else if (state is CharacterError) {
            return Center(child: Text(state.message));
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
