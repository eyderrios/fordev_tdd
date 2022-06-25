import 'package:flutter/material.dart';

import '../../utils/i18n/resources.dart';
import '../pages/login_page.dart';

class ForDevApp extends StatelessWidget {
  const ForDevApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color.fromRGBO(136, 14, 79, 1.0);
    const primaryColorDark = Color.fromRGBO(96, 0, 39, 1.0);
    const primaryColorLight = Color.fromRGBO(188, 71, 123, 1.0);
    const backgroundColor = Colors.white;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: R.strings.appName,
      theme: ThemeData(
        primaryColor: primaryColor,
        primaryColorDark: primaryColorDark,
        primaryColorLight: primaryColorLight,
        colorScheme: const ColorScheme.light(primary: primaryColor),
        backgroundColor: backgroundColor,
        textTheme: const TextTheme(
          headline1: TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            color: primaryColorDark,
          ),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: primaryColorLight),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: primaryColor),
          ),
          alignLabelWithHint: true,
        ),
        buttonTheme: ButtonThemeData(
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
        ),
      ),
      home: const LoginPage(),
    );
  }
}
