import 'package:flutter/material.dart';
import 'package:rick_and_morty/product/localdb/operations.dart';
import '../../../product/localdb/hive_manager.dart';
import '../../character/services/character_service.dart';
import '../../locations/services/location_service.dart';
import '../../character/models/character_model.dart';
import '../../locations/models/location_model.dart';

class FollowedViewModel extends ChangeNotifier {
  final HiveManager _hiveManager = HiveManager();
  final HiveOperations _hiveOperations = HiveOperations();
  final CharacterService _characterService = CharacterService();
  final LocationService _locationService = LocationService();

  ListCharacterModel _followedCharacters = ListCharacterModel(results: []);
  ListLocationModel _followedLocations = ListLocationModel(results: []);

  ListCharacterModel get followedCharacters => _followedCharacters;

  ListLocationModel get followedLocations => _followedLocations;

  FollowedViewModel() {
    loadFollowedCharacters();
    loadFollowedLocations();
  }

  Future<void> loadFollowedCharacters() async {
    try {
      final followedNames = await _hiveOperations.getFollowedItems(StorageKeys.CHARACTER.name);
      final allCharacters = await _characterService.fetchCharacters();
      _followedCharacters = ListCharacterModel(
          results: allCharacters.results.where((character) =>
              followedNames.contains(character.name)).toList());
      notifyListeners();
    } catch (e) {
      print('Failed to load followed characters: $e');
    }
  }

  Future<void> loadFollowedLocations() async {
    try {
      final followedNames = await _hiveOperations.getFollowedItems(StorageKeys.LOCATION.name);
      final allLocations = await _locationService.fetchLocations();
      _followedLocations = ListLocationModel(
          results: allLocations.results.where((location) =>
              followedNames.contains(location.name)).toList());
      notifyListeners();
    } catch (e) {
      print('Failed to load followed locations: $e');
    }
  }

  Future<void> removeFollowedCharacter(String name) async {
    await _hiveManager.removeItemFromList(
        name, StorageKeys.CHARACTER, _hiveOperations.getFollowedItems);
    _followedCharacters.results.removeWhere((character) =>
    character.name == name);
    notifyListeners();
  }

  Future<void> removeFollowedLocation(String name,) async {
    await _hiveManager.removeItemFromList(name, StorageKeys.LOCATION, _hiveOperations.getFollowedItems);
    _followedLocations.results.removeWhere((location) => location.name == name);
    notifyListeners();
  }
}
