import 'package:dartz/dartz.dart';
import 'package:movie_app_assessment/features/movies/domain/repositories/movie_repository.dart';
import 'package:movie_app_assessment/features/movies/domain/use_cases/user_case.dart';

import '../../../../core/errors/app_error.dart';

class FetchMovieTrailerUseCase extends UseCase<String, int> {
  final MovieRepository repository;

  FetchMovieTrailerUseCase({required this.repository});

  @override
  Future<Either<Failure, String>> call(int params) async {
    return await repository.getMovieTrailerById(params);
  }
}
