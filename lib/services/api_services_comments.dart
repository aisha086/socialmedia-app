import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:memorykeeper/model/comments.dart';

class CommentService {

  String baseUrl = "https://dummyjson.com/posts/";

  Future<List<comments>> getComments(int id) async {
    try {
      var response = await http.get(Uri.parse("$baseUrl$id/comments"));
      print("Get Comment Response");
      print(response.body);
      print(response.statusCode);

      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        final jsonData = json['comments'] as List<dynamic>;
        List<comments> comment = jsonData.map((e) => comments.fromJson(e))
            .toList();
        return comment;
      }
      else if (response.body ==
          "{\"message\":\"Post with id 'undefined' not found\"}") {
        List<comments> comment = [];
        return comment;
      }
      else {
        return Future.error("Server Error");
      }
    }
    catch (socketException) {
      return Future.error("Error Fetching Data");
    }
  }
}