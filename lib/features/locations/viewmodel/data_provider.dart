import 'package:flutter/material.dart';

import '../../character/models/character_model.dart';
import '../../character/services/character_service.dart';
import '../../locations/models/location_model.dart';
import '../../locations/services/location_service.dart';

class DataProvider with ChangeNotifier {
  final CharacterService _characterService = CharacterService();
  final LocationService _locationService = LocationService();

  //initializing the list of characters
  ListCharacterModel _allCharacters = ListCharacterModel(results: []);

  ListLocationModel _allLocations = ListLocationModel(results: []);

  ListCharacterModel _characters = ListCharacterModel(results: []);

  ListLocationModel _locations = ListLocationModel(results: []);

  bool _isLoading = false;

  ListCharacterModel get characters => _characters;

  ListLocationModel get locations => _locations;

  bool get isLoading => _isLoading;

  DataProvider() {
    fetchData();
  }

  Future<void> fetchData() async {
    _isLoading = true;
    notifyListeners();

    try {
      final charactersData = await _characterService.fetchCharacters();
      _allCharacters = charactersData;
      _characters = charactersData;

      final locationsData = await _locationService.fetchLocations();
      _allLocations = locationsData;
      _locations = locationsData;
    } catch (e) {
      // Handle error
      print('Error fetching data: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  void search(String query) {
    if (query.isEmpty) {
      _characters = _allCharacters;
      _locations = _allLocations;
    } else {
      //change listlocationmodel
      _characters = ListCharacterModel(
          results: _allCharacters.results
              .where((element) =>
                  element.name.toLowerCase().contains(query.toLowerCase()))
              .toList());
      _locations = ListLocationModel(
          results: _allLocations.results
              .where((element) =>
                  element.name.toLowerCase().contains(query.toLowerCase()))
              .toList());
    }
    notifyListeners();
  }
}
