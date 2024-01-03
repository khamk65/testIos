import 'dart:convert';



class Rate {
  final int id;
  final List<int> comments;

  Rate({
    required this.id,
    required this.comments,
  });

  factory Rate.fromMap(Map<String, dynamic> rate) {
    List<dynamic> commentsList = jsonDecode(rate['rate']['comments']);
    List<int> comments = commentsList.map((comment) => comment as int).toList();
    return Rate(
      id: rate['rate']['selectedEmoji'],
      // service: (user['services'] as List<dynamic>)
      //     .map((service) => Rate.fromJson(service))
      //     .toList(),
      comments: comments,
    );
  }
}
