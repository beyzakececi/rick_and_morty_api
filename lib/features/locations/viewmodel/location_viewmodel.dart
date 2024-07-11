import 'package:flutter/material.dart';
import '../../../core/services/api_service_manager.dart';
import '../models/location_model.dart';

class LocationViewModel extends ChangeNotifier {
  final FetchManager _fetchManager = FetchManager();
  List<LocationModel> _locations = [];

  List<LocationModel> get locations => _locations;

  LocationViewModel() {
    fetchLocations();
  }

  Future<void> fetchLocations() async {
    try {
      _locations = await _fetchManager.fetchLocations();
      notifyListeners();
    } catch (e) {
      print('Error fetching locations: $e');
    }
  }
}
