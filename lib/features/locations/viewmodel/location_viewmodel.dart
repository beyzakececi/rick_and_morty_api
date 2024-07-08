import 'package:flutter/material.dart';
import '../../../core/services/api_service.dart';
import '../models/location_model.dart';

class LocationViewModel extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  List<Location> _locations = [];

  List<Location> get locations => _locations;

  LocationViewModel() {
    fetchLocations();
  }

  Future<void> fetchLocations() async {
    try {
      _locations = await _apiService.fetchLocations();
      notifyListeners();
    } catch (e) {
      print('Error fetching locations: $e');
    }
  }
}
