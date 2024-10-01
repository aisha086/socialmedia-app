import 'package:flutter/material.dart';
import 'package:memorykeeper/services/api_services_posts.dart';
import 'package:memorykeeper/model/Posts.dart';

APIService apiService = APIService();

class PostsController extends ChangeNotifier{
  static List<Posts> postList = [];
  late int postIndex;
  late Posts newPost;

  static Future<void> fetchPostList() async
  {
    postList = await apiService.getPosts();
    print("fetching data using controller");
  }

  Future<bool> updateList(Map<String,dynamic> mapData) async
  {
   newPost = await apiService.addPost(mapData);
   if(newPost!=null)
   {
      postList.add(newPost);
    }
    notifyListeners();
   return true;

  }

  Future<bool> removePost(int index,data) async
  {
    await apiService.deletePost(data);
    postList.removeAt(index);
    notifyListeners();
    return true;
  }

  List<Posts> getPostList()
  {
    return postList;

  }

  Future<void> isfetched() async{
      await  Future.delayed(Duration(seconds: 1), () {});
  }
}