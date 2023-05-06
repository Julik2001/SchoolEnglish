import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalData {
  static Future<void> saveJwt(String jwt) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("jwt", jwt);
  }

  static Future<String?> getJwt() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("jwt");
  }

  static Future<void> saveTeacherCode(String code) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("teacherCode", code);
  }

  static Future<String?> getTeacherCode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("teacherCode");
  }

  static Future<void> saveFullname(String fullname) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("fullname", fullname);
  }

  static Future<String?> getFullname() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("fullname");
  }

  static Future<bool> clear() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.clear();
  }
}
