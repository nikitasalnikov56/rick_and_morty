import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:ricj_and_morti/core/theme/app_colors.dart';

class CharacterCardShimmer extends StatelessWidget {
  const CharacterCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.surface.withValues(alpha: 0.5),
      highlightColor: AppColors.surface.withValues(alpha: 0.2),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        height: 152, // Высота должна совпадать с реальной карточкой
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            // Заглушка для имиджа
            Container(
              width: 120,
              height: 120,
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            // Заглушки для текста
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(width: 140, height: 20, color: Colors.white),
                    const SizedBox(height: 12),
                    Container(width: 80, height: 14, color: Colors.white),
                    const SizedBox(height: 8),
                    Container(width: 100, height: 14, color: Colors.white),
                    const SizedBox(height: 16),
                    Container(width: 120, height: 12, color: Colors.white),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}