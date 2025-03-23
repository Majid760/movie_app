import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:movie_app_assessment/features/movies/domain/use_cases/fetch_upcoming_movies_usecase.dart';

import '../../../../core/di/service_locator.dart';
import '../../../../core/services/network_service.dart';
import '../../data/data_sources/local_source.dart';
import '../../data/models/movie_model.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeState()) {
    _pagingController.addPageRequestListener((page) => fetchUpComingMovies(page));
  }

  // page controller
  final PagingController<int, MovieModel> _pagingController = PagingController(firstPageKey: 1);
  PagingController<int, MovieModel> get pagingController => _pagingController;

  Future<void> fetchUpComingMovies(int page) async {
    try {
      emit(state.copyWith(status: HomeStates.loading));
      // checking internet
      final hasInternet = sl<NetworkService>().isConnect;
      if (hasInternet) {
        if (state.hasReachedMax) return;
        final result = await sl<FetchComingMoviesUseCase>().call(page);
        result.fold(
          // (failure) => emit(state.copyWith(status: HomeStates.error, errorMessage: failure.toString())),
          (failure) => _pagingController.error = failure.toString(),
          (moviesModel) async {
            if (moviesModel.page == moviesModel.totalPages) {
              _pagingController.appendLastPage(moviesModel.results as List<MovieModel>);
            } else {
              _pagingController.appendPage(moviesModel.results as List<MovieModel>, page + 1);
            }
            // store to local db
            final bool isCacheValid = await sl<AppLocalDataSource>().isCacheValid();
            if (!isCacheValid && page == 1) {
              sl<AppLocalDataSource>().cacheMovies(moviesModel.results as List<MovieModel>);
            }
          },
        );
      } else {
        if (page == 1) {
          final List<MovieModel> movies = await sl<AppLocalDataSource>().getCachedMovies();
          _pagingController.appendPage(movies, page + 1);
        }
      }
    } catch (e) {
      emit(state.copyWith(
        status: HomeStates.error,
        errorMessage: e.toString(),
      ));
    }
  }

  void resetState() {
    emit(const HomeState());
  }

  @override
  Future<void> close() {
    _pagingController.dispose();
    return super.close();
  }
}
