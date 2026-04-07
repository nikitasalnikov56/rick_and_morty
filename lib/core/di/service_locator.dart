import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:ricj_and_morti/features/characters/data/datasources/character_remote_datasource.dart';
import 'package:ricj_and_morti/features/characters/data/repositories/character_repository_impl.dart';
import 'package:ricj_and_morti/features/characters/presentation/bloc/character_bloc.dart';


final getIt = GetIt.instance;

void setupLocator() {

  

  
 getIt.registerLazySingleton<Dio>(() => Dio(
    BaseOptions(
      baseUrl: 'https://rickandmortyapi.com/api',
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3),
    ),
  ));



  getIt.registerFactory<CharacterBloc>(
    () => CharacterBloc(getIt<CharacterRepository>())
  );

  getIt.registerLazySingleton(() => CharacterRemoteDataSource(getIt<Dio>()));
getIt.registerLazySingleton<CharacterRepository>(
  () => CharacterRepositoryImpl(getIt<CharacterRemoteDataSource>()),
);
}