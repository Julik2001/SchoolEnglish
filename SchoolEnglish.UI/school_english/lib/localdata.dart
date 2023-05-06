import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalData {
  static void saveJwt(String jwt) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("jwt", jwt);
  }

  static Future<String?> getJwt() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("jwt");
  }
}
