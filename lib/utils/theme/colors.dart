import 'package:flutter/material.dart';

/// Centralized app colors.
/// Use `AppColors.primary` etc. throughout the app.
class AppColors {
  AppColors._();

  // Brand
  static const Color primary = Color(0xFF3E8941);
  static const Color primaryVariant = Color(0xFF0060DF);
  static const Color secondary = Color(0xFFECF1E8);

  static const Color secondaryVariant = Color(0xFFCC7A00);
  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color transparent = Colors.transparent;

  // Rider-specific
  static const Color riderGreen = Color(0xFF6CC570);   // Active status
  static const Color urgentOrange = Color(0xFFFF9500); // Urgent orders

  // Order Status Colors
  static const Color statusPending = Color(0xFFFFD580);   // Yellow
  static const Color statusInProgress = Color(0xFF4A90D9); // Blue
  static const Color statusCompleted = Color(0xFF34C759);  // Green
  static const Color statusCancelled = Color(0xFFFF3B30);  // Red

  // Service Type Colors
  static const Color dryClean = Color(0xFFF6A6A6);     // Pink
  static const Color washOnly = Color(0xFFA8E6A1);     // Light Green
  static const Color iron = Color(0xFFFFD580);          // Yellow
  static const Color shoesBag = Color(0xFFD7CCC8);
  static const Color leatherCare = Color(0xFFBCAAA4);

  // Surfaces
  static const Color background = Color(0xFFF2F2F7);
  static const Color surface = Color(0xFFFFFFFF);

  // State
  static const Color error = Color(0xFFFF3B30);
  static const Color success = Color(0xFF34C759);
  static const Color warning = Color(0xFFFFCC00);

  // On-colors (text/icon on top of the corresponding color)
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color onSecondary = Color(0xFF000000);
  static const Color onBackground = Color(0xFF000000);
  static const Color onSurface = Color(0xFF000000);
  static const Color onError = Color(0xFFFFFFFF);

  // Grayscale palette
  static const Color gray900 = Color(0xFF1C1C1E);
  static const Color gray800 = Color(0xFF2C2C2E);
  static const Color gray700 = Color(0xFF3A3A3C);
  static const Color gray600 = Color(0xFF48484A);
  static const Color gray500 = Color(0xFF6E6E73);
  static const Color gray400 = Color(0xFF8E8E93);
  static const Color gray300 = Color(0xFFD1D1D6);
  static const Color gray200 = Color(0xFFE5E5EA);
  static const Color gray100 = Color(0xFFF2F2F7);
}
