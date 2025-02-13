// lib/domain/repositories/movie_repository.dart
import 'package:dartz/dartz.dart';
import 'package:movie_app_assessment/features/movies/domain/entities/movie_detail_entity.dart';

import '../../../../core/errors/app_error.dart';
import '../entities/movies_entity.dart';

abstract class MovieRepository {
  Future<Either<Failure, MoviesEntity>> getUpComingMovies(int page);
  Future<Either<Failure, MovieDetailEntity>> getMovieById(int id);
  Future<Either<Failure, String>> getMovieTrailerById(int id);
  Future<Either<Failure, MoviesEntity>> searchMovies(Map<String, dynamic> data);
}
