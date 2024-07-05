import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../models/character_model.dart';
import '../../../../core/helpers/local_storage_helper.dart';
import '../../../../core/constants/colors.dart';

class CharacterCard extends StatefulWidget {
  final CharacterModel character;

  const CharacterCard({super.key, required this.character});

  @override
  _CharacterCardState createState() => _CharacterCardState();
}

class _CharacterCardState extends State<CharacterCard> {
  bool isFollowed = false;
  final localStorageHelper = LocalStorageHelper();

  @override
  void initState() {
    super.initState();
    _checkIfFollowed();
  }

  void _checkIfFollowed() async {
    List<String> followedCharacters = await localStorageHelper.getFollowedCharacters();
    setState(() {
      isFollowed = followedCharacters.contains(widget.character.name);
    });
  }

  void toggleFollow() async {
    if (isFollowed) {
      await localStorageHelper.removeFollowedCharacter(widget.character.name);
    } else {
      await localStorageHelper.addFollowedCharacter(widget.character.name);
    }
    setState(() {
      isFollowed = !isFollowed;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(isFollowed ? '${widget.character.name} followed!' : '${widget.character.name} unfollowed!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        GoRouter.of(context).push('/characterDetail', extra: widget.character);
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: RickAndMortyColors.yellow, width: 4),
          borderRadius: BorderRadius.circular(4),
        ),
        margin: const EdgeInsets.all(10),
        child: Stack(
          children: [
            Card(
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage(widget.character.image),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          widget.character.name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 8,
              right: 8,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    isFollowed ? RickAndMortyColors.green : RickAndMortyColors.peach,
                  ),
                ),
                onPressed: toggleFollow,
                child: Text(isFollowed ? 'Followed' : 'Follow'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        children: [
          Text(
            '$label: ',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }
}
