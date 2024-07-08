import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../models/character_model.dart';
import '../../viewmodel/character_viewmodel.dart';
import '../../../../core/constants/colors.dart'; // Doğru yolu kontrol edin

class CharacterCard extends StatelessWidget {
  final CharacterModel character;

  const CharacterCard({Key? key, required this.character}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<CharacterViewModel>(context);

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: RickAndMortyColors.yellow, width: 4),
        borderRadius: BorderRadius.circular(4),
      ),
      margin: const EdgeInsets.all(10),
      child: ListTile(
        title: Text(character.name),
        subtitle: Text(character.status),
        leading: Image.network(character.image),
        trailing: IconButton(
          icon: viewModel.isFollowed(character.name)
              ? Icon(Icons.favorite, color: Colors.red)
              : Icon(Icons.favorite_border),
          onPressed: () async {
            if (viewModel.isFollowed(character.name)) {
              await viewModel.removeFollowedCharacter(character.name);
            } else {
              await viewModel.addFollowedCharacter(character.name);
            }
          },
        ),
        onTap: () {
          context.push('/characterDetail', extra: character);
        },
      ),
    );
  }
}
