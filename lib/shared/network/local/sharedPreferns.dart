import 'package:shared_preferences/shared_preferences.dart';

class CashHelper {
  static late SharedPreferences sharedPreferences;
  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> SaveData({
    required String key,
    required dynamic value,
  }) async {
    //  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    if (value is String) return await sharedPreferences.setString(key, value);
    if (value is int) return await sharedPreferences.setInt(key, value);
    if (value is bool) return await sharedPreferences.setBool(key, value);
    return await sharedPreferences.setDouble(key, value);
  }

  static dynamic getData({
    required String key,
  }) {
    //  SharedPreferences sharedPreferences =  SharedPreferences.getInstance();

    return sharedPreferences.get(key);
  }

  static Future<bool> ClearData({
    required String key,
  }) {
  return  sharedPreferences.remove(key);
  }
}
