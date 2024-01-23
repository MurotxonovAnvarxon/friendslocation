import 'package:shared_preferences/shared_preferences.dart';

class MyPref {
  static late final SharedPreferences _pref;

  static void init() async {
    _pref = await SharedPreferences.getInstance();
  }

  static void saveName(String name) {
    _pref.setString("name", name);
  }


  static String? getName(){
    return _pref.getString("name");
  }
}
