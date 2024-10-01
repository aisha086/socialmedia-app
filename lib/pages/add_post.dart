
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:memorykeeper/controller/posts_controller.dart';
import 'package:memorykeeper/model/Posts.dart';
import 'package:memorykeeper/pages/homepage.dart';
import 'package:memorykeeper/services/api_services_posts.dart';
import 'package:memorykeeper/utils/themes.dart';
import 'package:memorykeeper/widgets/app_bar.dart';
import 'package:provider/provider.dart';
import '../services/themes_services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddQuote extends StatefulWidget {
  const AddQuote({super.key});

  @override
  State<AddQuote> createState() => _AddQuoteState();
}

class _AddQuoteState extends State<AddQuote> {
  @override
  Widget build(BuildContext context) {
    PostsController _postsController = Provider.of<PostsController>(context);
    APIService apiService = APIService();
    bool isLight = context.watch<ThemeServices>().currentTheme == MyThemes.lightTheme;
    String? title;
    String? body;
    String? userId;
    int reactions = 0;
    List<String> tagList = ["example1","example2"];
    return Scaffold(
      appBar: appbar(context,"New Post"),
      body: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                label: const Text("Title"),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                  BorderSide(width: 3, color: isLight?pinkColor:darkGreyColor!), //<-- SEE HERE
                  borderRadius: BorderRadius.circular(18),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                  BorderSide(width: 3, color: isLight?pinkColor:darkGreyColor!), //<-- SEE HERE
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
              onChanged: (_val){
                title = _val;
              },
            ),
            const SizedBox(height: 30,),
            TextFormField(
              minLines: 3,
              maxLines: 5,
              decoration: InputDecoration(
                label: const Text("Content"),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                    BorderSide(width: 3, color: isLight?pinkColor:darkGreyColor!), //<-- SEE HERE
                    borderRadius: BorderRadius.circular(15),
                  ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                  BorderSide(width: 3, color: isLight?pinkColor:darkGreyColor!), //<-- SEE HERE
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              onChanged: (_val){
                body = _val;
              },
            ),
            const SizedBox(height: 30,),
            TextFormField(
              decoration: InputDecoration(
                  label: const Text("User Id"),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                  BorderSide(width: 3, color: isLight?pinkColor:darkGreyColor!), //<-- SEE HERE
                  borderRadius: BorderRadius.circular(18),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                  BorderSide(width: 3, color: isLight?pinkColor:darkGreyColor!), //<-- SEE HERE
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
              onChanged: (_val){
                userId = _val;
              },
            ),
            const SizedBox(height: 30,),
            Center(
              child: Container(
                height: 40,
                width: 100,
                decoration: BoxDecoration(
                  color: isLight?pinkColor:darkGreyColor!,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: TextButton(onPressed: () async{
                  Map<String,dynamic> data = {
                    "title": title,
                    "body": body,
                    "userId": int.parse(userId!),
                    "tags": tagList,
                    "reactions": reactions,
                        };
                  bool res = await _postsController.updateList(data);
                  // Posts res = await apiService.addPost(data);
                  print("displayig post list from addpost");
                  print(PostsController.postList.length);
                  print("get posts from add posts");
                  print(_postsController.getPostList().length);
                  res?Fluttertoast.showToast(msg: "Post Added",
                      backgroundColor: isLight?blueColor:lightGreyColor,
                    textColor: Colors.white
                  )
                      :Fluttertoast.showToast(msg: "Error adding quote",
                      backgroundColor: isLight?blueColor:lightGreyColor,
                      textColor: Colors.white);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const MyHomePage()));
                  // Navigator.pop(context);
                  setState((){});
                },
                    child: const Text(
                  "Save",
                      style: TextStyle(color: Colors.white),
                )),
              ),
            )
          ],
        ),
      )
    );
  }
}
