import 'package:flutter/material.dart';

import 'app_typography.dart';

class AppTextStyles {
  // TextTheme for Light Mode
  static TextTheme lightTextTheme = TextTheme(
    displayLarge: AppTypography.displayLarge,
    displayMedium: AppTypography.displayMedium,
    displaySmall: AppTypography.displaySmall,
    headlineLarge: AppTypography.headlineLarge,
    headlineMedium: AppTypography.headlineMedium,
    headlineSmall: AppTypography.headlineSmall,
    titleLarge: AppTypography.titleLarge,
    titleMedium: AppTypography.titleMedium,
    titleSmall: AppTypography.titleSmall,
    bodyLarge: AppTypography.bodyLarge,
    bodyMedium: AppTypography.bodyMedium,
    bodySmall: AppTypography.bodySmall,
    labelLarge: AppTypography.labelLarge,
    labelMedium: AppTypography.labelMedium,
    labelSmall: AppTypography.labelSmall,
  );

  // TextTheme for Dark Mode
  static TextTheme darkTextTheme = TextTheme(
    displayLarge: AppTypography.displayLarge.copyWith(color: Colors.white),
    displayMedium: AppTypography.displayMedium.copyWith(color: Colors.white),
    displaySmall: AppTypography.displaySmall.copyWith(color: Colors.white),
    headlineLarge: AppTypography.headlineLarge.copyWith(color: Colors.white),
    headlineMedium: AppTypography.headlineMedium.copyWith(color: Colors.white),
    headlineSmall: AppTypography.headlineSmall.copyWith(color: Colors.white),
    titleLarge: AppTypography.titleLarge.copyWith(color: Colors.white),
    titleMedium: AppTypography.titleMedium.copyWith(color: Colors.white),
    titleSmall: AppTypography.titleSmall.copyWith(color: Colors.white),
    bodyLarge: AppTypography.bodyLarge.copyWith(color: Colors.white),
    bodyMedium: AppTypography.bodyMedium.copyWith(color: Colors.white),
    bodySmall: AppTypography.bodySmall.copyWith(color: Colors.white70),
    labelLarge: AppTypography.labelLarge.copyWith(color: Colors.white),
    labelMedium: AppTypography.labelMedium.copyWith(color: Colors.white),
    labelSmall: AppTypography.labelSmall.copyWith(color: Colors.white70),
  );
}
