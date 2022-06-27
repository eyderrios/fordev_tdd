import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static const primaryColor = Color.fromRGBO(136, 14, 79, 1.0);
  static const primaryColorDark = Color.fromRGBO(96, 0, 39, 1.0);
  static const primaryColorLight = Color.fromRGBO(188, 71, 123, 1.0);
  static const backgroundColor = Colors.white;

  static const textTheme = TextTheme(
    headline1: TextStyle(
      fontSize: 30.0,
      fontWeight: FontWeight.bold,
      color: primaryColorDark,
    ),
  );

  static final buttonTheme = ButtonThemeData(
    colorScheme: const ColorScheme.light(primary: primaryColor),
    buttonColor: primaryColor,
    splashColor: primaryColorLight,
    padding: const EdgeInsets.symmetric(
      vertical: 10.0,
      horizontal: 20.0,
    ),
    textTheme: ButtonTextTheme.primary,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20.0),
    ),
  );

  static const inputTheme = InputDecorationTheme(
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: primaryColorLight),
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: primaryColor),
    ),
    alignLabelWithHint: true,
  );

  static ThemeData makeMaterialTheme() {
    return ThemeData(
      primaryColor: primaryColor,
      primaryColorDark: primaryColorDark,
      primaryColorLight: primaryColorLight,
      colorScheme: const ColorScheme.light(primary: primaryColor),
      backgroundColor: backgroundColor,
      textTheme: textTheme,
      inputDecorationTheme: inputTheme,
      buttonTheme: buttonTheme,
    );
  }

  static CupertinoThemeData makeCupertinoTheme() {
    return const CupertinoThemeData(
      primaryColor: primaryColor,
    );
  }
}
