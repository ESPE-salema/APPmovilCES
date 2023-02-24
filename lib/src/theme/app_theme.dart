import 'package:flutter/material.dart';

class AppTheme {
  static final TextTheme _textTheme = TextTheme(
    displayLarge: _headLine1,
    displayMedium: _headLine2,
    displaySmall: _headLine3,
    headlineMedium: _headLine4,
    headlineSmall: _headLine5,
    titleLarge: _headLine6,
    bodyLarge: _bodyText1,
    bodyMedium: _bodyText2,
    titleMedium: _subTitle1,
    titleSmall: _subTitle2,
    bodySmall: _caption,
  );

  static const TextStyle _headLine1 =
      TextStyle(fontFamily: 'Raleway', fontWeight: FontWeight.bold);

  static final TextStyle _headLine2 = _headLine1.copyWith();
  static final TextStyle _headLine3 = _headLine2.copyWith();
  static final TextStyle _headLine4 = _headLine3.copyWith();
  static final TextStyle _headLine5 = _headLine4.copyWith();
  static final TextStyle _headLine6 = _headLine5.copyWith();
  static final TextStyle _subTitle1 = _headLine6.copyWith();
  static final TextStyle _subTitle2 = _subTitle1.copyWith();
  static final TextStyle _bodyText1 = _subTitle2.copyWith();
  static final TextStyle _bodyText2 = _bodyText1.copyWith();
  static final TextStyle _caption = _bodyText2.copyWith();

  static ThemeData themeData(bool lightMode) {
    return ThemeData(
        // ignore: deprecated_member_use
        accentColor: Palette.color,
        primarySwatch: Palette.color,
        textTheme: _textTheme,
        brightness: lightMode ? Brightness.light : Brightness.dark);
  }
}

class Palette {
  static const MaterialColor color = MaterialColor(
    0xFF03A9F4, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    <int, Color>{
      50: Color(0xFF039FEA), //10%
      100: Color(0xFF0395E0), //20%
      200: Color(0xFF038BD6), //30%
      300: Color(0xFF0381CC), //40%
      400: Color(0xFF0377C2), //50%
      500: Color(0xFF036DB8), //60%
      600: Color(0xFF0363AE), //70%
      700: Color(0xFF0359A4), //80%
      800: Color(0xFF034F9A), //90%
      900: Color(0xFF034590), //100%
    },
  );
}
