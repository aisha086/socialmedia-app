import 'package:shared_preferences/shared_preferences.dart';


//preferences
class SavePreference {
  Future<void> setTheme(bool theme) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDark', theme);
  }

// to get the mode
  Future<String> getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isDark').toString()??"false";
  }
}

