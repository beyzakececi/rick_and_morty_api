// followed_states.dart
import 'package:equatable/equatable.dart';
import '../../character/models/character_model.dart';
import '../../locations/models/location_model.dart';

abstract class FollowedState extends Equatable {
  @override
  List<Object?> get props => [];
}

class FollowedInitial extends FollowedState {}

class FollowedLoading extends FollowedState {}

class FollowedLoaded extends FollowedState {
  final ListCharacterModel followedCharacters;
  final ListLocationModel followedLocations;

  FollowedLoaded({
    required this.followedCharacters,
    required this.followedLocations,
  });

  @override
  List<Object?> get props => [followedCharacters, followedLocations];
}

class FollowedError extends FollowedState {
  final String message;

  FollowedError(this.message);

  @override
  List<Object?> get props => [message];
}
