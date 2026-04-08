import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:ricj_and_morti/core/theme/app_theme.dart';
import 'package:ricj_and_morti/features/characters/domain/entities/character.dart';
import 'package:ricj_and_morti/features/characters/presentation/bloc/theme/theme_cubit.dart';
import 'package:ricj_and_morti/features/characters/presentation/pages/character_list_page.dart';
import 'core/di/service_locator.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(0)) {
    Hive.registerAdapter(CharacterAdapter());
  }

  await Hive.openBox<Character>('characters_box');

  setupLocator();

  runApp(
    BlocProvider(
      create: (context) => getIt<ThemeCubit>(),
      child: const RickAndMortyApp(),
    ),
  );
}

class RickAndMortyApp extends StatelessWidget {
  const RickAndMortyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, currentThemeMode) {
        return MaterialApp(
          title: 'Rick and Morty',
          debugShowCheckedModeBanner: false,
          themeMode: currentThemeMode,
          theme: AppThemes.lightTheme,
          darkTheme: AppThemes.darkTheme,
          
          home: const CharacterListPage(),
        );
      },
    );
  }
}
