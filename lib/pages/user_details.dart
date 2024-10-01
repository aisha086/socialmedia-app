import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memorykeeper/model/Posts.dart';
import 'package:memorykeeper/model/users.dart';
import 'package:memorykeeper/services/api_services_users.dart';
import 'package:memorykeeper/widgets/app_bar.dart';
import 'package:provider/provider.dart';

import '../services/themes_services.dart';
import '../utils/themes.dart';

class UserDetailPage extends StatelessWidget {
  const UserDetailPage({super.key,required this.user});
  final Users user;

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    bool isLight =
        context.watch<ThemeServices>().currentTheme == MyThemes.lightTheme;
    UserServices userServices = UserServices();

    return Scaffold(
      appBar: appbar(context,"Profile"),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 25),
          decoration: BoxDecoration(
              color: isLight ? lightBeigeColor : lightGreyColor,
            border: Border.symmetric(vertical: BorderSide(color: blueColor,width: 2))
              ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(15),
                child: CircleAvatar(
                  backgroundColor: Colors.black26,
                  backgroundImage: NetworkImage(user.image),
                  radius: 30,
                ),
              ),
              Center(
                child: Text("${user.firstName} ${user.lastName}",
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: blueColor),
                ),
              ),
              Center(
                child: Text("@${user.username}",
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Colors.grey[600]
                  ),
                ),
              ),
              Divider(
                  color: blueColor,thickness: 1.5),
              Center(
                child: Text("About",
                    maxLines: 3,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: blueColor)),
              ),
              Divider(
                  color: blueColor,thickness: 1.5,),
              Container(
                padding: const EdgeInsets.all(10),
                child: Text(
                  "University : ${user.university}"
                      "\nCompany : ${user.company['name']}"
                      "\nSkill Department : ${user.company['department']}"
                      "\nJob Title : ${user.company['title']}"
                      "\nEmail : ${user.email}",
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.black,height: 1.5),
                ),
              ),
              Divider(
                  color: blueColor,thickness: 1.5,),
              Center(
                child: Text("Posts",
                    maxLines: 3,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: blueColor)),
              ),
              Divider(
                  color: blueColor,thickness: 1.5,),
              //FUTURE BUILDER SAME AS HOMEPAGE ONE
              FutureBuilder<List<Posts>>(
                  future: userServices.getUserPosts(user.id),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text(snapshot.error.toString()),
                      );
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      List<Posts> posts = snapshot.data!;
                      print("Printing post of user");
                      print(posts.length);
                      return Column(
                          children: posts.map((post) {
                            return Container(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 20,horizontal: 10),
                              padding: const EdgeInsets.all(10),
                              height: size.height / 2.8,
                              decoration: BoxDecoration(
                                  color:isLight ? lightBeigeColor : lightGreyColor,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: blueColor,
                                  width: 1.5
                                )
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundColor: blueColor,
                                        radius: 15,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      // )
                                      Expanded(
                                        child: Text(post.title,
                                            maxLines: 1,
                                            style: TextStyle(
                                                fontSize: 20,
                                                overflow: TextOverflow.ellipsis,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.grey[700])),
                                      ),
                                    ],
                                  ),
                                  Divider(
                                      color: blueColor,thickness: 1.5),
                                  const SizedBox(height: 20),
                                  Expanded(
                                    child: AutoSizeText(post.body,
                                        presetFontSizes: const [
                                          22,
                                          20,
                                          18,
                                          15,
                                          12,
                                          10
                                        ],
                                        maxLines: 10,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineSmall!
                                            .copyWith(
                                          color: Colors.grey[600],
                                        )),
                                  ),
                                  Divider(
                                      color: blueColor,thickness: 1.5,),
                                  Row(
                                    children: [
                                      Expanded(
                                          child: Container(
                                            alignment: Alignment.centerLeft,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [Text("User ID: ${post.userId}",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodySmall!
                                                      .copyWith(
                                                    color: Colors.grey[800],
                                                  )),
                                                Text("Tags: ${post.tags}",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodySmall!
                                                        .copyWith(
                                                      color: Colors.grey[600],
                                                    )),
                                              ],
                                            ),
                                          )),
                                      Icon(
                                        CupertinoIcons.heart_fill,
                                        color: pinkColor,
                                      ),
                                      Text("${post.reactions}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .copyWith(
                                            color: Colors.grey[600],
                                          ))
                                    ],
                                  ),
                                ],
                              ),
                            );
                          }).toList());
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
