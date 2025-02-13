import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:movie_app_assessment/core/errors/app_error.dart';

import '../../domain/entities/movie_detail_entity.dart';
import '../../domain/entities/movies_entity.dart';
import '../../domain/repositories/movie_repository.dart';
import '../data_sources/remote_source.dart';

class MovieRepositoryImp implements MovieRepository {
  final AppDataSource dataSource;
  MovieRepositoryImp({required this.dataSource});

  @override
  Future<Either<Failure, MovieDetailEntity>> getMovieById(int id) async {
    try {
      final movie = await dataSource.getMovieById(id);
      return Right(movie);
    } catch (e) {
      debugPrint('error while fetching movie by id=> $e');
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, MoviesEntity>> getUpComingMovies(int page) async {
    try {
      final movie = await dataSource.getUpComingMovies(page);
      return Right(movie);
    } catch (e) {
      debugPrint('error while fetching upcoming movies=> $e');
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> getMovieTrailerById(int id) async {
    try {
      final movie = await dataSource.getMovieTrailer(id);
      return Right(movie);
    } catch (e) {
      debugPrint('error while fetching trailer id=> $e');
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, MoviesEntity>> searchMovies(Map<String, dynamic> data) async {
    try {
      final movie = await dataSource.searchMovies(data['query'], data['page']);
      return Right(movie);
    } catch (e) {
      debugPrint('error while searching movie => $e');
      return Left(ServerFailure(e.toString()));
    }
  }
}
