import 'package:flutter/material.dart';
import 'app_colors.dart';


class AppTextStyles {
  static const TextStyle h1 = TextStyle(
    color: AppColors.textPrimary,
    fontSize: 34, 
    fontWeight: FontWeight.w800, 
    letterSpacing: 0.25,
  );

  static const TextStyle characterName = TextStyle(
    color: AppColors.textPrimary,
    fontSize: 20,
    fontWeight: FontWeight.w500,
  );
  

  static const TextStyle label = TextStyle(
    color: AppColors.textSecondary,
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );
}