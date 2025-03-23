import 'package:dio/dio.dart';

import '../../../../core/errors/app_error.dart';
import '../../../../core/network/network_client_service.dart';
import '../../../../core/network/network_config.dart';
import '../../domain/entities/movie_detail_entity.dart';
import '../../domain/entities/movie_entity.dart';
import '../../domain/entities/movies_entity.dart';
import '../models/movie_detail_model.dart';
import '../models/movie_model.dart';
import '../models/movies_model.dart';

abstract class AppRemoteDataSource {
  Future<MoviesEntity> getUpComingMovies(int page);
  Future<MovieDetailEntity> getMovieById(int id);

  Future<MovieDetailEntity> getMoviesCategory();

  Future<MovieEntity> searchCategory(String category, int page);

  Future<MoviesEntity> searchMovies(String query, int page);

  Future<String> getMovieTrailer(int id);
}

class AppRemoteDataSourceImp extends AppRemoteDataSource {
  final BaseClientService clientService;

  AppRemoteDataSourceImp({required this.clientService});

  @override
  Future<MoviesEntity> getUpComingMovies(int page) async {
    return await clientService.get(
      "${NetworkConfigs.upcomingMovies}?page=$page",
      onSuccess: (Response response) {
        return MoviesModel.fromJson(response.data);
      },
      onError: (ApiException error) {
        throw Exception('Failed to fetch upcoming movies: ${error.message}');
      },
      onLoading: () {
        // You can add loading logic here if needed
      },
    );
  }

  @override
  Future<MovieDetailEntity> getMovieById(int id) async {
    return await clientService.get(
      "${NetworkConfigs.movie}/$id",
      onSuccess: (Response response) {
        return MovieDetailModel.fromJson(response.data);
      },
      onError: (ApiException error) {
        throw Exception('Failed to fetch movie detail: ${error.message}');
      },
      onLoading: () {
        // You can add loading logic here if needed
      },
    );
  }

  @override
  Future<MovieDetailEntity> getMoviesCategory() async {
    return await clientService.get(
      NetworkConfigs.movieCategories,
      onSuccess: (Response response) {
        return MovieDetailModel.fromJson(response.data);
      },
      onError: (ApiException error) {
        throw Exception('Failed to fetch movies category: ${error.message}');
      },
      onLoading: () {
        // You can add loading logic here if needed
      },
    );
  }

  @override
  Future<MovieEntity> searchCategory(String category, int page) async {
    return await clientService.get(
      "${NetworkConfigs.searchCategories}$category&page=$page",
      onSuccess: (Response response) {
        return MovieModel.fromJson(response.data);
      },
      onError: (ApiException error) {
        throw Exception('Failed to search category: ${error.message}');
      },
      onLoading: () {
        // You can add loading logic here if needed
      },
    );
  }

  @override
  Future<MoviesEntity> searchMovies(String query, int page) async {
    return await clientService.get(
      "${NetworkConfigs.searchMovies}$query&page=$page",
      onSuccess: (response) {
        return MoviesModel.fromJson(response.data);
      },
      onError: (error) {
        throw Exception('Failed to search movies: ${error.message}');
      },
      onLoading: () {
        // You can add loading logic here if needed
      },
    );
  }

  @override
  Future<String> getMovieTrailer(int id) async {
    return await clientService.get(
      "${NetworkConfigs.getMovieTrailer}/$id/videos",
      onSuccess: (Response response) {
        return response.data['results'][0]['key'];
      },
      onError: (ApiException error) {
        throw Exception('Failed to get movie trailer: ${error.message}');
      },
      onLoading: () {
        // You can add loading logic here if needed
      },
    );
  }
}
