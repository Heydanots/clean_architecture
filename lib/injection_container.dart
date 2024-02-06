import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void init() {
  final dio = Dio(
    BaseOptions(
      headers: {
        'Authorization': '3db4395bafb44c88b4761f9a09d7be0c',
      },
      baseUrl: 'https://newsapi.org/v2',
      queryParameters: {
        'country': 'us',
        'category': 'business',
      },
    ),
  );

  getIt.registerLazySingleton<Dio>(() => dio);

  //Bloc
  //Use cases
  // ..registerLazySingleton(() => GetTopHeadLineUsecase(getIt()))
  //Repositories
  // ..registerLazySingleton<NewsRepository>(
  //     () => NewsRepositoryImpl(networkRemoteSource: getIt()))
  //Data source
  // ..registerLazySingleton(
  //     () => NewsNetworkRemoteDataSourceImpl(dio: getIt()));
}
