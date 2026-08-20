import 'package:flutter/material.dart';

/// Single source of truth for the app colors.
class AppColors {
  AppColors._();

  // ============================================================
  // PRIMARY
  // ============================================================

  static const Color ink = Color(0xFF1E1E2D);
  static const Color blackColor = Colors.black;
  static const Color redColor = Colors.red;

  // ============================================================
  // BACKGROUNDS
  // ============================================================

  static const Color surface = Color(0xFFF6F6F9);
  static const Color card = Colors.white;

  // ============================================================
  // ACCENTS
  // ============================================================

  static const Color accent = Colors.redAccent;
  static const Color star = Colors.amber;

  // ============================================================
  // TEXT
  // ============================================================

  static const Color textGrey = Colors.grey;

  static final Color textGreyLight = Colors.grey[500]!;
  static final Color textGreyDark = Colors.grey[700]!;

  // ============================================================
  // BORDERS / SHADOW
  // ============================================================

  static final Color border = Colors.grey[300]!;

  static final Color divider = Colors.grey[200]!;

  static final Color shadow = ink.withValues(
    alpha: 0.06,
  );
}