import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty/features/followed/view/widget/followed_card.dart';
import '../viewmodel/followed_viewmodel.dart';

class FollowedScreen extends StatelessWidget {
  const FollowedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => FollowedViewModel(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Followed Characters'),
        ),
        body: Consumer<FollowedViewModel>(
          builder: (context, viewModel, child) {
            return ListView.builder(
              itemCount: viewModel.followedCharacters.length,
              itemBuilder: (context, index) {
                return FollowedCard(character: viewModel.followedCharacters[index]);
              },
            );
          },
        ),
      ),
    );
  }
}
