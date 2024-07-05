import 'package:flutter/material.dart';
import '../../../core/helpers/local_storage_helper.dart';
import '../../home/view/shared_scaffold.dart';

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
            final characters = snapshot.data!;
            return ListView.builder(
              itemCount: characters.length,
              itemBuilder: (context, index) {
                final character = characters[index];
                return ListTile(
                  title: Text(character),
                  trailing: IconButton(
                    icon: Icon(Icons.remove_circle),
                    onPressed: () async {
                      await localStorageHelper.removeFollowedCharacter(character);
                      _fetchFollowedCharacters();
                    },
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
