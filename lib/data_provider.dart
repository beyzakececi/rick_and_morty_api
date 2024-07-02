import 'package:flutter/material.dart';
import 'api_service.dart';
import 'models/character_model.dart';
import 'models/location_model.dart';

class DataProvider with ChangeNotifier {
  final ApiService apiService = ApiService();
  List<Character> _characters = [];
  List<Location> _locations = [];
  bool _isLoading = false;

  List<Character> get characters => _characters;
  List<Location> get locations => _locations;
  bool get isLoading => _isLoading;

  DataProvider() {
    fetchData();
  }

  Future<void> fetchData() async {
    _isLoading = true;
    notifyListeners();

    try {
      final charactersData = await apiService.fetchCharacters();
      _characters = charactersData;
      final locationsData = await apiService.fetchLocations();
      _locations = locationsData;
    } catch (e) {
      // Handle error
    }

    _isLoading = false;
    notifyListeners();
  }

  void search(String query) {
    // Arama işlevselliği
    notifyListeners();
  }
}
