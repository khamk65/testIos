class Service {
  final String name;
  final int price;
  final int much;

  Service({
    required this.name,
    required this.price,
    required this.much,
  });

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      name: json['name'],
      price: json['price'],
      much: json['much'],
    );
  }
}
