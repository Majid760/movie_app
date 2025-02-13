import 'package:dartz/dartz.dart';
import 'package:movie_app_assessment/features/movies/domain/repositories/movie_repository.dart';
import 'package:movie_app_assessment/features/movies/domain/use_cases/user_case.dart';

import '../../../../core/errors/app_error.dart';
import '../entities/movies_entity.dart';

class FetchComingMoviesUseCase extends UseCase<MoviesEntity, int> {
  final MovieRepository repository;

  FetchComingMoviesUseCase({required this.repository});

  @override
  Future<Either<Failure, MoviesEntity>> call(int params) async {
    return await repository.getUpComingMovies(params);
  }
}
