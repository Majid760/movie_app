import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:movie_app_assessment/features/movies/data/data_sources/local_source.dart';

import '../../features/movies/data/data_sources/remote_source.dart';
import '../../features/movies/data/repositories/movie_repository_imp.dart';
import '../../features/movies/domain/use_cases/fetch_movie_detail_usecase.dart';
import '../../features/movies/domain/use_cases/fetch_movie_trailer_usecase.dart';
import '../../features/movies/domain/use_cases/fetch_upcoming_movies_usecase.dart';
import '../../features/search/domain/use_cases/fetch_search_movie_usecase.dart';
import '../network/network_client.dart';
import '../network/network_client_service.dart';
import '../services/network_service.dart';

final GetIt sl = GetIt.instance;

class ServicesLocator {
  ServicesLocator._internal();

  static final _shared = ServicesLocator._internal();

  static ServicesLocator get shared => _shared;
  Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    // FlutterNativeSplash.preserve(widgetsBinding: bindings);

    try {
      // base-client (dio)
      sl.registerLazySingleton<BaseClientService>(
        () => BaseClientService(dio: NetworkClient().createDioClient()),
      );

      // connectivity service
      sl.registerLazySingleton<NetworkService>(() => NetworkService(Connectivity()));

      // ✅ Register AppLocalDataSourceImp
      // Register Local Data Source (Ensure Hive is initialized)
      final localDataSource = AppLocalDataSourceImpl();
      await localDataSource.init();
      sl.registerLazySingleton<AppLocalDataSource>(() => localDataSource);

      await sl.allReady();

      // ✅ Register AppRemoteDataSourceImp
      sl.registerLazySingleton<AppRemoteDataSourceImp>(
        () => AppRemoteDataSourceImp(clientService: sl<BaseClientService>()),
      );

      // ✅ Register MovieRepositoryImp
      sl.registerLazySingleton<MovieRepositoryImp>(
        () => MovieRepositoryImp(
            remoteDataSource: sl<AppRemoteDataSourceImp>(), localDataSource: sl<AppLocalDataSource>()),
      );

      // ✅ Register Use Cases
      sl.registerLazySingleton<FetchComingMoviesUseCase>(
        () => FetchComingMoviesUseCase(repository: sl<MovieRepositoryImp>()),
      );
      sl.registerLazySingleton<FetchMovieDetailUseCase>(
        () => FetchMovieDetailUseCase(repository: sl<MovieRepositoryImp>()),
      );
      sl.registerLazySingleton<FetchMovieTrailerUseCase>(
        () => FetchMovieTrailerUseCase(repository: sl<MovieRepositoryImp>()),
      );

      sl.registerLazySingleton<FetchSearchMoviesUseCase>(
        () => FetchSearchMoviesUseCase(repository: sl<MovieRepositoryImp>()),
      );
    } catch (e, st) {
      debugPrint('error in injecting dependencies: $e #$st');
    }
    // await FCMService.shared.init();

    // sl<WeatherCubit>().fetchWeatherData();

    // FlavorConfig.shared.set(
    //   flavor: flavor,
    //   values: FlavorValues(
    //     name: flavor.name,
    //   ),
    // );
  }
}
