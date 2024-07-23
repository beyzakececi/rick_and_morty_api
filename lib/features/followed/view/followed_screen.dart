import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty/features/followed/view/widget/followed_card.dart';
import '../viewmodel/followed_viewmodel.dart'; // Ensure correct import path

class FollowedScreen extends StatelessWidget {
  const FollowedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => FollowedViewModel(),
      child: Scaffold(
        body: Consumer<FollowedViewModel>(
          builder: (context, followedViewModel, child) {
            return ListView(
              children: [
                const ListTile(
                  title: Text('Followed Characters', style: TextStyle(color: Colors.black, fontSize: 20)),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: followedViewModel.followedCharacters.results.length,
                  itemBuilder: (context, index) {
                    return FollowedCard(
                      character: followedViewModel.followedCharacters.results[index],
                      isCharacter: true,
                      onRemove: () {
                        followedViewModel.removeFollowedCharacter(followedViewModel.followedCharacters.results[index].name);
                      },
                    );
                  },
                ),
                const ListTile(
                  title: Text('Followed Locations', style: TextStyle(color: Colors.black, fontSize: 20)),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: followedViewModel.followedLocations.results.length,
                  itemBuilder: (context, index) {
                    return FollowedCard(
                      location: followedViewModel.followedLocations.results[index],
                      isCharacter: false,
                      onRemove: () {
                        followedViewModel.removeFollowedLocation(followedViewModel.followedLocations.results[index].name);
                      },
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
