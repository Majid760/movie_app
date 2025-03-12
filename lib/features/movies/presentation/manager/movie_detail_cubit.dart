import 'package:bloc/bloc.dart';
import 'package:movie_app_assessment/features/movies/domain/use_cases/fetch_movie_trailer_usecase.dart';

import '../../../../core/di/service_locator.dart';
import '../../data/models/movie_detail_model.dart';
import '../../domain/use_cases/fetch_movie_detail_usecase.dart';
import 'movie_detail_state.dart';

class MovieDetailCubit extends Cubit<MovieDetailState> {
  MovieDetailCubit() : super(const MovieDetailState());

  Future<void> getMovieDetail(int movieId) async {
    emit(state.copyWith(status: MovieDetailStatus.loading));
    try {
      final result = await sl<FetchMovieDetailUseCase>().call(movieId);
      result.fold(
        (failure) => emit(state.copyWith(status: MovieDetailStatus.error, errorMessage: failure.message)),
        (movieDetail) async {
          emit(state.copyWith(
            status: MovieDetailStatus.loaded,
            movieDetail: movieDetail as MovieDetailModel,
          ));
        },
      );
    } catch (e) {
      emit(state.copyWith(
        status: MovieDetailStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  // get movie trailer key

  Future<void> getMovieTrailerKey(int movieId) async {
    try {
      final result = await sl<FetchMovieTrailerUseCase>().call(movieId);
      result.fold(
        (failure) => emit(state.copyWith(status: MovieDetailStatus.error, errorMessage: failure.message)),
        (String videoKey) {
          emit(state.copyWith(status: MovieDetailStatus.loaded, videoKey: videoKey));
        },
      );
    } catch (e) {
      emit(state.copyWith(
        status: MovieDetailStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  void reset() {
    emit(const MovieDetailState());
  }

  void setMovieDetail(MovieDetailModel movieDetail) {
    emit(state.copyWith(movieDetail: movieDetail));
  }
}
