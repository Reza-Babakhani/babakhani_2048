import 'package:flutter/material.dart';

class Tile extends StatefulWidget {
  int _value = 0;

  int get value {
    return _value;
  }

  Tile(
    this._value, {
    super.key,
  });

  @override
  State<Tile> createState() => _TileState();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return _value.toString();
  }
}

class _TileState extends State<Tile> {
  setValue(int val) {
    widget._value = val;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: getTileColor(widget._value)),
      child: Center(
        child: FittedBox(
          fit: BoxFit.fitWidth,
          child: Text(
            widget._value == 0 ? " " : "${widget._value}",
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}

Color getTileColor(int value) {
  switch (value) {
    case 0:
      return Colors.white;
    case 2:
      return Colors.blue.shade700;
    case 4:
      return Colors.yellow;
    case 8:
      return Colors.green;
    case 16:
      return Colors.red;
    case 32:
      return Colors.purple;
    case 64:
      return Colors.orange;
    case 128:
      return Colors.indigo;
    case 256:
      return Colors.grey;
    case 512:
      return Colors.lime;
    case 1024:
      return Colors.pink;
    case 2048:
      return Colors.teal;
    case 4096:
      return Colors.lightGreen;
    case 8192:
      return Colors.amber;
    case 16384:
      return Colors.brown;
    case 32768:
      return Colors.cyan;
    case 65536:
      return Colors.black;
    default:
      return Colors.white;
  }
}
