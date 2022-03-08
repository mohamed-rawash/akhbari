import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper{
  static SharedPreferences? _preferences;
  static init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static Future<bool> putData({
    required String key,
    required bool value
})async
  {
    return await _preferences!.setBool(key, value);
  }

  static bool? getData({required String key}){
    return _preferences!.getBool(key);
  }
}