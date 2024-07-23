import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rick_and_morty/product/constants/app_constants.dart';


class NetworkConstant {
  Map<String, String> headers = {
    'accept': 'Application/json',
    'content-type': 'Application/json',
  };

  //methods
  static String POST = "post";
  static String GET = "get";
  static String DELETE = "delete";
}


mixin ServiceOperationMixin {
  Future<T> fetch<T>(String endpoint, Function fromJson, String method,
      {Map<String, dynamic>? query, Map<String, dynamic>? body}) async {
    try {
      final request = await http.Request(
          method, Uri.parse('${AppConstants.baseUrl}/$endpoint'));
      NetworkConstant().headers.forEach((key, value) {
        request.headers[key] = value;
      });
      if (body != null) {
        request.body = jsonEncode(body);
      }
      var response = await http.Client().send(request);
      String resBody = "";

      if (response.statusCode == 200) {
        resBody = await response.stream.bytesToString();

        final data = jsonDecode(resBody);
        return fromJson(data);
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Error occurred during fetch: $e');
    }
  }
}
