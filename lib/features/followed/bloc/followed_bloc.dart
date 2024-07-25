// followed_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../product/localdb/hive_manager.dart';
import '../../../product/localdb/operations.dart';
import '../../character/models/character_model.dart';
import '../../character/services/character_service.dart';
import '../../locations/models/location_model.dart';
import '../../locations/services/location_service.dart';
import 'followed_events.dart';
import 'followed_states.dart';

class FollowedBloc extends Bloc<FollowedEvent, FollowedState> {
  final HiveManager _hiveManager = HiveManager();
  final HiveOperations _hiveOperations = HiveOperations();
  final CharacterService _characterService = CharacterService();
  final LocationService _locationService = LocationService();

  FollowedBloc() : super(FollowedInitial()) {
    on<LoadFolloweds>(_onLoadFolloweds);
    on<RemoveFollowedCharacter>(_onRemoveFollowedCharacter);
    on<RemoveFollowedLocation>(_onRemoveFollowedLocation);
  }

  Future<void> _onLoadFolloweds(
      LoadFolloweds event, Emitter<FollowedState> emit) async {
    emit(FollowedLoading());
    try {
      final followedCharacterNames =
          await _hiveOperations.getFollowedItems(StorageKeys.CHARACTER.name);
      final allCharacters = await _characterService.fetchCharacters();
      final followedCharacters = ListCharacterModel(
        results: allCharacters.results
            .where((character) => followedCharacterNames.contains(character.name))
            .toList(),
      );

      final followedLocationNames =
          await _hiveOperations.getFollowedItems(StorageKeys.LOCATION.name);
      final allLocations = await _locationService.fetchLocations();
      final followedLocations = ListLocationModel(
        results: allLocations.results
            .where((location) => followedLocationNames.contains(location.name))
            .toList(),
      );

      emit(FollowedLoaded(
        followedCharacters: followedCharacters,
        followedLocations: followedLocations,
      ));
    } catch (e) {
      emit(FollowedError('Failed to load followed characters: $e'));
    }
  }


  Future<void> _onRemoveFollowedCharacter(
      RemoveFollowedCharacter event, Emitter<FollowedState> emit) async {
    try {
      await _hiveManager.removeItemFromList(
          event.name, StorageKeys.CHARACTER, _hiveOperations.getFollowedItems);
      final currentState = state as FollowedLoaded;
      final updatedCharacters = currentState.followedCharacters.copyWith(
        results: currentState.followedCharacters.results
            .where((character) => character.name != event.name)
            .toList(),
      );
      emit(FollowedLoaded(
        followedCharacters: updatedCharacters,
        followedLocations: currentState.followedLocations,
      ));
    } catch (e) {
      emit(FollowedError('Failed to remove followed character: $e'));
    }
  }

  Future<void> _onRemoveFollowedLocation(
      RemoveFollowedLocation event, Emitter<FollowedState> emit) async {
    try {
      await _hiveManager.removeItemFromList(
          event.name, StorageKeys.LOCATION, _hiveOperations.getFollowedItems);
      final currentState = state as FollowedLoaded;
      final updatedLocations = currentState.followedLocations.copyWith(
        results: currentState.followedLocations.results
            .where((location) => location.name != event.name)
            .toList(),
      );
      emit(FollowedLoaded(
        followedCharacters: currentState.followedCharacters,
        followedLocations: updatedLocations,
      ));
    } catch (e) {
      emit(FollowedError('Failed to remove followed location: $e'));
    }
  }
}
