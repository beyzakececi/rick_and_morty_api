import 'package:flutter/material.dart';
import '../../../core/localdb/hive_manager.dart';
import '../../../core/services/api_service_manager.dart';
import '../../character/models/character_model.dart';
import '../../locations/models/location_model.dart'; // Import LocationModel

class FollowedViewModel extends ChangeNotifier {
  final HiveManager _hiveManager = HiveManager();
  final FetchManager _fetchManager = FetchManager();
  List<CharacterModel> _followedCharacters = [];
  List<LocationModel> _followedLocations = []; // List for followed locations

  List<CharacterModel> get followedCharacters => _followedCharacters;
  List<LocationModel> get followedLocations => _followedLocations;

  FollowedViewModel() {
    loadFollowedCharacters();
    loadFollowedLocations(); // Load followed locations
  }

  Future<void> loadFollowedCharacters() async {
    try {
      final followedNames = await _hiveManager.getFollowedItems('characters');
      final allCharacters = await _fetchManager.fetchCharacters();
      _followedCharacters = allCharacters.where((character) => followedNames.contains(character.name)).toList();
      notifyListeners();
    } catch (e) {
      // Handle error
      print('Failed to load followed characters: $e');
    }
  }

  Future<void> loadFollowedLocations() async {
    try {
      final followedNames = await _hiveManager.getFollowedItems('locations');
      final allLocations = await _fetchManager.fetchLocations(); // Assuming FetchManager has a method to fetch locations
      _followedLocations = allLocations.where((location) => followedNames.contains(location.name)).toList();
      notifyListeners();
    } catch (e) {
      // Handle error
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
