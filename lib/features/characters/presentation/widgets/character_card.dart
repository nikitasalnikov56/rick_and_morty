import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ricj_and_morti/core/theme/app_colors.dart';
import 'package:ricj_and_morti/core/theme/app_text_styles.dart';
import 'package:ricj_and_morti/core/utils/hero_shape_clipper.dart';
import 'package:ricj_and_morti/features/characters/domain/entities/character.dart';

class CharacterCard extends StatelessWidget {
  final Character character;
  final VoidCallback? onFavoriteTap;

  const CharacterCard({super.key, required this.character, this.onFavoriteTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _CharacterImage(
                imageUrl: character.imageUrl,
                characterId: character.id,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        character.name,
                        style: AppTextStyles.characterName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Text('Status\t', style: AppTextStyles.label),
                          _StatusIndicator(status: character.status),
                          const SizedBox(width: 6),
                          Text(character.status, style: AppTextStyles.label),
                        ],
                      ),
                      Row(
                        children: [
                          Text('Species:\t', style: AppTextStyles.label),
                          Expanded(
                            child: Text(
                              ' ${character.species}',
                              style: AppTextStyles.label,
                              softWrap: true,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text('Last Known Location', style: AppTextStyles.label),
                      const SizedBox(height: 4),
                      Text(
                        character.location,
                        style: AppTextStyles.label.copyWith(
                          color:Theme.of(context).textTheme.titleMedium?.color,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          IconButton(
            padding: const EdgeInsets.only(top: 8, right: 8),
            icon: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: character.isFavorite
                    ? AppColors.primary.withValues(alpha: 0.1)
                    : Colors.transparent,
                shape: BoxShape.circle,
              ),
              child: AnimatedScale(
                scale: character.isFavorite ? 1.2 : 1.0,
                duration: const Duration(milliseconds: 300),
                curve: Curves.elasticInOut,
                child: Icon(
                  character.isFavorite ? Icons.star : Icons.star_border,
                  size: 28,
                  color: character.isFavorite
                      ? AppColors.primary
                      : AppColors.textSecondary,
                ),
              ),
            ),
            color: character.isFavorite
                ? AppColors.primary
                : AppColors.textSecondary,
            onPressed: onFavoriteTap,
          ),
        ],
      ),
    );
  }
}

// Индикатор статуса (точка)
class _StatusIndicator extends StatelessWidget {
  final String status;
  const _StatusIndicator({required this.status});

  @override
  Widget build(BuildContext context) {
    Color color;
    switch (status.toLowerCase()) {
      case 'alive':
        color = Colors.green;
        break;
      case 'dead':
        color = Colors.red;
        break;
      default:
        color = Colors.grey;
    }
    return Container(
      width: 8,
      height: 8,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}

class _CharacterImage extends StatelessWidget {
  final String imageUrl;
  final int characterId;
  const _CharacterImage({required this.imageUrl, required this.characterId});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF5B6777), width: 2),
      ),
      child: Padding(
        padding: const EdgeInsets.all(2),
        child: Hero(
          tag: 'character_image_$characterId',
          // flightShuttleBuilder управляет видом виджета В ПОЛЕТЕ
          flightShuttleBuilder:
              (context, animation, direction, fromContext, toContext) {
                return AnimatedBuilder(
                  animation: animation,
                  builder: (context, child) {
                    return ClipPath(
                      clipper: HeroShapeClipper(animation.value),
                      child: toContext.widget,
                    );
                  },
                );
              },
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              width: 120,
              height: 120,
              fit: BoxFit.cover,
              placeholder: (context, url) =>
                  const Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => Image.asset(
                'assets/images/no_image.jpg',
                width: 120,
                height: 120,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
