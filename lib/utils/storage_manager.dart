import 'package:shared_preferences/shared_preferences.dart';

class StorageManager {
  static Future saveData(String key, dynamic value) async {
    final prefs = await SharedPreferences.getInstance();
    if (value is int) {
      prefs.setInt(key, value);
    } else if (value is String) {
      prefs.setString(key, value);
    } else if (value is bool) {
      prefs.setBool(key, value);
    } else {
      //print("Invalid Type");
    }
  }

  static Future<dynamic> readData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    dynamic obj = prefs.get(key);
    return obj;
  }

  static Future<bool> deleteData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.remove(key);
  }
}

class StorageKeys {
  static const String n = "n_size";
  static const String sound = "sound";

  static const String baseNum = "base_number";
  static const String themeMode = "theme_mode";
  static const String highScore = "high_score";
  static const String score = "score";

  static const String savedGame = "last_game";
}
