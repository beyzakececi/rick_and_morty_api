// followed_events.dart
import 'package:equatable/equatable.dart';

abstract class FollowedEvent extends Equatable {
  @override
  List<Object?> get props => [];
}


class LoadFolloweds extends FollowedEvent {}

class RemoveFollowedCharacter extends FollowedEvent {
  final String name;

  RemoveFollowedCharacter(this.name);

  @override
  List<Object?> get props => [name];
}

class RemoveFollowedLocation extends FollowedEvent {
  final String name;

  RemoveFollowedLocation(this.name);

  @override
  List<Object?> get props => [name];
}
