import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constants/app_constants.dart';

mixin ServiceOperationMixin {
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
}
