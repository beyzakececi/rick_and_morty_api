import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/character_model.dart';
import '../models/location_model.dart';
import '../constants/constants.dart';

class ApiService {

  Future<List<CharacterModel>> fetchCharacters() async {
    final response = await http.get(Uri.parse('$BASE_URL/character'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return (data['results'] as List)
          .map((character) => CharacterModel.fromJson(character))
          .toList();
    } else {
      throw Exception('Failed to load characters');
    }
  }

  Future<List<Location>> fetchLocations() async {
    final response = await http.get(Uri.parse('$BASE_URL/location'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return (data['results'] as List)
          .map((location) => Location.fromJson(location))
          .toList();
    } else {
      throw Exception('Failed to load locations');
    }
  }
}