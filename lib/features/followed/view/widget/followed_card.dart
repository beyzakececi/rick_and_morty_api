import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../character/viewmodel/character_viewmodel.dart';
import '../../viewmodel/followed_viewmodel.dart';
import '../../../character/models/character_model.dart';
import '../../../../core/constants/colors.dart'; // Doğru yolu kontrol edin

class FollowedCard extends StatelessWidget {
  final CharacterModel character;

  const FollowedCard({Key? key, required this.character}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<FollowedViewModel>(
      builder: (context, followedViewModel, child) {
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
              icon: const Icon(Icons.remove_circle),
              onPressed: () async {
                await followedViewModel.removeFollowedCharacter(character.name);
                // notify CharacterViewModel about the change
                Provider.of<CharacterViewModel>(context, listen: false).removeFollowedCharacter(character.name);
              },
            ),
          ),
        );
      },
    );
  }
}
