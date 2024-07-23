import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constants/app_constants.dart';

mixin ServiceOperationMixin {
  Future<T> get<T>(String endpoint, Function fromJson) async {
    try {
      print(endpoint);
      final response = await http.get(Uri.parse('${AppConstants.baseUrl}/$endpoint'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return fromJson(data);
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Error occurred during fetch: $e');
    }

    
  }
}
