import 'dart:convert';
import 'package:http/http.dart' as http;
import 'models/character_model.dart';
import 'models/location_model.dart';

class ApiService {
  final String baseUrl = 'https://rickandmortyapi.com/api';

  Future<List<Character>> fetchCharacters() async {
    final response = await http.get(Uri.parse('$baseUrl/character'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return (data['results'] as List)
          .map((character) => Character.fromJson(character))
          .toList();
    } else {
      throw Exception('Failed to load characters');
    }
  }

  Future<List<Location>> fetchLocations() async {
    final response = await http.get(Uri.parse('$baseUrl/location'));
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
