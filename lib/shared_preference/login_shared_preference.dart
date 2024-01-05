// import 'package:shared_preferences/shared_preferences.dart';

// Future<void> saveTokenToSharedPreferences(String token) async {
//   final SharedPreferences prefs = await SharedPreferences.getInstance();
//   prefs.setString('jwtToken', token);
// }

import 'dart:ffi';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesUtil {
  static const String tokenKey = 'TokenKey';
  static const String islogin = 'Login';
  static bool keyLoging = false;

  static Future<void> saveToken(String token) async {
    print('sharedprefernce token: ${token}');
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    print('prefs saved---token: ${prefs}');
    await prefs.setString(tokenKey, token);
  }

  static Future<String?> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    print('prefs--get--- token: ${prefs}');
    return prefs.getString(tokenKey);
  }

  static Future<void> setLogin(bool login) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(islogin, login);
  }

  static Future<bool?> getLogin() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(islogin);
  }

  static Future<void> logout() async {
    final SharedPreferences pre = await SharedPreferences.getInstance();
    pre.remove(islogin);
  }
}
