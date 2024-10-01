class comments {
  int id;
  String body;
  int postId;
  Map<String,dynamic> user;

  comments({required this.id,required this.body,required this.postId,required this.user});

  factory comments.fromJson(Map<String, dynamic> map) {
    return comments(
      id: map['id'] as int,
      body: map['body'] as String,
      postId: map['postId'] as int,
      user: map['user'] as Map<String, dynamic>,
    );
  } //
}