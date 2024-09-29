import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static Future<void> setUserToken(String? token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (token == null) {
      await prefs.remove('userToken');
    } else {
      await prefs.setString('userToken', token);
    }
  }

  static Future<void> setUserAccountExists(bool exists) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('userHasAccount', exists);
  }

  static Future<String?> getUserToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('userToken');
  }

  static Future<bool> getUserHasAccount() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('userHasAccount') ?? false;
  }
}
