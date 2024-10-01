import 'package:flutter/material.dart';

Color pinkColor = const Color(0xffFE4773);
Color blueColor = const Color(0xff2E6D92);
Color yellowishColor = const Color(0xffF6D68D);
Color lightBeigeColor = const Color(0xffE5DECA);
Color bizarreColor = const Color(0xffe5d1ca);
Color? greyColor = Colors.grey[800];
Color? darkGreyColor = Colors.grey[850];
Color? lightGreyColor = Colors.grey[350];


class MyThemes {

  static var lightTheme = ThemeData(
    scaffoldBackgroundColor: yellowishColor,
    brightness: Brightness.light,
    appBarTheme: AppBarTheme(
      color: pinkColor,
      centerTitle: true,
      elevation: 0,
      iconTheme: IconThemeData(
        color: darkGreyColor
      )
    )
  );

  static var darkTheme = ThemeData(
    scaffoldBackgroundColor: greyColor,
      brightness: Brightness.dark,
      appBarTheme: AppBarTheme(
          color: darkGreyColor,
          centerTitle: true,
          elevation: 0,
          iconTheme: IconThemeData(
              color: yellowishColor
          )
      )
  );

}