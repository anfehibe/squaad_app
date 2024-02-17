import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesDatasource {
  static const String _keyLicense = "license";

  // Método para guardar la licencia en SharedPreferences
  static Future<bool> saveLicense(String license) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(_keyLicense, license);
  }

  // Método para obtener la licencia de SharedPreferences
  static Future<String?> getLicense() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyLicense);
  }

  // Otros métodos para guardar/recuperar otros tipos de datos
  // static Future<bool> saveInt(String key, int value) async {}
  // static Future<int?> getInt(String key) async {}
  // static Future<bool> saveBool(String key, bool value) async {}
  // static Future<bool?> getBool(String key) async {}
  // Y así sucesivamente para otros tipos de datos según sea necesario
}
