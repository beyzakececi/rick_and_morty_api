// location_state.dart
import '../../character/models/character_model.dart';
import '../models/location_model.dart';

abstract class LocationState {}

class LocationLoading extends LocationState {}

class LocationInitial extends LocationState {}

class LocationLoaded extends LocationState {
  final List<LocationModel> locations;
  final List<String> favoriteLocations;
  final List<CharacterModel> characters;
  final List<LocationModel> allLocations;

  LocationLoaded(
      {required this.locations,
      required this.favoriteLocations,
      required this.characters,
      required this.allLocations});
}

class LocationError extends LocationState {
  final String message;

  LocationError(this.message);
}
