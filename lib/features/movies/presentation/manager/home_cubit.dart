import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_assessment/features/movies/data/models/movies_model.dart';
import 'package:movie_app_assessment/features/movies/domain/use_cases/fetch_upcoming_movies_usecase.dart';

import '../../../../core/di/service_locator.dart';
import '../../data/models/movie_model.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeState()) {
    fetchUpComingMovies();
  }

  Future<void> fetchUpComingMovies() async {
    try {
      emit(state.copyWith(status: HomeStates.loading));
      if (state.hasReachedMax) return;
      final result = await sl<FetchComingMoviesUseCase>().call(state.currentPage + 1);
      result.fold(
        (failure) => emit(state.copyWith(status: HomeStates.error, errorMessage: failure.toString())),
        (moviesModel) async {
          emit(state.copyWith(
              status: HomeStates.loaded,
              movies: moviesModel as MoviesModel,
              currentPage: moviesModel.page,
              hasReachedMax: moviesModel.page == moviesModel.totalPages,
              movieList: [...state.movieList, ...moviesModel.results as List<MovieModel>]));
        },
      );
    } catch (e) {
      debugPrint(e.toString());
      emit(state.copyWith(
        status: HomeStates.error,
        errorMessage: e.toString(),
      ));
    }
  }

  void resetState() {
    emit(const HomeState());
  }

  void updateData(MoviesModel newData) {
    emit(state.copyWith(
      status: HomeStates.loaded,
      movies: newData,
    ));
  }

  void handleError(String errorMessage) {
    emit(state.copyWith(
      status: HomeStates.error,
      errorMessage: errorMessage,
    ));
  }
}
