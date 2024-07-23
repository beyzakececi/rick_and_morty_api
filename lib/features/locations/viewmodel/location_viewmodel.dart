import 'package:flutter/material.dart';
import '../../../features/locations/services/location_service.dart';
import '../models/location_model.dart';

class LocationViewModel extends ChangeNotifier {
  final LocationService _locationService = LocationService();
  ListLocationModel _locations = ListLocationModel(results:[]);

  ListLocationModel get locations => _locations;

  LocationViewModel() {
    fetchLocations();
  }

  Future<void> fetchLocations() async {
    try {
      _locations = await _locationService.fetchLocations();
      notifyListeners();
    } catch (e) {
      print('Error fetching locations: $e');
    }
  }
}
