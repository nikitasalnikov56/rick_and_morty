import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ricj_and_morti/core/theme/app_colors.dart';
import 'package:ricj_and_morti/core/theme/app_text_styles.dart';
import 'package:ricj_and_morti/features/characters/domain/entities/character.dart';
import 'package:ricj_and_morti/core/utils/hero_shape_clipper.dart'; // Твой клиппер

class CharacterDetailsPage extends StatelessWidget {
  final Character character;

  const CharacterDetailsPage({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(character.name, style: AppTextStyles.characterName),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            // ФИНАЛЬНАЯ ТОЧКА HERO
            Center(
              child: Hero(
                tag: 'character_image_${character.id}',
                child: ClipPath(
                  clipper: HeroShapeClipper(1.0), // Здесь всегда круг
                  child: CachedNetworkImage(
                    imageUrl: character.imageUrl,
                    width: 260,
                    height: 260,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            _buildInfoSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoSection() {
    return Container(
      padding: const EdgeInsets.all(24),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          _buildInfoRow('Status', character.status),
          const Divider(color: Colors.white10),
          _buildInfoRow('Species', character.species),
          const Divider(color: Colors.white10),
          _buildInfoRow('Gender', character.gender),
          const Divider(color: Colors.white10),
          _buildInfoRow('Location', character.location),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: AppTextStyles.label),
          Text(value, style: AppTextStyles.characterName.copyWith(fontSize: 16)),
        ],
      ),
    );
  }
}