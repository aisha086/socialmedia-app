import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:memorykeeper/model/Posts.dart';
import 'package:memorykeeper/model/users.dart';

class UserServices{
  String baseUrl = "https://dummyjson.com/users";

  Future<List<Users>> getUsers() async {
    try{
      var response =await http.get(Uri.parse(baseUrl));
      debugPrint("Get User Response");
      debugPrint(response.body);
      debugPrint(response.statusCode.toString());

      if(response.statusCode == 200){
        var jsonData = jsonDecode(response.body);
        debugPrint("this is jsonData $jsonData");
        final json_ = jsonData['users'] as List<dynamic>;
        List<Users> users = json_.map((e) => Users.fromMap(e)).toList();
        debugPrint("this is users $users");
        return users;
      }
      else{
        return Future.error("Server Error");
      }
    }
    catch(e){
      return Future.error("Error Fetching Data");
    }
  }

  Future<List<Posts>> getUserPosts(int id) async{
    try{
      var response = await http.get(Uri.parse("$baseUrl/$id/posts"));
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
}