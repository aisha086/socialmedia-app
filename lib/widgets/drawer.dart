import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memorykeeper/pages/followers.dart';
import 'package:provider/provider.dart';

import '../pages/add_post.dart';
import '../services/themes_services.dart';
import '../utils/themes.dart';

drawer(BuildContext context)
{
  bool isLight = context.watch<ThemeServices>().currentTheme == MyThemes.lightTheme;
  return Drawer(
    backgroundColor: isLight?pinkColor:darkGreyColor,
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(

            padding: EdgeInsets.zero,
            child: UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                  color: isLight?pinkColor:darkGreyColor
              ),
              margin: EdgeInsets.zero,
              accountName: const Text("Aisha Siddiqui"),
              accountEmail: const Text("aishasiddiqui123@gmail.com"),
              currentAccountPicture: const CircleAvatar(
                backgroundImage: AssetImage("assets/images/cat_cute.jpeg"),
              ),
            )),
        GestureDetector(
          onTap: (){
            Navigator.push(context, MaterialPageRoute
              (builder: (context) => const ShowFollowers())
            );
          },
          child: ListTile(
            leading: Icon(
              CupertinoIcons.person_2_fill,
              color: yellowishColor,
            ),
            title: Text(
              "Followers",
              style: TextStyle(color: yellowishColor, fontSize: 20),
            ),
          ),
        ),
        GestureDetector(
          onTap: (){
            Navigator.push(context, MaterialPageRoute
              (builder: (context) => const AddQuote())
            );
          },
          child: ListTile(
            leading: Icon(
              CupertinoIcons.add_circled,
              color: yellowishColor,
            ),
            title: Text(
              "Add New Post",
              style: TextStyle(color: yellowishColor, fontSize: 20),
            ),
          ),
        ),
      ],
    ),
  );

}