import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:movie_app_assessment/configs/routes/app_routes.dart';
import 'package:movie_app_assessment/core/utils/app_utils.dart';
import 'package:movie_app_assessment/features/search/presentation/manager/search_movie_cubit.dart';
import 'package:movie_app_assessment/features/search/presentation/manager/search_movie_state.dart';
import 'package:movie_app_assessment/features/search/presentation/widgets/movie_search_card.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../movies/data/models/movie_model.dart';
import '../../../movies/presentation/widgets/search_field.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mist,
      body: BlocBuilder<SearchCubit, SearchState>(
        builder: (context, state) {
          final cubit = context.read<SearchCubit>();
          return RefreshIndicator(
            onRefresh: () async => cubit.onSearch(),
            child: CustomScrollView(
              slivers: [
                PinnedHeaderSliver(
                  child: Container(
                    padding: EdgeInsets.fromLTRB(
                      20,
                      MediaQuery.of(context).padding.top + 8,
                      20,
                      25,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                        bottom: BorderSide(
                          width: 1,
                          color: Color(0xFFEFEFEF),
                        ),
                      ),
                    ),
                    child: SearchField(
                      onChanged: (value) {
                        AppUtils.instance.debounce(
                          milliseconds: 1200,
                          () => cubit.onSearch(
                            query: value,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  sliver: SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          AppStrings.topResults,
                          style: AppTypography.labelMedium.copyWith(
                            color: AppColors.textPrimary,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Divider(
                          height: 0,
                          thickness: 1,
                          color: Color(0xFFEFEFEF),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.all(20),
                  sliver: PagedSliverList<int, MovieModel>(
                    pagingController: cubit.pagingController,
                    builderDelegate: PagedChildBuilderDelegate<MovieModel>(
                      // firstPageProgressIndicatorBuilder: (_) => WatchScreenShimmer(),
                      firstPageProgressIndicatorBuilder: (_) => Center(
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: CupertinoActivityIndicator(),
                        ),
                      ),
                      newPageProgressIndicatorBuilder: (_) => const Center(
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: CupertinoActivityIndicator(),
                        ),
                      ),
                      noItemsFoundIndicatorBuilder: (_) => Center(
                        child: Text(
                          'No movies found',
                          style: AppTypography.bodyLarge,
                        ),
                      ),
                      firstPageErrorIndicatorBuilder: (_) => Center(
                        child: Text(
                          'Error loading movies',
                          style: AppTypography.bodyLarge,
                        ),
                      ),
                      newPageErrorIndicatorBuilder: (_) => Center(
                        child: Text(
                          'Error loading more movies',
                          style: AppTypography.bodyLarge,
                        ),
                      ),
                      itemBuilder: (context, movie, index) => Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: SearchCard(
                          title: movie.title,
                          type: getRandomType(index % 10),
                          imageUrl: movie.posterPath,
                          onTap: () {
                            context.pushMovieDetail(movie.id);
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  String getRandomType(int index) {
    return [
      'Fantasy',
      'Action',
      'Adventure',
      'comedy',
      'Drama',
      'Horror',
      'Mystery',
      'Romance',
      'Sci-fi',
      'Thriller'
    ][index];
  }
}
