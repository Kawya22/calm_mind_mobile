import 'package:flutter/material.dart';

const _darkBlue = 0xFFE0B2B2;

const double mainCardRadius = 63;
const mainCardBgColor = 0xFFD9D9D9;
const lightPurple = 0xFFB5A2EC;

const backgroundGray = 0xBBBBBBBB;
const fontRed = 0xFFE74C3C;

const secondaryBorderRadius = 12.0;
const double pagePaddingTop = 20;

var themeData = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(seedColor: const Color(_darkBlue)).copyWith(
    background: const Color(_darkBlue),
  ),
  textTheme: const TextTheme(
    displayLarge: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    displayMedium: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      color: Colors.white,
    ),
  ),
);
