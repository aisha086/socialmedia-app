import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:memorykeeper/model/Posts.dart';

class APIService {

  String baseUrl = "https://dummyjson.com/posts";

  Future<List<Posts>> getPosts() async{
    try{
      var response = await http.get(Uri.parse(baseUrl));
      print("Get Post Response");
      print(response.statusCode);

      if(response.statusCode == 200){
        var json = jsonDecode(response.body);
        final jsonData = json['posts'] as List<dynamic>;
        List<Posts> posts = jsonData.map((e) => Posts.fromJson(e)).toList();
        return posts;
      }
      else{
        return Future.error("Server Error");
      }
    }
    catch(socketException) {
      return Future.error("Error Fetching Data");

    }
  }

  Future<Posts> addPost(Map<String,dynamic> data) async{
    try{
      var response = await http.post(Uri.parse("$baseUrl/add"),
        body: jsonEncode(data),
        headers: {
        "Content-type": "application/json; charset=UTF-8"
        }
      );
      print("Add Post Response");
      print(response.statusCode);

      if(response.statusCode == 200){
        var jsonData = jsonDecode(response.body) as Map<String,dynamic>;
        Posts post = Posts.fromJson(jsonData);
        return post;
      }
      else{
        return Future.error("Server Error");
      }
    }
    catch(socketException) {
      return Future.error("Error Fetching Data");

    }
  }

  Future<String> deletePost(Map<String,dynamic> data) async{
    try{
      var response = await http.delete(Uri.parse("$baseUrl/1"),
          body: jsonEncode(data),
          headers: {
            "Content-type": "application/json; charset=UTF-8"
          }
      );
      print("Deleting Post");
      print(response.statusCode);

      if(response.statusCode == 200){
        return "success";
      }
      else{
        return "Error";
      }
    }
    catch(socketException) {
      return "Error";

    }
  }
}