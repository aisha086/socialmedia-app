import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:memorykeeper/controller/posts_controller.dart';
import 'package:memorykeeper/model/Posts.dart';
import 'package:memorykeeper/pages/add_post.dart';
import 'package:memorykeeper/pages/post_details.dart';
import 'package:memorykeeper/services/api_services_posts.dart';
import 'package:memorykeeper/services/themes_services.dart';
import 'package:memorykeeper/utils/themes.dart';
import 'package:memorykeeper/widgets/app_bar.dart';
import 'package:memorykeeper/widgets/drawer.dart';
import 'package:provider/provider.dart';
import 'package:auto_size_text/auto_size_text.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  APIService apiService = APIService();
  late Future<List<Posts>> futurePosts;
  final PostsController _postsController = PostsController();

  @override
  void initState() {
    super.initState();
    // context.read<PostsController>().fetchPostList();
    // futurePosts = apiService.getPosts();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool isLight =
        context.watch<ThemeServices>().currentTheme == MyThemes.lightTheme;

    return Scaffold(
        appBar: appbar(context,'Home'),
        body:
            FutureBuilder<void>(
                future: _postsController.isfetched(),
                // future: futurePosts,
                // builder: (context,snapshot){
                //   print(snapshot.hasData);
                //   if(snapshot.hasData){
                //     // List<Quote> quotes = snapshot.data!;
                //     final List<Posts> posts = snapshot.data as List<Posts>;
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(snapshot.error.toString()),
                    );
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    List<Posts> posts = _postsController.getPostList();
                    print("Printing post of homepage");
                    print(posts.length);
                    return ListView.builder(
                        itemCount: posts.length,
                        itemBuilder: (context, index) {
                          final post = posts[index];
                          return GestureDetector(
                            onDoubleTap: (){
                              Navigator.push(context, MaterialPageRoute
                                (builder: (context) => PostDetails
                                (
                                title: post.title,
                                body: post.body,
                                reactions: post.reactions,
                                tags: post.tags,
                                userId: post.userId,
                                id:post.id
                              ))
                              );
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 40),
                              padding: const EdgeInsets.all(10),
                              height: size.height / 2.5,
                              decoration: BoxDecoration(
                                  color:
                                  isLight ? lightBeigeColor : lightGreyColor,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                        color: isLight
                                            ? pinkColor.withOpacity(0.5)
                                            : darkGreyColor!.withOpacity(0.5),
                                        blurRadius: 5,
                                        offset: const Offset(0, 5))
                                  ]),
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
                                      color: isLight
                                          ? Colors.white
                                          : Colors.grey[700]),
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
                                        maxLines: 8,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineSmall!
                                            .copyWith(
                                          color: Colors.grey[600],
                                        )),
                                  ),
                                  Divider(
                                      color: isLight
                                          ? Colors.white
                                          : Colors.grey[600]),
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
                                      IconButton(
                                        onPressed: () async {
                                          Map<String, dynamic> data = {
                                            "id": post.id
                                          };
                                          bool res = await  _postsController.removePost(index,data);
                                              res ? Fluttertoast.showToast(
                                              msg: "Post Deleted",
                                              backgroundColor: isLight
                                                  ? blueColor
                                                  : lightGreyColor,
                                              textColor: Colors.white)
                                              : Fluttertoast.showToast(
                                              msg: "Error deleting",
                                              backgroundColor: isLight
                                                  ? blueColor
                                                  : lightGreyColor,
                                              textColor: Colors.white);
                                              setState(() {});
                                        },
                                        icon: Icon(
                                          Icons.delete,
                                          size: 22,
                                          color: Colors.grey[600],
                                        ),
                                      ),
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
                                  )
                                ],
                              ),
                            ),
                          );
                        });
                  }
                }),
        drawer: drawer(context),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const AddQuote()));
          },
          backgroundColor: isLight ? pinkColor : yellowishColor,
          tooltip: "Add new Post",
          child: const Icon(Icons.add),
        ));
  }
}
