import 'package:equatable/equatable.dart';

abstract class CharacterEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchCharacters extends CharacterEvent {}

class SearchCharacters extends CharacterEvent {
  final String query;

  SearchCharacters(this.query);

  @override
  List<Object> get props => [query];
}


class FollowCharacterEvent extends CharacterEvent {
  final String characterName;
  
  FollowCharacterEvent(this.characterName);
}

class UnfollowCharacterEvent extends CharacterEvent {
  final String characterName;

  UnfollowCharacterEvent(this.characterName);
}
