import 'package:flutter/material.dart';

/// Single source of truth for the app's colors.
/// Change a value here and the whole app updates.
class AppColors {
  AppColors._(); // no instances — static access only
  static const Color ink = Color(0xFF1E1E2D); // dark text / icons
  static const Color surface = Color(0xFFF6F6F9); // page background
  static const Color card = Colors.white; // cards, search bar, buttons
  static const Color accent = Colors.redAccent; // badge, favorite heart
  static const Color star = Colors.amber; // rating star
  static const Color textGrey = Colors.grey; // secondary text
  static Color? textGreyLight = Colors.grey[500]; // subtitles
  static Color? textGreyDark = Colors.grey[700]; // chip labelsß
  static Color shadow = ink.withValues(alpha: 0.06); // soft card shadows
}
