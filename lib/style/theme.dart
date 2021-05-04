import 'package:flutter/material.dart';

import 'colors.dart';

ThemeData getTheme() {
  return ThemeData(
    fontFamily: 'Cairo',
    // ignore: deprecated_member_use
    accentColor: AppColors.blue,
    inputDecorationTheme: InputDecorationTheme(
      focusColor: Colors.blue[800],
      // focusedBorder: OutlineInputBorder(
      //   borderRadius: BorderRadius.circular(30),
      //   borderSide: BorderSide(
      //     color: Colors.blue[800],
      //   ),
      // ),
      filled: true,
      fillColor: Colors.blue[800],
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: BorderSide(color: Colors.blue[800]),
      ),
      border: OutlineInputBorder(
        // borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide(color: Colors.blue[800]),
      ),
      errorBorder: OutlineInputBorder(
        // borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide(color: Colors.red),
      ),
    ),
  );
}
