import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:movie_app_assessment/features/movies/data/models/movie_model.dart';
import 'package:movie_app_assessment/features/movies/domain/use_cases/fetch_search_movie_usecase.dart';
import 'package:movie_app_assessment/features/search/presentation/manager/search_movie_state.dart';

import '../../../../core/di/service_locator.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(const SearchState()) {
    onSearch();
    _pagingController.addPageRequestListener((pageKey) {
      _fetchMovies(pageKey);
    });
  }

  final _pagingController = PagingController<int, MovieModel>(
    firstPageKey: 1,
  );

  String query = "";

  PagingController<int, MovieModel> get pagingController => _pagingController;

  void onSearch({
    String query = "",
  }) {
    this.query = query.isNotEmpty ? query : "a";
    _pagingController.refresh();
  }

  Future<void> _fetchMovies(
    int page,
  ) async {
    if (query.isEmpty) return;
    final result = await sl<FetchSearchMoviesUseCase>().call({
      "query": query,
      "page": page,
    });
    result.fold(
      (failure) => _pagingController.error = failure.toString(),
      (movies) async {
        if (movies.page == movies.totalPages) {
          _pagingController.appendLastPage(
            List.from(movies.results),
          );
        } else {
          _pagingController.appendPage(
            List.from(movies.results),
            page + 1,
          );
        }
      },
    );
  }

  @override
  Future<void> close() {
    _pagingController.dispose();
    return super.close();
  }
}
