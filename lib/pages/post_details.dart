import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:memorykeeper/model/comments.dart';
import 'package:memorykeeper/services/api_services_comments.dart';
import 'package:memorykeeper/utils/themes.dart';
import 'package:provider/provider.dart';

import '../services/themes_services.dart';
import '../widgets/app_bar.dart';

class PostDetails extends StatefulWidget {
  const PostDetails(
      {super.key,
      required this.title,
      required this.body,
      required this.reactions,
      required this.userId,
      required this.tags,
      required this.id});

  final String title;
  final String body;
  final int reactions;
  final int userId;
  final int id;
  final List<String> tags;

  @override
  State<PostDetails> createState() => _PostDetailsState();
}

class _PostDetailsState extends State<PostDetails> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    CommentService commentService = CommentService();
    bool isLight =
        context.watch<ThemeServices>().currentTheme == MyThemes.lightTheme;

    return Scaffold(
      backgroundColor: isLight ? yellowishColor : greyColor,
      appBar: appbar(context,"Post"),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 25,vertical: 10),
        height: size.height/1.15,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isLight ? lightBeigeColor : lightGreyColor,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
                width: 1.0,
                color: isLight
                    ? Colors.white
                    : Colors.grey[700]!)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Title: ${widget.title}",
                    maxLines: 3,
                    style: const TextStyle(
                        fontSize: 20,
                        overflow: TextOverflow.ellipsis,
                        fontWeight: FontWeight.w500,
                        color: Colors.black)),
                Divider(color: isLight ? Colors.white : Colors.grey[700]),
                Row(
                  children: [
                    Expanded(
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Tags: ${widget.tags}",
                                  style:
                                  Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: Colors.grey[600],
                                  )),
                            ],
                          ),
                        )),
                    Text("Reactions: ${widget.reactions}",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Colors.grey[600],
                        ))
                  ],
                ),
                Divider(color: isLight ? Colors.white : Colors.grey[700]),
                AutoSizeText(widget.body,
                    presetFontSizes: const [
                      18,
                      17,
                      16,
                      15,
                      14,
                    ],
                    maxLines: 8,
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      fontSize: 18,
                      color: Colors.grey[600],
                    )),
              ],
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: const Text("Comments",
                  maxLines: 3,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.black)),
            ),
            Divider(color: isLight ? Colors.white : Colors.grey[700]),
            Expanded(
              child: FutureBuilder(
                  future: commentService.getComments(widget.id),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text(snapshot.error.toString()),
                      );
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      List<comments> commentList = snapshot.data!;
                      print("Printing comments");
                      print(commentList.length);
                      if (commentList.isNotEmpty) {
                        return ListView.builder(
                            itemCount: commentList.length,
                            itemBuilder: (context, index) {
                              final comment = commentList[index];
                              return Container(
                                margin: const EdgeInsets.symmetric(vertical: 5),
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                        width: 1.0,
                                        color: isLight
                                            ? Colors.white
                                            : Colors.grey[700]!)),
                                child: Row(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(right: 10),
                                      child: CircleAvatar(
                                        radius: 18,
                                        backgroundColor: blueColor,
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(
                                            comment.user["username"],
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            comment.body,
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 15,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            });
                      } else {
                        return const Center(
                          child: Text("No Comments"),
                        );
                      }
                    }
                  }),
            )
          ],
        ),
      ),
    );
  }
}
