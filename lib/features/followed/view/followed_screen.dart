import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty/features/followed/view/widget/followed_card.dart';
import '../../../../core/constants/colors.dart';
import '../viewmodel/followed_viewmodel.dart'; // Ensure correct import path

class FollowedScreen extends StatelessWidget {
  const FollowedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => FollowedViewModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Followed'),
        ),
        body: Consumer<FollowedViewModel>(
          builder: (context, followedViewModel, child) {
            return ListView(
              children: [
                ListTile(
                  title: Text('Followed Characters'),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: followedViewModel.followedCharacters.length,
                  itemBuilder: (context, index) {
                    return FollowedCard(
                      character: followedViewModel.followedCharacters[index],
                      isCharacter: true,
                      onRemove: () {
                        followedViewModel.removeFollowedCharacter(followedViewModel.followedCharacters[index].name);
                      },
                    );
                  },
                ),
                ListTile(
                  title: Text('Followed Locations'),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: followedViewModel.followedLocations.length,
                  itemBuilder: (context, index) {
                    return FollowedCard(
                      location: followedViewModel.followedLocations[index],
                      isCharacter: false,
                      onRemove: () {
                        followedViewModel.removeFollowedLocation(followedViewModel.followedLocations[index].name);
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
