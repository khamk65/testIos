import 'package:http/http.dart' as http;
import 'dart:convert';

import '../model/rate.dart';


class RateApi {
  static Future<List<Rate>> fetchRate() async {
    print('fetchUsers called');
    const url =
        'https://api.mockfly.dev/mocks/1b1eb603-acdd-4440-aec4-21f4ed51e9b0/test';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);
    final results = json['results'] as List<dynamic>;
    final rates = results.map((user) {
      return Rate.fromMap(user);
    }).toList();
    print("fetchUsers completed");
    return rates;
  }
}