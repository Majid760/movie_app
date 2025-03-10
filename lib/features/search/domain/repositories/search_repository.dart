import 'package:dartz/dartz.dart';

import '../../../../core/errors/app_error.dart';
import '../../../movies/domain/entities/movies_entity.dart';

abstract class MovieSearchRepository {
  Future<Either<Failure, MoviesEntity>> searchMovies(Map<String, dynamic> data);
}
