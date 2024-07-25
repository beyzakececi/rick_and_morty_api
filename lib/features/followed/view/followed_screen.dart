// followed_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/followed_bloc.dart';
import '../bloc/followed_events.dart';
import '../bloc/followed_states.dart';
import '../view/widget/followed_card.dart';

class FollowedScreen extends StatefulWidget {
  const FollowedScreen({super.key});

  @override
  State<FollowedScreen> createState() => _FollowedScreenState();
}

class _FollowedScreenState extends State<FollowedScreen> {
  initState() {
    super.initState();

    context.read<FollowedBloc>().add(LoadFolloweds());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<FollowedBloc, FollowedState>(
        builder: (context, state) {
          if (state is FollowedLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is FollowedLoaded) {
            return ListView(
              children: [
                const ListTile(
                  title: Text('Followed Characters',
                      style: TextStyle(color: Colors.black, fontSize: 20)),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.followedCharacters.results.length,
                  itemBuilder: (context, index) {
                    return FollowedCard(
                      character: state.followedCharacters.results[index],
                      isCharacter: true,
                      onRemove: () {
                        context.read<FollowedBloc>().add(
                            RemoveFollowedCharacter(
                                state.followedCharacters.results[index].name));
                      },
                    );
                  },
                ),
                const ListTile(
                  title: Text('Followed Locations',
                      style: TextStyle(color: Colors.black, fontSize: 20)),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.followedLocations.results.length,
                  itemBuilder: (context, index) {
                    return FollowedCard(
                      location: state.followedLocations.results[index],
                      isCharacter: false,
                      onRemove: () {
                        context.read<FollowedBloc>().add(RemoveFollowedLocation(
                            state.followedLocations.results[index].name));
                      },
                    );
                  },
                ),
              ],
            );
          } else if (state is FollowedError) {
            return Center(child: Text(state.message));
          } else {
            return Center(child: Text('Unexpected state'));
          }
        },
      ),
    );
  }
}
