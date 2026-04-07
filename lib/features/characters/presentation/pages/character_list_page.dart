import 'dart:async';

import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ricj_and_morti/core/di/service_locator.dart';
import 'package:ricj_and_morti/core/theme/app_colors.dart';
import 'package:ricj_and_morti/core/theme/app_text_styles.dart';
import 'package:ricj_and_morti/features/characters/domain/entities/character.dart';
import 'package:ricj_and_morti/features/characters/domain/entities/character_enums.dart';
import 'package:ricj_and_morti/features/characters/presentation/bloc/character_bloc.dart';
import 'package:ricj_and_morti/features/characters/presentation/bloc/character_event.dart';
import 'package:ricj_and_morti/features/characters/presentation/pages/favorites_page.dart';
import 'package:ricj_and_morti/features/characters/presentation/widgets/character_card.dart';

class CharacterListPage extends StatefulWidget {
  const CharacterListPage({super.key});

  @override
  State<CharacterListPage> createState() => _CharacterListPageState();
}

class _CharacterListPageState extends State<CharacterListPage> {
  final CharacterBloc _bloc = getIt<CharacterBloc>();
  late final PagingController<int, Character> _pagingController;
  int _selectedIndex = 0;

  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;

  bool _showFilters = false;
  CharacterStatus _selectedStatus = CharacterStatus.all;
  CharacterGender _selectedGender = CharacterGender.all;

  @override
  void initState() {
    super.initState();
    _pagingController = PagingController(
      getNextPageKey: (state) =>
          state.lastPageIsEmpty ? null : (state.keys?.last ?? 0) + 1,
      fetchPage: (pageKey) async {
        _bloc.add(const CharacterEvent.fetchCharacters());
        await _bloc.stream.firstWhere((state) => !state.isLoading);
        return _bloc.state.pages?.last ?? [];
      },
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    _debounce?.cancel();
    _pagingController.dispose();
    _bloc.close();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      _bloc.add(CharacterEvent.fetchCharacters(name: query));
    });
  }

  void _toggleSearch() {
    setState(() {
      _isSearching = !_isSearching;
      if (!_isSearching) {
        _searchController.clear();
        _bloc.add(const CharacterEvent.fetchCharacters(name: ''));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _bloc,
      child: Scaffold(
        backgroundColor: AppColors.background,

        body: IndexedStack(
          index: _selectedIndex,
          children: [_buildCharacterList(), const FavoritesPage()],
        ),
        bottomNavigationBar: _CustomBottomNavBar(
          selectedIndex: _selectedIndex,
          onTap: (index) => setState(() => _selectedIndex = index),
        ),
      ),
    );
  }

  BlocBuilder<CharacterBloc, PagingState<int, Character>>
  _buildCharacterList() {
    return BlocBuilder<CharacterBloc, PagingState<int, Character>>(
      builder: (context, state) {
        final currentPagingState = PagingState<int, Character>(
          pages: state.pages,
          keys: state.keys,
          hasNextPage: state.hasNextPage,
          isLoading: state.isLoading,
          error: state.error,
        );
        return CustomScrollView(
          slivers: [
            // 1. Верхняя панель с кнопками (над заголовком)
            SliverAppBar(
              backgroundColor: AppColors.background,
              floating: true,
              elevation: 0,
              actions: [
                _ActionButton(
                  icon: _isSearching ? Icons.close : Icons.search,
                  onTap: _toggleSearch,
                ),
                if (!_isSearching)
                  _ActionButton(
                    icon: Icons.filter_list,
                    onTap: () {
                      setState(() {
                        _showFilters = !_showFilters;
                        print(_showFilters);
                      });
                    },
                  ),
                const SizedBox(width: 16),
              ],
            ),
            // 2. Заголовок Characters (ниже кнопок)
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(left: 16, bottom: 16, top: 8),
                child: _isSearching
                    ? _buildSearchField()
                    : Text('Characters', style: AppTextStyles.h1),
              ),
            ),

        
              SliverToBoxAdapter(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),

                  height: _showFilters ? 110 : 0,
                  child: _showFilters
                      ? SingleChildScrollView(
                        physics: NeverScrollableScrollPhysics(),
                        child: Column(
                            children: [
                              // Строка статусов
                              _buildFilterRow(
                                items: CharacterStatus.values,
                                selectedItem: _selectedStatus,
                                onSelected: (val) {
                                  setState(() => _selectedStatus = val);
                                  _bloc.add(
                                    CharacterEvent.fetchCharacters(
                                      status: val.value,
                                    ),
                                  );
                                },
                              ),
                              // Строка гендера
                              _buildFilterRow(
                                items: CharacterGender.values,
                                selectedItem: _selectedGender,
                                onSelected: (val) {
                                  setState(() => _selectedGender = val);
                                  _bloc.add(
                                    CharacterEvent.fetchCharacters(
                                      gender: val.value,
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                      )
                      : const SizedBox.shrink(),
                ),
              ),

            // 3. Список персонажей
            PagedSliverList<int, Character>(
              key: ValueKey(
                state.pages
                        ?.expand((p) => p)
                        .where((c) => c.isFavorite)
                        .length ??
                    0,
              ),
              state: currentPagingState,
              fetchNextPage: () =>
                  _bloc.add(const CharacterEvent.fetchCharacters()),
              builderDelegate: PagedChildBuilderDelegate<Character>(
                itemBuilder: (context, item, index) => CharacterCard(
                  character: item,
                  onFavoriteTap: () {
                    if (!item.isFavorite) {
                      _bloc.add(CharacterEvent.toggleFavorite(item.id));
                    }
                  },
                ),
                firstPageErrorIndicatorBuilder: (_) => _ErrorWidget(
                  message: state.error.toString(),
                  onRetry: () =>
                      _bloc.add(const CharacterEvent.fetchCharacters()),
                ),
                newPageErrorIndicatorBuilder: (_) => _NewPageErrorWidget(
                  onRetry: () =>
                      _bloc.add(const CharacterEvent.fetchCharacters()),
                ),
                noItemsFoundIndicatorBuilder: (_) => const Center(
                  child: Text(
                    "No characters found",
                    style: AppTextStyles.characterName,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildSearchField() {
    return TextField(
      controller: _searchController,
      autofocus: true,
      onChanged: _onSearchChanged,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: 'Search characters...',
        hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.5)),
        prefixIcon: const Icon(Icons.search, color: AppColors.primary),
        filled: true,
        fillColor: AppColors.surface,
        contentPadding: const EdgeInsets.symmetric(vertical: 0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }


  Widget _buildFilterRow<T extends Enum>({
    required List<T> items,
    required T selectedItem,
    required Function(T) onSelected,
  }) {
    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          final isSelected = item == selectedItem;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ChoiceChip(
              label: Text(item.name.toUpperCase()),
              selected: isSelected,
              onSelected: (_) => onSelected(item),
              selectedColor: AppColors.primary,
              backgroundColor: AppColors.surface,
            ),
          );
        },
      ),
    );
  }
}

// Кнопки в AppBar
class _ActionButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _ActionButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 12),
      decoration: BoxDecoration(
        color: AppColors.surface.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: IconButton(
        icon: Icon(icon, color: AppColors.textPrimary, size: 24),
        onPressed: onTap,
      ),
    );
  }
}

class _CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTap;

  const _CustomBottomNavBar({required this.selectedIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: onTap,
        backgroundColor: AppColors.surface,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textSecondary,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Characters',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            activeIcon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}

class _ErrorWidget extends StatelessWidget {
  final VoidCallback onRetry;
  final String? message;
  const _ErrorWidget({required this.onRetry, this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(message ?? "Something went wrong", style: AppTextStyles.label),
          const SizedBox(height: 12),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
            onPressed: onRetry,
            child: const Text("Retry", style: TextStyle(color: Colors.black)),
          ),
        ],
      ),
    );
  }
}

class _NewPageErrorWidget extends StatelessWidget {
  final VoidCallback onRetry;
  const _NewPageErrorWidget({required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onRetry,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            const Text(
              "Ошибка загрузки. Нажмите, чтобы повторить",
              style: TextStyle(color: Colors.white70),
            ),
            const SizedBox(height: 8),
            const Icon(Icons.refresh, color: AppColors.primary),
          ],
        ),
      ),
    );
  }
}
