import 'package:dartz/dartz.dart';
import 'package:movie_app_assessment/features/movies/domain/entities/movie_detail_entity.dart';
import 'package:movie_app_assessment/features/movies/domain/repositories/movie_repository.dart';
import 'package:movie_app_assessment/features/movies/domain/use_cases/user_case.dart';

import '../../../../core/errors/app_error.dart';

class FetchMovieDetailUseCase extends UseCase<MovieDetailEntity, int> {
  final MovieRepository repository;

  FetchMovieDetailUseCase({required this.repository});

  @override
  Future<Either<Failure, MovieDetailEntity>> call(int params) async {
    return await repository.getMovieById(params);
  }
}
