import 'package:flutter/material.dart';
import '../utils/storage_manager.dart';

class GameSetting extends ChangeNotifier {
  int _n = 4;
  int _baseNum = 2;
  bool _sound = true;
  int get n {
    return _n;
  }

  int get baseNum {
    return _baseNum;
  }

  bool get sound {
    return _sound;
  }

  Future<bool> setN(int n) async {
    if (n > 9 || n < 3) {
      return false;
    }

    await StorageManager.saveData(StorageKeys.n, n);
    _n = n;
    notifyListeners();
    return true;
  }

  Future<bool> setBaseNumber(int baseNum) async {
    if (baseNum > 10 || baseNum < 2) {
      return false;
    }

    await StorageManager.saveData(StorageKeys.baseNum, baseNum);
    _baseNum = baseNum;
    notifyListeners();
    return true;
  }

  Future<void> setSound(bool sound) async {
    await StorageManager.saveData(StorageKeys.sound, sound);
    _sound = sound;
    notifyListeners();
  }

  Future<void> _fetchN() async {
    var result = await StorageManager.readData(StorageKeys.n);

    if (result == null) {
      _n = 4;
      await setN(_n);
    } else {
      _n = result;
    }
  }

  Future<void> _fetchBaseNumber() async {
    var result = await StorageManager.readData(StorageKeys.baseNum);

    if (result == null) {
      _baseNum = 2;
      await setBaseNumber(_baseNum);
    } else {
      _baseNum = result;
    }
  }

  Future<void> _fetchSound() async {
    var result = await StorageManager.readData(StorageKeys.sound);

    if (result == null) {
      _sound = true;
      await setSound(_sound);
    } else {
      _sound = result;
    }
  }

  Future<void> fetch() async {
    await _fetchBaseNumber();
    await _fetchN();
    await _fetchSound();

    notifyListeners();
  }
}
