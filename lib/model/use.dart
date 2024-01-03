import 'package:appdanhgia/model/service.dart';

class User {
  final String id;
  final String name;
  final String time;
  final List<Service> service;

  User({
    required this.id,
    required this.name,
    required this.time,
    required this.service,
  });

  factory User.fromMap(Map<String, dynamic> user) {
    return User(
      id: user['id'],
      name: user['name'],
      time: user['time'],
      service: (user['services'] as List<dynamic>)
          .map((service) => Service.fromJson(service))
          .toList(),
    );
  }
}
