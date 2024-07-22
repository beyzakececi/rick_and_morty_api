import 'package:flutter/material.dart';
import '../../../product/localdb/hive_manager.dart';
import '../../character/services/character_service.dart';
import '../../locations/services/location_service.dart';
import '../../character/models/character_model.dart';
import '../../locations/models/location_model.dart';

class FollowedViewModel extends ChangeNotifier {
  final HiveManager _hiveManager = HiveManager();
  final CharacterService _characterService = CharacterService();
  final LocationService _locationService = LocationService();

  List<CharacterModel> _followedCharacters = [];
  List<LocationModel> _followedLocations = [];

  List<CharacterModel> get followedCharacters => _followedCharacters;
  List<LocationModel> get followedLocations => _followedLocations;

  FollowedViewModel() {
    loadFollowedCharacters();
    loadFollowedLocations();
  }

  Future<void> loadFollowedCharacters() async {
    try {
      final followedNames = await _hiveManager.getFollowedItems('characters');
      final allCharacters = await _characterService.fetchCharacters();
      _followedCharacters = allCharacters.where((character) => followedNames.contains(character.name)).toList();
      notifyListeners();
    } catch (e) {
      print('Failed to load followed characters: $e');
    }
  }

  Future<void> loadFollowedLocations() async {
    try {
      final followedNames = await _hiveManager.getFollowedItems('locations');
      final allLocations = await _locationService.fetchLocations();
      _followedLocations = allLocations.where((location) => followedNames.contains(location.name)).toList();
      notifyListeners();
    } catch (e) {
      print('Failed to load followed locations: $e');
    }
  }

  Future<void> removeFollowedCharacter(String name) async {
    await _hiveManager.removeFollow(name, 'characters');
    _followedCharacters.removeWhere((character) => character.name == name);
    notifyListeners();
  }

  Future<void> removeFollowedLocation(String name) async {
    await _hiveManager.removeFollow(name, 'locations');
    _followedLocations.removeWhere((location) => location.name == name);
    notifyListeners();
  }
}
