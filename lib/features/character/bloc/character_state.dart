// character_state.dart
import '../models/character_model.dart';

abstract class CharacterState {}

class CharacterInitial extends CharacterState {}

class CharacterLoading extends CharacterState {}

class CharacterLoaded extends CharacterState {
  final List<CharacterModel> characters;
  final ListCharacterModel allCharacters;
  final List<String> followedCharacters;

  CharacterLoaded(
      {required this.characters,
      required this.allCharacters,
      required this.followedCharacters});
}

class CharacterError extends CharacterState {
  final String message;

  CharacterError({required this.message});
}
