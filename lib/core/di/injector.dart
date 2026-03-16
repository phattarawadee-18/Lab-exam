import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';

import '../../data/datasource/comic_api.dart';
import '../../data/repository/comic_repository_impl.dart';
import '../../domain/repository/comic_repository.dart';
import '../../domain/usecases/get_comics.dart';
import '../../domain/usecases/get_summary.dart';
import '../../presentation/bloc/comic_bloc.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {

  // Dio
  sl.registerLazySingleton(() => Dio());

  // API
  sl.registerLazySingleton(() => ComicApi(sl()));

  // Repository
  sl.registerLazySingleton<ComicRepository>(
    () => ComicRepositoryImpl(sl()),
  );

  // UseCases
  sl.registerLazySingleton(() => GetComics(sl()));
  sl.registerLazySingleton(() => GetSummary(sl()));

  // Bloc
  sl.registerFactory(
    () => ComicBloc(
      sl<GetComics>(), 
      sl<GetSummary>(), // ส่ง GetSummary เข้าไปแทน Object
    ),
  );
}