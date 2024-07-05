import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/helpers/local_storage_helper.dart';
import '../../home/view/shared_scaffold.dart';
import '../../home/viewmodel/data_provider.dart';
import '../../home/models/character_model.dart';
import '../../../core/constants/colors.dart';  // Make sure to import your color constants

class FollowedScreen extends StatefulWidget {
  @override
  _FollowedScreenState createState() => _FollowedScreenState();
}

class _FollowedScreenState extends State<FollowedScreen> {
  final localStorageHelper = LocalStorageHelper();
  late Future<List<String>> _followedCharacters;

  @override
  void initState() {
    super.initState();
    _fetchFollowedCharacters();
  }

  void _fetchFollowedCharacters() {
    setState(() {
      _followedCharacters = localStorageHelper.getFollowedCharacters();
    });
  }

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<DataProvider>(context);
    return SharedScaffold(
      body: FutureBuilder<List<String>>(
        future: _followedCharacters,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No followed characters found.'));
          } else {
            final followedCharacterNames = snapshot.data!;
            final followedCharacters = dataProvider.characters
                .where((character) => followedCharacterNames.contains(character.name))
                .toList();

            return ListView.builder(
              itemCount: followedCharacters.length,
              itemBuilder: (context, index) {
                final character = followedCharacters[index];
                return Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: RickAndMortyColors.yellow, width: 4),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(character.image),
                    ),
                    title: Text(character.name),
                    trailing: IconButton(
                      icon: Icon(Icons.remove_circle),
                      onPressed: () async {
                        await localStorageHelper.removeFollowedCharacter(character.name);
                        _fetchFollowedCharacters();
                      },
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
      currentIndex: 2,
    );
  }
}
