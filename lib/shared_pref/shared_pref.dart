import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper{
  static late SharedPreferences sharedPreferences ;
  static init()async{
    sharedPreferences = await SharedPreferences.getInstance();
  }
  static Future <bool>  putValue({
    required String key,
    required dynamic value,
})async{
    if(value is String) {
      return await sharedPreferences.setString(key, value);
    } else if(value is bool) {
      return await sharedPreferences.setBool(key, value);
    } else if(value is int) {
      return await sharedPreferences.setInt(key, value);
    } else {
      return await sharedPreferences.setDouble(key, value);
    }
  }
  static Object? getValue({required key}){
    return sharedPreferences.get(key);
  }
  static Future <bool>removeValue({required String key}){
    return sharedPreferences.remove(key);
  }
}