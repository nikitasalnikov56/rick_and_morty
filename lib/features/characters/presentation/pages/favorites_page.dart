import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ricj_and_morti/core/theme/app_colors.dart';
import 'package:ricj_and_morti/core/theme/app_text_styles.dart';
import 'package:ricj_and_morti/features/characters/presentation/bloc/character_bloc.dart';
import 'package:ricj_and_morti/features/characters/presentation/bloc/character_event.dart';
import 'package:ricj_and_morti/features/characters/presentation/widgets/character_card.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:ricj_and_morti/features/characters/domain/entities/character.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CharacterBloc, PagingState<int, Character>>(
      builder: (context, state) {
        final favoriteCharacters =
            state.pages
                ?.expand((page) => page)
                .where((character) => character.isFavorite)
                .toList() ??
            [];

        return CustomScrollView(
          slivers: [
            const SliverAppBar(
              backgroundColor: AppColors.background,
              floating: true,
              elevation: 0,
              title: Text('Favorites', style: AppTextStyles.h1),
              centerTitle: false,
            ),
            if (favoriteCharacters.isEmpty)
              SliverFillRemaining(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/no_characters.png'),
                    SizedBox(height: 35),
                    Text(
                      "You havenn't added any\nfavorites yet. Go explore!",
                      style: AppTextStyles.characterName.copyWith(
                        color: AppColors.textPrimary.withValues(alpha: 0.6)
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              )
            else
              SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final character = favoriteCharacters[index];
                  return Dismissible(
                    key: ValueKey('fav_${character.id}'),
                    direction: DismissDirection.endToStart,

                    background: Container(
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(right: 20),
                      margin: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 16,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.redAccent.withValues(alpha: 0.8),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Icon(
                        Icons.delete_sweep,
                        color: Colors.white,
                        size: 32,
                      ),
                    ),

                    onDismissed: (_) {
                      context.read<CharacterBloc>().add(
                        CharacterEvent.toggleFavorite(character.id),
                      );
                    },
                    child: CharacterCard(
                      character: character,
                      onFavoriteTap: null,
                    ),
                  );
                }, childCount: favoriteCharacters.length),
              ),
          ],
        );
      },
    );
  }
}
