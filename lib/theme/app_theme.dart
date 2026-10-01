import 'package:flutter/material.dart';

class AppColors {
  static const deepForest = Color(0xFF161A17);
  static const charcoalOlive = Color(0xFF2C3531);
  static const softBone = Color(0xFFF9F8F6);
  static const warmOat = Color(0xFFE3DAC9);

  static const sage = Color(0xFF7C9082);
  static const teal = Color(0xFF48B1BF);
  static const orange = Color(0xFFD66853);
  static const terracotta = Color(0xFFB56357);

  static const surface = Color(0xFFF1ECE2);
  static const border = Color(0xFFD5CBB8);
  static const textSecondary = Color(0xFF5B6660);
  static const textOnDarkSecondary = Color(0xFFB9C0BB);
  static const ochre = Color(0xFFC9A66B);
}

class AppTextStyles {
  static const title = TextStyle(
    fontFamily: 'WorkSans',
    fontSize: 24,
    fontWeight: FontWeight.w600,
    height: 1.25,
    color: AppColors.deepForest,
  );

  static const subtitle = TextStyle(
    fontFamily: 'WorkSans',
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 1.3,
    color: AppColors.deepForest,
  );

  static const body = TextStyle(
    fontFamily: 'WorkSans',
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.45,
    color: AppColors.deepForest,
  );

  static const label = TextStyle(
    fontFamily: 'WorkSans',
    fontSize: 12,
    fontWeight: FontWeight.w500,
    height: 1.3,
    letterSpacing: 0.2,
    color: AppColors.textSecondary,
  );

  static const metric = TextStyle(
    fontFamily: 'WorkSans',
    fontSize: 40,
    fontWeight: FontWeight.w600,
    height: 1.1,
    color: AppColors.deepForest,
    fontFeatures: [FontFeature.tabularFigures()],
  );

  // Dark screen variants
  static const titleDark = TextStyle(
    fontFamily: 'WorkSans',
    fontSize: 24,
    fontWeight: FontWeight.w600,
    height: 1.25,
    color: AppColors.softBone,
  );

  static const subtitleDark = TextStyle(
    fontFamily: 'WorkSans',
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 1.3,
    color: AppColors.softBone,
  );

  static const bodyDark = TextStyle(
    fontFamily: 'WorkSans',
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.45,
    color: AppColors.softBone,
  );

  static const labelDark = TextStyle(
    fontFamily: 'WorkSans',
    fontSize: 12,
    fontWeight: FontWeight.w500,
    height: 1.3,
    letterSpacing: 0.2,
    color: AppColors.textOnDarkSecondary,
  );

  static const metricDark = TextStyle(
    fontFamily: 'WorkSans',
    fontSize: 40,
    fontWeight: FontWeight.w600,
    height: 1.1,
    color: AppColors.softBone,
    fontFeatures: [FontFeature.tabularFigures()],
  );
}

class AppTheme {
  static const double radiusSmall = 4;
  static const double radiusMedium = 6;
  static const double radiusLarge = 8;

  static ThemeData light() {
    return ThemeData(
      useMaterial3: true,
      fontFamily: 'WorkSans',
      scaffoldBackgroundColor: AppColors.softBone,
      colorScheme: const ColorScheme.light(
        primary: AppColors.teal,
        onPrimary: AppColors.deepForest,
        surface: AppColors.softBone,
        onSurface: AppColors.deepForest,
        error: AppColors.terracotta,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.softBone,
        foregroundColor: AppColors.deepForest,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
      ),
      cardTheme: CardThemeData(
        color: AppColors.surface,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusLarge),
          side: const BorderSide(color: AppColors.border),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.teal,
          foregroundColor: AppColors.deepForest,
          elevation: 0,
          minimumSize: const Size.fromHeight(48),
          textStyle: const TextStyle(
            fontFamily: 'WorkSans',
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusMedium),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.deepForest,
          side: const BorderSide(color: AppColors.deepForest, width: 1),
          minimumSize: const Size.fromHeight(48),
          textStyle: const TextStyle(
            fontFamily: 'WorkSans',
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusMedium),
          ),
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.warmOat,
        thickness: 1,
        space: 1,
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: AppColors.softBone,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        indicatorColor: AppColors.warmOat,
        indicatorShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusMedium),
        ),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const TextStyle(
              fontFamily: 'WorkSans',
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.deepForest,
            );
          }
          return const TextStyle(
            fontFamily: 'WorkSans',
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: AppColors.textSecondary,
          );
        }),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const IconThemeData(color: AppColors.deepForest, size: 22);
          }
          return const IconThemeData(color: AppColors.textSecondary, size: 22);
        }),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusMedium),
          borderSide: const BorderSide(color: AppColors.border, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusMedium),
          borderSide: const BorderSide(color: AppColors.border, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusMedium),
          borderSide: const BorderSide(color: AppColors.deepForest, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusMedium),
          borderSide: const BorderSide(color: AppColors.terracotta, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusMedium),
          borderSide: const BorderSide(color: AppColors.terracotta, width: 1.5),
        ),
        labelStyle: AppTextStyles.label,
        errorStyle: const TextStyle(
          fontFamily: 'WorkSans',
          fontSize: 12,
          color: AppColors.terracotta,
        ),
      ),
    );
  }
}
