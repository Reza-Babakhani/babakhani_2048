import 'dart:math';

import 'package:babakhani_2048/providers/settings.dart';
import 'package:babakhani_2048/utils/storage_manager.dart';
import 'package:babakhani_2048/widgets/tile.dart';
import 'package:flutter/material.dart';

class Game extends ChangeNotifier {
  late int _n;
  late int _baseNum;
  Game(GameSetting? setting) {
    _n = setting?.n ?? 4;
    _baseNum = setting?.baseNum ?? 2;
    reset();
  }

  void reset() {
    StorageManager.readData(StorageKeys.highScore)
        .then((value) {
          _highScore = value;
        })
        .catchError((e) {})
        .whenComplete(() => {});

    _isGameOver = false;
    _score = 0;
    _rows = List<List<Tile>>.generate(
        n, (index) => List.generate(n, (index) => Tile(0)));

    _addTile();
    _addTile();

    notifyListeners();
  }

  List<List<Tile>> _rows = [];
  int get n {
    return _n;
  }

  int get baseNum {
    return _baseNum;
  }

  bool _isGameOver = false;
  bool get isGameOver {
    return _isGameOver;
  }

  int _score = 0;
  int get score {
    return _score;
  }

  int _highScore = 0;
  int get highScore {
    return _highScore;
  }

  List<Tile> get tiles {
    List<Tile> t = [];

    for (var row in _rows) {
      t.addAll(row);
    }
    return t;
  }

  _addTile() {
    var random = Random();

    List<IandJ> emptyIndexList = [];

    for (int i = 0; i < n; i++) {
      for (int j = 0; j < n; j++) {
        if (_rows[i][j].value == 0) {
          emptyIndexList.add(IandJ(i, j));
        }
      }
    }

    if (emptyIndexList.isEmpty) {
      _isGameOver = true;
    } else {
      emptyIndexList.shuffle();

      _rows[emptyIndexList[0].i][emptyIndexList[0].j] =
          Tile(random.nextDouble() > 0.9 ? baseNum * 2 : baseNum);
    }
  }

  void moveUp() {
    bool isTileMoved = false;

    for (int j = 0; j < n; j++) {
      for (int k = 0; k < n; k++) {
        for (int i = 1; i < n; i++) {
          if (_rows[i - 1][j].value == 0 && _rows[i][j].value != 0) {
            _rows[i - 1][j] = Tile(_rows[i][j].value);
            _rows[i][j] = Tile(0);
            isTileMoved = true;
          }
        }
      }
    }

    for (int j = 0; j < n; j++) {
      for (int i = 1; i < n; i++) {
        if (_rows[i - 1][j].value != 0 &&
            _rows[i][j].value != 0 &&
            _rows[i][j].value == _rows[i - 1][j].value) {
          _rows[i - 1][j] = Tile(_rows[i][j].value * 2);
          _rows[i][j] = Tile(0);
          isTileMoved = true;
          _score += _rows[i - 1][j].value;
        }
      }
    }

    for (int j = 0; j < n; j++) {
      for (int k = 0; k < n; k++) {
        for (int i = 1; i < n; i++) {
          if (_rows[i - 1][j].value == 0 && _rows[i][j].value != 0) {
            _rows[i - 1][j] = Tile(_rows[i][j].value);
            _rows[i][j] = Tile(0);
            isTileMoved = true;
          }
        }
      }
    }
    afterMove(isTileMoved);
  }

  void moveDown() {
    bool isTileMoved = false;

    for (int j = 0; j < n; j++) {
      for (int k = 0; k < n; k++) {
        for (int i = n - 2; i >= 0; i--) {
          if (_rows[i + 1][j].value == 0 && _rows[i][j].value != 0) {
            _rows[i + 1][j] = Tile(_rows[i][j].value);
            _rows[i][j] = Tile(0);
            isTileMoved = true;
          }
        }
      }
    }

    for (int j = 0; j < n; j++) {
      for (int i = n - 2; i >= 0; i--) {
        if (_rows[i + 1][j].value != 0 &&
            _rows[i][j].value != 0 &&
            _rows[i][j].value == _rows[i + 1][j].value) {
          _rows[i + 1][j] = Tile(_rows[i][j].value * 2);
          _rows[i][j] = Tile(0);
          isTileMoved = true;

          _score += _rows[i + 1][j].value;
        }
      }
    }

    for (int j = 0; j < n; j++) {
      for (int k = 0; k < n; k++) {
        for (int i = n - 2; i >= 0; i--) {
          if (_rows[i + 1][j].value == 0 && _rows[i][j].value != 0) {
            _rows[i + 1][j] = Tile(_rows[i][j].value);
            _rows[i][j] = Tile(0);
            isTileMoved = true;
          }
        }
      }
    }
    afterMove(isTileMoved);
  }

  void moveLeft() {
    bool isTileMoved = false;

    for (int i = 0; i < n; i++) {
      for (int k = 0; k < n; k++) {
        for (int j = 1; j < n; j++) {
          if (_rows[i][j - 1].value == 0 && _rows[i][j].value != 0) {
            _rows[i][j - 1] = Tile(_rows[i][j].value);
            _rows[i][j] = Tile(0);
            isTileMoved = true;
          }
        }
      }
    }

    for (int i = 0; i < n; i++) {
      for (int j = 1; j < n; j++) {
        if (_rows[i][j - 1].value != 0 &&
            _rows[i][j].value != 0 &&
            _rows[i][j].value == _rows[i][j - 1].value) {
          _rows[i][j - 1] = Tile(_rows[i][j].value * 2);
          _rows[i][j] = Tile(0);
          isTileMoved = true;

          _score += _rows[i][j - 1].value;
        }
      }
    }

    for (int i = 0; i < n; i++) {
      for (int k = 0; k < n; k++) {
        for (int j = 1; j < n; j++) {
          if (_rows[i][j - 1].value == 0 && _rows[i][j].value != 0) {
            _rows[i][j - 1] = Tile(_rows[i][j].value);
            _rows[i][j] = Tile(0);
            isTileMoved = true;
          }
        }
      }
    }
    afterMove(isTileMoved);
  }

  void moveRight() {
    bool isTileMoved = false;

    for (int i = 0; i < n; i++) {
      for (int k = 0; k < n; k++) {
        for (int j = n - 2; j >= 0; j--) {
          if (_rows[i][j + 1].value == 0 && _rows[i][j].value != 0) {
            _rows[i][j + 1] = Tile(_rows[i][j].value);
            _rows[i][j] = Tile(0);
            isTileMoved = true;
          }
        }
      }
    }

    for (int i = 0; i < n; i++) {
      for (int j = n - 2; j >= 0; j--) {
        if (_rows[i][j + 1].value != 0 &&
            _rows[i][j].value != 0 &&
            _rows[i][j].value == _rows[i][j + 1].value) {
          _rows[i][j + 1] = Tile(_rows[i][j].value * 2);
          _rows[i][j] = Tile(0);
          isTileMoved = true;

          _score += _rows[i][j + 1].value;
        }
      }
    }

    for (int i = 0; i < n; i++) {
      for (int k = 0; k < n; k++) {
        for (int j = n - 2; j >= 0; j--) {
          if (_rows[i][j + 1].value == 0 && _rows[i][j].value != 0) {
            _rows[i][j + 1] = Tile(_rows[i][j].value);
            _rows[i][j] = Tile(0);
            isTileMoved = true;
          }
        }
      }
    }
    afterMove(isTileMoved);
  }

  void afterMove(bool isTileMoved) {
    if (isTileMoved) {
      _addTile();

      if (_score > _highScore) {
        _highScore = _score;
        StorageManager.saveData(StorageKeys.highScore, _score)
            .then((success) {})
            .catchError((e) {})
            .whenComplete(() {});
      }
    } else {
      if (tiles.length == n * n &&
          !tiles.any((element) => element.value == 0)) {
        _isGameOver = true;
      }
    }

    notifyListeners();
  }
}

class IandJ {
  IandJ(this._i, this._j);

  final int _i;
  final int _j;

  int get i => _i;
  int get j => _j;
}
