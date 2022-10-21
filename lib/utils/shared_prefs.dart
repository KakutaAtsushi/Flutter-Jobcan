import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static SharedPreferences? _preferences;

  static Future<void> setPrefsInstance() async {
    _preferences ??= await SharedPreferences.getInstance();
  }

  static Future<void> setProf(
      String name, String email, String password) async {
    await _preferences!.setString("name", name);
    await _preferences!.setString("email", email);
    await _preferences!.setString("password", password);
  }

  static String? fetchUsername() {
    return _preferences!.getString("username");
  }

  static String? fetchEmail() {
    return _preferences!.getString("email");
  }

  static String? fetchPassword() {
    return _preferences!.getString("password");
  }
}
