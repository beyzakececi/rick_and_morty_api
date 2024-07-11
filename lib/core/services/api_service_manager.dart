import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../features/character/models/character_model.dart';
import '../../features/locations/models/location_model.dart';
import '../../core/constants/app_constants.dart';

class FetchManager {
  Future<List<T>> fetch<T>(String endpoint, Function fromJson) async {
    final response = await http.get(Uri.parse('${AppConstants.baseUrl}/$endpoint'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return (data['results'] as List)
          .map((item) => fromJson(item))
          .toList()
          .cast<T>();
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<List<CharacterModel>> fetchCharacters() async {
    return fetch<CharacterModel>('character', (json) => CharacterModel.fromJson(json));
  }

  Future<List<LocationModel>> fetchLocations() async {
    return fetch<LocationModel>('location', (json) => LocationModel.fromJson(json));
  }
}
