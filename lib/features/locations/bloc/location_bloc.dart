// location_bloc.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/features/locations/services/location_service.dart';

import '../../../product/localdb/hive_manager.dart';
import '../../../product/localdb/operations.dart';
import '../../character/services/character_service.dart';
import 'location_event.dart';
import 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final LocationService _locationService;
  final CharacterService _characterService;
  final HiveManager _hiveManager = HiveManager();
  final HiveOperations _hiveOperations = HiveOperations();

  LocationBloc(this._locationService, this._characterService,
      {required LocationService locationService,
      required CharacterService characterService})
      : super(LocationInitial()) {
    on<FetchLocations>(_onFetchLocations);
    on<SearchLocations>(_onSearchLocations);
    on<RemoveFavoriteLocation>(_onUnFollowLocation);

    on<AddFavoriteLocation>(_onFollowLocation);
  }

  void _onSearchLocations(
      SearchLocations event, Emitter<LocationState> emit) async {
    if (state is LocationLoaded) {
      final currentState = state as LocationLoaded;
      final query = event.query.toLowerCase();
      final filteredLocations = currentState.allLocations
          .where((character) => character.name.toLowerCase().contains(query))
          .toList();

      emit(LocationLoaded(
        favoriteLocations: currentState.favoriteLocations,
        characters: currentState.characters,
        locations: filteredLocations,
        allLocations: currentState.allLocations,
      ));
    }
  }

  Future<void> _onFollowLocation(
      AddFavoriteLocation event, Emitter<LocationState> emit) async {
    final currentState = state as LocationLoaded;

    await _hiveManager.addItemToList(event.locationName, StorageKeys.LOCATION,
        _hiveOperations.getFollowedItems);
    var followedLocations =
        await _hiveOperations.getFollowedItems(StorageKeys.LOCATION.name);

    emit(
      LocationLoaded(
        favoriteLocations: followedLocations,
        locations: currentState.locations,
        characters: currentState.characters,
        allLocations: currentState.allLocations,
      ),
    );
  }

  Future<void> _onUnFollowLocation(
      RemoveFavoriteLocation event, Emitter<LocationState> emit) async {
    await _hiveManager.removeItemFromList(event.locationName,
        StorageKeys.LOCATION, _hiveOperations.getFollowedItems);
    final currentState = state as LocationLoaded;
    var followedLocations =
        await _hiveOperations.getFollowedItems(StorageKeys.LOCATION.name);

    emit(
      LocationLoaded(
        favoriteLocations: followedLocations,
        locations: currentState.locations,
        characters: currentState.characters,
        allLocations: currentState.allLocations,
      ),
    );
  }

  Future<void> _onFetchLocations(
      FetchLocations event, Emitter<LocationState> emit) async {
    emit(LocationLoading());
    try {
      var followedLocation =
          await _hiveOperations.getFollowedItems(StorageKeys.LOCATION.name);

      final locations = await _locationService.fetchLocations();
      final characters = await _characterService.fetchCharacters();

      emit(
        LocationLoaded(
          favoriteLocations: followedLocation,
          locations: locations.results,
          characters: characters.results,
          allLocations: locations.results,
        ),
      );
    } catch (e) {
      emit(LocationError(e.toString()));
    }
  }
}
