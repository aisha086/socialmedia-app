import 'package:flutter/material.dart';
import 'package:memorykeeper/services/preference_helper.dart';
import 'package:memorykeeper/utils/themes.dart';


class ThemeServices extends ChangeNotifier
{

  ThemeData currentTheme = MyThemes.lightTheme;
  bool isDark = false;

  SavePreference pre = SavePreference();

  ThemeServices() {
    setInitialTheme();
  }
// new method
  setInitialTheme() {

      ThemeData theme;
      pre.getTheme().then((value) {
         theme = (value == "true") ? MyThemes.darkTheme : MyThemes.lightTheme;
        currentTheme = theme;
        notifyListeners();
      }
    );
  }

  changeCurrentTheme()
  {
    if(currentTheme==MyThemes.lightTheme)
      {
        currentTheme=MyThemes.darkTheme;
        isDark=true;
      }
    else
      {
        currentTheme = MyThemes.lightTheme;
        isDark=false;
      }
    pre.setTheme(isDark);
    notifyListeners();
  }
}