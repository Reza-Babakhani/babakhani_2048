import 'dart:math';

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
      decoration: getTileDecoration(widget._value),
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

BoxDecoration getTileDecoration(int value, {int baseNum = 2}) {
  const double raduis = 15;

  if (value == 0) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(raduis),
      color: Colors.white,
    );
  } else if (value == baseNum) {
    return BoxDecoration(
        borderRadius: BorderRadius.circular(raduis), color: Colors.white);
  } else if (value == baseNum * (pow(2, 1))) {
    return BoxDecoration(
        borderRadius: BorderRadius.circular(raduis),
        color: const Color.fromARGB(255, 221, 221, 221));
  } else if (value == baseNum * (pow(2, 2))) {
    return BoxDecoration(
        borderRadius: BorderRadius.circular(raduis),
        color: const Color.fromARGB(255, 223, 201, 201));
  } else if (value == baseNum * (pow(2, 3))) {
    return BoxDecoration(
        borderRadius: BorderRadius.circular(raduis),
        color: const Color.fromARGB(255, 242, 247, 216));
  } else if (value == baseNum * (pow(2, 4))) {
    return BoxDecoration(
        borderRadius: BorderRadius.circular(raduis),
        color: const Color.fromARGB(255, 231, 231, 191));
  } else if (value == baseNum * (pow(2, 5))) {
    return BoxDecoration(
        borderRadius: BorderRadius.circular(raduis),
        color: const Color.fromARGB(255, 203, 230, 231));
  } else if (value == baseNum * (pow(2, 6))) {
    return BoxDecoration(
        borderRadius: BorderRadius.circular(raduis),
        color: const Color.fromARGB(255, 182, 231, 233));
  } else if (value == baseNum * (pow(2, 7))) {
    return BoxDecoration(
        borderRadius: BorderRadius.circular(raduis),
        color: const Color.fromARGB(255, 236, 191, 191));
  } else if (value == baseNum * (pow(2, 8))) {
    return BoxDecoration(
        borderRadius: BorderRadius.circular(raduis),
        color: const Color.fromARGB(255, 255, 159, 159));
  } else if (value == baseNum * (pow(2, 9))) {
    return BoxDecoration(
        borderRadius: BorderRadius.circular(raduis),
        gradient: const LinearGradient(colors: [
          Color.fromRGBO(220, 220, 220, 1),
          Color.fromRGBO(240, 240, 240, 1),
          Color.fromRGBO(192, 192, 192, 1)
        ], begin: Alignment.topLeft, end: Alignment.bottomRight),
        boxShadow: const [
          BoxShadow(
              blurRadius: 4,
              color: Color.fromRGBO(220, 220, 220, 0.7),
              spreadRadius: 3)
        ]);
  } else if (value == baseNum * (pow(2, 10))) {
    return BoxDecoration(
        borderRadius: BorderRadius.circular(raduis),
        gradient: const LinearGradient(colors: [
          Color.fromRGBO(255, 230, 150, 1),
          Color.fromRGBO(255, 230, 200, 1),
          Color.fromRGBO(255, 215, 0, 1)
        ], begin: Alignment.topLeft, end: Alignment.bottomRight),
        boxShadow: const [
          BoxShadow(
              blurRadius: 4,
              color: Color.fromRGBO(255, 215, 0, 1),
              spreadRadius: 3)
        ]);
  } else if (value == baseNum * (pow(2, 11))) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(raduis),
      gradient: const LinearGradient(colors: [
        Color.fromRGBO(220, 220, 220, 1),
        Color.fromRGBO(240, 240, 240, 1),
        Color.fromRGBO(192, 192, 192, 1),
        Color.fromRGBO(220, 220, 220, 1),
        Color.fromRGBO(240, 240, 240, 1),
        Color.fromRGBO(192, 192, 192, 1),
      ], begin: Alignment.topLeft, end: Alignment.bottomRight),
      boxShadow: const [
        BoxShadow(
            blurRadius: 4,
            color: Color.fromRGBO(220, 220, 220, 0.7),
            spreadRadius: 3)
      ],
    );
  } else if (value == baseNum * (pow(2, 12))) {
    return BoxDecoration(
        borderRadius: BorderRadius.circular(raduis),
        gradient: const LinearGradient(colors: [
          Color.fromRGBO(255, 230, 150, 1),
          Color.fromRGBO(255, 230, 200, 1),
          Color.fromRGBO(255, 215, 0, 1),
          Color.fromRGBO(255, 230, 150, 1),
          Color.fromRGBO(255, 230, 200, 1),
          Color.fromRGBO(255, 215, 0, 1)
        ], begin: Alignment.topLeft, end: Alignment.bottomRight),
        boxShadow: const [
          BoxShadow(
              blurRadius: 4,
              color: Color.fromRGBO(255, 215, 0, 1),
              spreadRadius: 3)
        ]);
  } else if (value == baseNum * (pow(2, 13))) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(raduis),
      gradient: const LinearGradient(colors: [
        Color.fromRGBO(220, 220, 220, 1),
        Color.fromRGBO(240, 240, 240, 1),
        Color.fromRGBO(192, 192, 192, 1),
        Color.fromRGBO(220, 220, 220, 1),
        Color.fromRGBO(240, 240, 240, 1),
        Color.fromRGBO(192, 192, 192, 1),
        Color.fromRGBO(220, 220, 220, 1),
        Color.fromRGBO(240, 240, 240, 1),
        Color.fromRGBO(192, 192, 192, 1),
      ], begin: Alignment.topLeft, end: Alignment.bottomRight),
      boxShadow: const [
        BoxShadow(
            blurRadius: 4,
            color: Color.fromRGBO(220, 220, 220, 0.7),
            spreadRadius: 3)
      ],
    );
  } else if (value == baseNum * (pow(2, 14))) {
    return BoxDecoration(
        borderRadius: BorderRadius.circular(raduis),
        gradient: const LinearGradient(colors: [
          Color.fromRGBO(255, 230, 150, 1),
          Color.fromRGBO(255, 230, 200, 1),
          Color.fromRGBO(255, 215, 0, 1),
          Color.fromRGBO(255, 230, 150, 1),
          Color.fromRGBO(255, 230, 200, 1),
          Color.fromRGBO(255, 215, 0, 1),
          Color.fromRGBO(255, 230, 150, 1),
          Color.fromRGBO(255, 230, 200, 1),
          Color.fromRGBO(255, 215, 0, 1)
        ], begin: Alignment.topLeft, end: Alignment.bottomRight),
        boxShadow: const [
          BoxShadow(
              blurRadius: 4,
              color: Color.fromRGBO(255, 215, 0, 1),
              spreadRadius: 3)
        ]);
  } else {
    return BoxDecoration(
        borderRadius: BorderRadius.circular(raduis),
        boxShadow: const [
          BoxShadow(blurRadius: 7, color: Colors.white, spreadRadius: 7)
        ]);
  }
}
