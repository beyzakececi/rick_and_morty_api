import 'package:flutter/material.dart';
import '../../../../core/constants/colors.dart';
import '../../models/character_model.dart';
import '../../../../core/helpers/local_storage_helper.dart';

class CharacterCard extends StatefulWidget {
  final CharacterModel character;

  const CharacterCard({required this.character});

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
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: RickAndMortyColors.yellow, width: 4),
        borderRadius: BorderRadius.circular(4),
      ),
      margin: const EdgeInsets.all(10),
      child: Card(
        elevation: 0, // Kartın gölgesini kaldırmak için
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children: [
              Column(
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
                  buildInfoRow('Status', widget.character.status),
                  buildInfoRow('Species', widget.character.species),
                  buildInfoRow('Gender', widget.character.gender),
                  buildInfoRow('Episode count', widget.character.episode.length.toString()),
                  buildInfoRow('Created', widget.character.created.substring(0, 10)),
                ],
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
      ),
    );
  }
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
