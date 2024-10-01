import 'package:flutter/material.dart';
import 'package:memorykeeper/controller/posts_controller.dart';
import 'package:memorykeeper/pages/homepage.dart';
import 'package:memorykeeper/services/themes_services.dart';
import 'package:provider/provider.dart';

void main() async{

  await PostsController.fetchPostList();

  runApp(
      MultiProvider(
          providers:[
            // ChangeNotifierProvider.value(value: PostsController()),
            // <PostsController>(
            //     create: (BuildContext context) => PostsController()),
            ChangeNotifierProvider<ThemeServices>(
          create: (BuildContext context) => ThemeServices(),

      )],
          child: const MyApp(),
      )
      );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(value: PostsController(),
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: Provider.of<ThemeServices>(context).currentTheme,
      home: const MyHomePage(),
    )
    );
      MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: Provider.of<ThemeServices>(context).currentTheme,
      home: const MyHomePage(),
    );
  }
}

