
import 'dart:convert';

class Posts {
  final int id;
  final String title;
  final String body;
  final int userId;
  final List<String> tags;
  final int reactions;

  Posts({
    required this.id,
    required this.title,
    required this.body,
    required this.userId,
    required this.tags,
    required this.reactions,
  });

  factory Posts.fromJson(Map<String, dynamic> json) {
    final List<String> tagsList = List<String>.from(json['tags'] ?? []);

    return Posts(
      id: json['id'] as int,
      title: json['title'] as String,
      body: json['body'] as String,
      userId: json['userId'] as int,
      tags: tagsList,
      reactions: json['reactions']['likes'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "body": body,
      "userId": userId,
      "tags": jsonEncode(tags),
      "reactions": reactions,
    };
  }
}
