import 'package:flutter/material.dart';

class AppColors {
  // Dark Modern UI Backgrounds
  static const Color background = Color(0xFF020617); // Darker slate
  static const Color surface = Color(0xFF0F172A);
  static const Color surfaceLight = Color(0xFF1E293B);

  // Accents (Premium aesthetic)
  static const Color primary = Color(0xFF38BDF8); // Bright sky blue
  static const Color secondary = Color(0xFF6366F1); // Indigo
  static const Color accent = Color(0xFFF472B6); // Pink

  // Text Colors
  static const Color textPrimary = Color(0xFFF8FAFC);
  static const Color textSecondary = Color(0xFF94A3B8);
  static const Color textMuted = Color(0xFF64748B);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, secondary],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient surfaceGradient = LinearGradient(
    colors: [Color(0xFF1E293B), Color(0xFF0F172A)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Glassmorphism
  static const Color glassBackground = Color(0x0DFFFFFF); // 5% white
  static const Color glassBorder = Color(0x1AFFFFFF); // 10% white
}
