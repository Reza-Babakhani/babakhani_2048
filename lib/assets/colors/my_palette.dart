import 'package:flutter/material.dart';

class MyPalette {
  static const MaterialColor firstPalette = MaterialColor(
    0xffaeafb1, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    <int, Color>{
      50: Color(0xffF1F2F2), //10%
      100: Color(0xffDDDDDE), //20%
      200: Color(0xffC7C7C8), //30%
      300: Color(0xffB0B1B2), //40%
      400: Color(0xff9FA0A2), //50%
      500: Color(0xff8E8F91), //60%
      600: Color(0xff868789), //70%
      700: Color(0xff7B7C7E), //80%
      800: Color(0xff717274), //90%
      900: Color(0xff5F6062), //100%
    },
  );
}
