import 'package:flutter/material.dart';

// Color
Color kPeachColor = const Color(0xFFffab91);
Color kOrangeColor = const Color(0xFFffcc7f);
Color kBlueColor = const Color(0xFF81deea);
Color kGreenColor = const Color(0xFFe7ed9b);
Color kPurpleColor = const Color(0xFFcf94da);
Color kPinkColor = const Color(0xFFf48fb1);
Color kToscaColor = const Color(0xFF7fcbc3);
Color kBlackColor = const Color(0xFF000000);
Color kWhiteColor = const Color(0xFFFFFFFF);
Color kDarkGreyColor = const Color(0xFF252525);
Color kLightGreyColor = const Color(0xFF3B3B3B);

TextStyle h1TextStyle = const TextStyle(
  fontSize: 43,
  fontWeight: FontWeight.bold,
  fontFamily: 'Nunito',
);
TextStyle h2TextStyle = const TextStyle(
  fontSize: 35,
  fontWeight: FontWeight.w600,
  fontFamily: 'Nunito',
);
TextStyle h3TextStyle = const TextStyle(
  fontSize: 25,
  fontWeight: FontWeight.w600,
  fontFamily: 'Nunito',
);

TextStyle bodyTextStyle = const TextStyle(
  fontSize: 23,
  fontFamily: 'Nunito',
);

ThemeData dark = ThemeData(
  appBarTheme: AppBarTheme(
    color: kDarkGreyColor,
    elevation: 0,
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: kLightGreyColor,
    foregroundColor: kWhiteColor,
    iconSize: 40,
    sizeConstraints: const BoxConstraints(
      minHeight: 75,
      minWidth: 75,
    ),
  ),
  colorScheme: const ColorScheme.dark().copyWith(),
  scaffoldBackgroundColor: kDarkGreyColor,
);

ThemeData light = ThemeData(
  appBarTheme: AppBarTheme(
    foregroundColor: kBlackColor,
    color: kWhiteColor,
    elevation: 0,
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: kWhiteColor,
    foregroundColor: kDarkGreyColor,
    iconSize: 40,
    sizeConstraints: const BoxConstraints(
      minHeight: 75,
      minWidth: 75,
    ),
  ),
  colorScheme: const ColorScheme.light().copyWith(),
  scaffoldBackgroundColor: kWhiteColor,
);
