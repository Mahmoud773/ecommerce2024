//
import 'package:shared_preferences/shared_preferences.dart';

class MySharedPreferences {
   SharedPreferences? _Preferences;
    init() async {
     _Preferences = await SharedPreferences.getInstance();
   }

  static Future setIsDoctor( bool isDoctor) async {

  }
}