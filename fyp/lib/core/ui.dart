import 'package:flutter/material.dart';

class AppColors {
  static Color accent = const Color(0xff1ab7c3);
  static Color primaryColor = const Color(0xff5A9F68);
  static Color secondaryColor = const Color(0xff5A9F68);
  static Color text = const Color(0xff212121);
  static Color textLight = const Color(0xFF8A8A8A);
  static Color white = const Color(0xffffffff);
  static Color bgColor = Colors.white;
  // static Color bgColor = const Color(0xffF5F5F5);
}

class Themes {
  static ThemeData defaultTheme = ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.bgColor,
      drawerTheme: DrawerThemeData(
        backgroundColor: Colors.grey.shade800,
      ),
      appBarTheme: AppBarTheme(
        elevation: 0,
        backgroundColor: AppColors.bgColor,
        iconTheme: IconThemeData(
          color: AppColors.text,
        ),
        titleTextStyle: TextStyle(
          color: AppColors.text,
          fontWeight: FontWeight.w500,
          fontSize: 18,
        ),
      ),
      colorScheme: ColorScheme.light(
        primary: AppColors.primaryColor,
        secondary: AppColors.secondaryColor,
      ));
}

class TextStyles {
  static TextStyle heading1 = TextStyle(
    fontWeight: FontWeight.bold,
    color: AppColors.text,
    fontSize: 48,
  );
  static TextStyle heading2 = TextStyle(
    fontWeight: FontWeight.bold,
    color: AppColors.text,
    fontSize: 32,
  );
  static TextStyle heading3 = TextStyle(
    fontWeight: FontWeight.bold,
    color: AppColors.text,
    fontSize: 24,
  );
  static TextStyle body1 = TextStyle(
    fontWeight: FontWeight.normal,
    color: AppColors.text,
    fontSize: 18,
  );
  static TextStyle body2 = TextStyle(
    fontWeight: FontWeight.normal,
    color: AppColors.text,
    fontSize: 16,
  );
}
