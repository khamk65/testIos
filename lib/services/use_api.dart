import 'package:http/http.dart' as http;
import 'dart:convert';

import '../model/use.dart';


class UserApi {
  static Future<List<User>> fetchUsers() async {
    print('fetchUsers called');
    const url =
        'https://api.mockfly.dev/mocks/f8a8de5b-31b9-4a44-8c1e-843f4be7003e/service';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);
    final results = json['results'] as List<dynamic>;
    final users = results.map((user) {
      return User.fromMap(user);
    }).toList();
    print("fetchUsers completed");
    return users;
  }
}
