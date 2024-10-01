import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/themes_services.dart';
import '../utils/themes.dart';

appbar(BuildContext context,String title){
  bool isLight = context.watch<ThemeServices>().currentTheme == MyThemes.lightTheme;
  return AppBar(
    title: Text(title),
    actions: [
      IconButton(
          onPressed: (){
            context.read<ThemeServices>().changeCurrentTheme();
          },
          icon: isLight
              ? const Icon(
            Icons.dark_mode_rounded,
          )
              : const Icon(
            Icons.light_mode_rounded,
          ),
          iconSize: 25,
          tooltip: isLight
              ? "Dark Mode" : "Light Mode"
      ),
    ],
  );
}