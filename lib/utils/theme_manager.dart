import 'package:flutter/material.dart';
import '../assets/colors/my_palette.dart';
import 'storage_manager.dart';

class ThemeNotifier with ChangeNotifier {
  final darkTheme = ThemeData(
      primarySwatch: MyPalette.firstPalette,
      primaryColor: const Color(0xFF212121),
      appBarTheme: const AppBarTheme(backgroundColor: MyPalette.firstPalette),
      brightness: Brightness.dark,
      backgroundColor: const Color(0xFF212121),
      dividerColor: Colors.black12,
      useMaterial3: true);

  final lightTheme = ThemeData(
      primarySwatch: MyPalette.firstPalette,
      primaryColor: Colors.white,
      appBarTheme: const AppBarTheme(backgroundColor: MyPalette.firstPalette),
      brightness: Brightness.light,
      backgroundColor: const Color(0xFFE5E5E5),
      dividerColor: Colors.white54,
      useMaterial3: true);

  ThemeData? _themeData;
  bool? _isDarkMode;

  ThemeNotifier() {
    StorageManager.readData(StorageKeys.themeMode).then((value) {
      var themeMode = value ?? 'light';
      if (themeMode == 'light') {
        _themeData = lightTheme;
        _isDarkMode = false;
      } else {
        _themeData = darkTheme;
        _isDarkMode = true;
      }
      notifyListeners();
    });
  }

  void setDarkMode() async {
    _themeData = darkTheme;
    StorageManager.saveData(StorageKeys.themeMode, 'dark');
    _isDarkMode = true;
    notifyListeners();
  }

  void setLightMode() async {
    _themeData = lightTheme;
    StorageManager.saveData(StorageKeys.themeMode, 'light');
    _isDarkMode = false;

    notifyListeners();
  }

  ThemeData getTheme() {
    return _themeData ?? lightTheme;
  }

  bool isDarkMode() {
    return _isDarkMode ?? false;
  }
}
