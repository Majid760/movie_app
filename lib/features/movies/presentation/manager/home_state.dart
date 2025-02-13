import 'package:equatable/equatable.dart';
import 'package:movie_app_assessment/features/movies/data/models/movies_model.dart';

import '../../data/models/movie_model.dart';

enum HomeStates { initial, loading, loaded, error }

class HomeState extends Equatable {
  final HomeStates status;
  final String? errorMessage;
  final MoviesModel? movies;
  final List<MovieModel> movieList;
  final int currentPage;
  final bool hasReachedMax;
  final bool isLoadingMore;

  const HomeState({
    this.status = HomeStates.initial,
    this.errorMessage,
    this.movieList = const [],
    this.movies,
    this.currentPage = 0,
    this.hasReachedMax = false,
    this.isLoadingMore = false,
  });

  HomeState copyWith({
    HomeStates? status,
    String? errorMessage,
    MoviesModel? movies,
    List<MovieModel>? movieList,
    int? currentPage,
    bool? hasReachedMax,
    bool? isLoadingMore,
  }) {
    return HomeState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      movies: movies ?? this.movies,
      movieList: movieList ?? this.movieList,
      currentPage: currentPage ?? this.currentPage,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }

  @override
  List<Object?> get props => [
        status,
        errorMessage,
        movies,
        movieList,
        currentPage,
        hasReachedMax,
        isLoadingMore,
      ];
}
