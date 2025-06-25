import 'package:shared_preferences/shared_preferences.dart';

class MyPreferences {

  Future<void> setPreference(key,value) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString(key, value);
  }
  Future<void> setPreferenceInt(key,value) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setInt(key, value);
  }

 Future<String?> getPreference(key) async {
    final preference = await SharedPreferences.getInstance();
    return preference.getString(key);
  }

  Future<int?> getPreferenceInt(key) async {
    final preference = await SharedPreferences.getInstance();
    return preference.getInt(key);
  }


}