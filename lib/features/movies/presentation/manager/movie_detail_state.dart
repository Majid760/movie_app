import 'package:equatable/equatable.dart';

import '../../data/models/movie_detail_model.dart';

enum MovieDetailStatus { initial, loading, loaded, error }

class MovieDetailState extends Equatable {
  final MovieDetailStatus status;
  final MovieDetailModel? movieDetail;
  final String? errorMessage;
  final String videoKey;

  const MovieDetailState({
    this.status = MovieDetailStatus.initial,
    this.movieDetail,
    this.errorMessage,
    this.videoKey = '',
  });

  MovieDetailState copyWith({
    MovieDetailStatus? status,
    MovieDetailModel? movieDetail,
    String? errorMessage,
    String? videoKey,
  }) {
    return MovieDetailState(
      status: status ?? this.status,
      movieDetail: movieDetail ?? this.movieDetail,
      errorMessage: errorMessage ?? this.errorMessage,
      videoKey: videoKey ?? this.videoKey,
    );
  }

  @override
  List<Object?> get props => [status, movieDetail, errorMessage, videoKey];
}
