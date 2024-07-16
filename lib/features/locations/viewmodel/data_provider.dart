import 'package:flutter/material.dart';
import '../../character/services/character_service.dart';
import '../../locations/services/location_service.dart';
import '../../character/models/character_model.dart';
import '../../locations/models/location_model.dart';

class DataProvider with ChangeNotifier {
  final CharacterService _characterService = CharacterService();
  final LocationService _locationService = LocationService();

  List<CharacterModel> _allCharacters = [];
  List<LocationModel> _allLocations = [];
  List<CharacterModel> _characters = [];
  List<LocationModel> _locations = [];
  bool _isLoading = false;

  List<CharacterModel> get characters => _characters;
  List<LocationModel> get locations => _locations;
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
      _characters = _allCharacters
          .where((character) =>
          character.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
      _locations = _allLocations
          .where((location) =>
          location.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }
}
