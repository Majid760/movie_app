import 'package:dartz/dartz.dart';
import 'package:movie_app_assessment/features/movies/domain/repositories/movie_repository.dart';
import 'package:movie_app_assessment/features/movies/domain/use_cases/user_case.dart';

import '../../../../core/errors/app_error.dart';
import '../entities/movies_entity.dart';

class FetchSearchMoviesUseCase extends UseCase<MoviesEntity, Map<String, dynamic>> {
  final MovieRepository repository;

  FetchSearchMoviesUseCase({required this.repository});

  @override
  Future<Either<Failure, MoviesEntity>> call(Map<String, dynamic> params) async {
    return await repository.searchMovies(params);
  }
}
