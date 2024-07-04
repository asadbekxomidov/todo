import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    primarySwatch: Colors.blue,
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.blue,
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );

  static ThemeData getTheme(BuildContext context) {
    if (Localizations.localeOf(context).languageCode == 'ru') {
      return ThemeData.dark();
    } else {
      return ThemeData.light();
    }
  }
}
