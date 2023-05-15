import 'package:shared_preferences/shared_preferences.dart';

class AppSharedPref {
  static AppSharedPref? _instance;

  static SharedPreferences? _prefs;

  AppSharedPref._() {
    initialize();
  }

  static void initialize() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  static AppSharedPref get instance {
    _instance ??= AppSharedPref._();
    return _instance!;
  }

  static Future<String?> getStringValue(String key) async {
    return _prefs!.getString(key);
  }

  static Future<bool?> getBoolValue(String key) async {
    return _prefs!.getBool(key);
  }

  static Future<int?> getIntValue(String key) async {
    return _prefs!.getInt(key);
  }

  static Future<double?> getDoubleValue(String key) async {
    return _prefs!.getDouble(key);
  }

  static Future<List<String>?> getStrListValue(String key) async {
    return _prefs!.getStringList(key);
  }

  static Future<bool> setValue(String key, dynamic value,
      {bool replacePrevList = false}) async {
    bool output = true;
    try {
      if (value is bool) {
        _prefs!.setBool(key, value);
      } else if (value is String) {
        _prefs!.setString(key, value);
      } else if (value is int) {
        _prefs!.setInt(key, value);
      } else if (value is double) {
        _prefs!.setDouble(key, value);
      } else if (value is List<String>) {
        List<String> finalList = [];
        if (replacePrevList) {
          finalList = value;
        } else {
          final prevList = await getStrListValue(key) ?? [];
          finalList.addAll(value..addAll(prevList));
        }
        _prefs!.setStringList(key, finalList);
      }
    } catch (e) {
      output = false;
    }
    return output;
  }
}
