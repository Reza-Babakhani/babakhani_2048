import 'dart:math';

import 'package:babakhani_2048/widgets/tile.dart';
import 'package:flutter/material.dart';

class Game extends ChangeNotifier {
  final int _n;
  Game(this._n) {
    reset();
  }

  void reset() {
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

  bool _isGameOver = false;
  bool get isGameOver {
    return _isGameOver;
  }

  int _score = 0;
  int get score {
    return _score;
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
          Tile(random.nextDouble() > 0.9 ? 4 : 2);
    }
  }

  void moveUp() {
    bool isTileMoved = false;
    for (int i = 1; i < n; i++) {
      for (int j = 0; j < n; j++) {
        for (int k = i - 1; k >= 0; k--) {
          if (_rows[k][j].value == 0 && _rows[k + 1][j].value != 0) {
            _rows[k][j] = Tile(_rows[k + 1][j].value);
            _rows[k + 1][j] = Tile(0);
            isTileMoved = true;
          } else if (_rows[k][j].value == _rows[k + 1][j].value &&
              _rows[k + 1][j].value != 0 &&
              _rows[k][j].value != 0) {
            _rows[k][j] = Tile(_rows[k + 1][j].value * 2);
            _rows[k + 1][j] = Tile(0);
            isTileMoved = true;

            _score += _rows[k][j].value;
          }
        }
      }
    }

    afterMove(isTileMoved);
  }

  void moveDown() {
    bool isTileMoved = false;
    for (int i = n - 2; i >= 0; i--) {
      for (int j = 0; j < n; j++) {
        for (int k = i + 1; k < n; k++) {
          if (_rows[k][j].value == 0 && _rows[k - 1][j].value != 0) {
            var tempTile = _rows[k][j];
            _rows[k][j] = _rows[k - 1][j];
            _rows[k - 1][j] = tempTile;
            isTileMoved = true;
          } else if (_rows[k][j].value == _rows[k - 1][j].value &&
              _rows[k - 1][j].value != 0 &&
              _rows[k][j].value != 0) {
            _rows[k][j] = Tile(_rows[k - 1][j].value * 2);
            _rows[k - 1][j] = Tile(0);
            isTileMoved = true;

            _score += _rows[k][j].value;
          }
        }
      }
    }

    afterMove(isTileMoved);
  }

  void moveLeft() {
    bool isTileMoved = false;
    for (int j = 1; j < n; j++) {
      for (int i = 0; i < n; i++) {
        for (int k = j - 1; k >= 0; k--) {
          if (_rows[i][k].value == 0 && _rows[i][k + 1].value != 0) {
            var tempTile = _rows[i][k];
            _rows[i][k] = _rows[i][k + 1];
            _rows[i][k + 1] = tempTile;
            isTileMoved = true;
          } else if (_rows[i][k].value == _rows[i][k + 1].value &&
              _rows[i][k + 1].value != 0 &&
              _rows[i][k].value != 0) {
            _rows[i][k] = Tile(_rows[i][k + 1].value * 2);
            _rows[i][k + 1] = Tile(0);
            isTileMoved = true;

            _score += _rows[i][k].value;
          }
        }
      }
    }

    afterMove(isTileMoved);
  }

  void moveRight() {
    bool isTileMoved = false;
    for (int j = n - 2; j >= 0; j--) {
      for (int i = 0; i < n; i++) {
        for (int k = j + 1; k < n; k++) {
          if (_rows[i][k].value == 0 && _rows[i][k - 1].value != 0) {
            var tempTile = _rows[i][k];
            _rows[i][k] = _rows[i][k - 1];
            _rows[i][k - 1] = tempTile;
            isTileMoved = true;
          } else if (_rows[i][k].value == _rows[i][k - 1].value &&
              _rows[i][k - 1].value != 0 &&
              _rows[i][k].value != 0) {
            _rows[i][k] = Tile(_rows[i][k - 1].value * 2);
            _rows[i][k - 1] = Tile(0);
            isTileMoved = true;

            _score += _rows[i][k].value;
          }
        }
      }
    }

    afterMove(isTileMoved);
  }

  void afterMove(bool isTileMoved) {
    if (isTileMoved) {
      _addTile();
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
