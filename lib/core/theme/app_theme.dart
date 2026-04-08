import 'package:flutter/material.dart';
import 'package:ricj_and_morti/core/theme/app_colors.dart';
import 'package:ricj_and_morti/core/theme/app_text_styles.dart';

class AppThemes {
  // ТЕМНАЯ ТЕМА (Твои основные цвета)
  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.background,
    cardColor: AppColors.surface,
    dividerColor: Colors.white10,
    
    // Настройка цветовой схемы
    colorScheme: const ColorScheme.dark(
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      surface: AppColors.surface,
      onSurface: AppColors.textPrimary,
      onSurfaceVariant: AppColors.textSecondary,
      error: AppColors.error,
    ),


    // Настройка AppBar
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      iconTheme: IconThemeData(color: AppColors.textPrimary),
    ),

    // Настройка BottomNav
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.surface,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.textSecondary,
    ),
    
    textTheme: const TextTheme(
    displayLarge: AppTextStyles.h1,
    titleMedium: AppTextStyles.characterName,
    bodySmall: AppTextStyles.label,
  ),
  );

  // СВЕТЛАЯ ТЕМА (Для примера, можно настроить под себя)
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: const Color(0xFFF1F5F9), // Светлый фон
    cardColor: Colors.white,
    dividerColor: Colors.black12,

    colorScheme: const ColorScheme.light(
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      surface: Colors.white,
      onSurface: Color(0xFF0F172A), // Темный текст для светлого фона
      onSurfaceVariant: Color(0xFF64748B),
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      iconTheme: IconThemeData(color: Color(0xFF0F172A)),
    ),

    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: Colors.grey,
    ),
    
    textTheme: TextTheme(
    displayLarge: AppTextStyles.h1.copyWith(color: const Color(0xFF0F172A)),
    titleMedium: AppTextStyles.characterName.copyWith(color: const Color(0xFF0F172A)),
    bodySmall: AppTextStyles.label.copyWith(color: const Color(0xFF64748B)),
  ),
  );
}