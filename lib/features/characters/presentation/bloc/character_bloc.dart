import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:ricj_and_morti/features/characters/data/repositories/character_repository_impl.dart';
import '../../domain/entities/character.dart';
import 'character_event.dart';

class CharacterBloc extends Bloc<CharacterEvent, PagingState<int, Character>> {
  final CharacterRepository repository;
  String _currentSearchName = '';
  String _currentStatus = '';
  String _currentGender = '';

  CharacterBloc(this.repository) : super(PagingState()) {
    on<FetchCharacters>(_onFetchCharacters);
    on<ToggleFavorite>(_onToggleFavorite);
    add(const CharacterEvent.fetchCharacters());
  }

  Future<void> _onFetchCharacters(
    FetchCharacters event,
    Emitter<PagingState<int, Character>> emit,
  ) async {
    if (state.isLoading && !event.isRefresh && event.name == null) return;
    final bool isSearchChanged =
        event.name != null && event.name != _currentSearchName;
    final bool isStatusChanged =
        event.status != null && event.status != _currentStatus;
    final bool isGenderChanged =
        event.gender != null && event.gender != _currentGender;
    final bool shouldReset =
        event.isRefresh ||
        isSearchChanged ||
        isStatusChanged ||
        isGenderChanged;

    if (shouldReset) {
      _currentSearchName =
          event.name ?? (event.isRefresh ? _currentSearchName : '');
      _currentStatus = event.status ?? (event.isRefresh ? _currentStatus : '');
      _currentGender = event.gender ?? (event.isRefresh ? _currentGender : '');

      emit(PagingState(isLoading: true, error: null));
    } else {
      emit(state.copyWith(isLoading: true, error: null));
    }

    try {
      final pageKey = shouldReset ? 1 : (state.keys?.last ?? 0) + 1;

      final List<Character> newItems = await repository.getCharacters(
        page: pageKey,
        name: _currentSearchName,
        status: _currentStatus,
        gender: _currentGender,
      );

      final isLastPage = newItems.length < 20;

      if (shouldReset) {
        emit(
          PagingState(
            pages: [newItems],
            keys: [pageKey],
            hasNextPage: !isLastPage,
            isLoading: false,
          ),
        );
      } else {
        emit(
          state.copyWith(
            pages: [...?state.pages, newItems],
            keys: [...?state.keys, pageKey],
            hasNextPage: !isLastPage,
            isLoading: false,
          ),
        );
      }
    } catch (e) {
      String message = "Произошла неизвестная ошибка";

      if (e.toString().contains('SocketException') ||
          e.toString().contains('Network')) {
        message = "Проблемы с интернетом. Проверьте подключение.";
      } else if (e.toString().contains('404')) {
        message = "Персонажи не найдены.";
      } else if (e.toString().contains('500')) {
        message = "Ошибка на сервере. Попробуйте позже.";
      }

      emit(state.copyWith(error: message, isLoading: false));
    }
  }

  void _onToggleFavorite(
    ToggleFavorite event,
    Emitter<PagingState<int, Character>> emit,
  ) {
    final box = Hive.box<Character>('characters_box');
    String? toastMessage;

    final updatedPages = state.pages?.map((page) {
      return page.map((character) {
        if (character.id == event.id) {
          final isBecomingFavorite = !character.isFavorite;
          final updatedChar = character.copyWith(
            isFavorite: isBecomingFavorite,
          );
          box.put(updatedChar.id, updatedChar);
          final action = isBecomingFavorite
              ? 'Добавлен в избранное'
              : 'Удален из избранного';
          toastMessage = '${character.name} $action';
          return updatedChar;
        }
        return character;
      }).toList();
    }).toList();

    emit(state.copyWith(pages: updatedPages));
    if (toastMessage != null && event.onComplete != null) {
      event.onComplete!(toastMessage!);
    }
  }
}
