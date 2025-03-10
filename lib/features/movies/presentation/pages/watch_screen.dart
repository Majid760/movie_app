import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:movie_app_assessment/configs/routes/app_routes.dart';
import 'package:movie_app_assessment/core/theme/app_colors.dart';
import 'package:movie_app_assessment/core/utils/app_strings.dart';
import 'package:movie_app_assessment/features/movies/data/models/movie_model.dart';
import 'package:movie_app_assessment/features/movies/presentation/manager/home_cubit.dart';
import 'package:movie_app_assessment/features/movies/presentation/manager/home_state.dart';
import 'package:movie_app_assessment/features/movies/presentation/widgets/movie_card.dart';

import '../../../../core/theme/app_typography.dart';
import '../../../../core/utils/app_ui_utils.dart';
import '../../../../core/utils/enums/app_enums.dart';

class WatchScreen extends StatelessWidget {
  const WatchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HomeCubit>();

    return Scaffold(
      backgroundColor: AppColors.lightMist,
      appBar: AppBar(
        leadingWidth: 100,
        backgroundColor: AppColors.white,
        leading: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
          child: Text(AppStrings.watch, style: AppTypography.titleMedium),
        ),
        elevation: 2,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                context.pushSearch();
              },
            ),
          ),
        ],
      ),
      body: BlocListener<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state.status == HomeStates.error && (state.errorMessage?.isNotEmpty ?? false)) {
            AppUIUtils.showTopSnackBar(context, message: state.errorMessage!, type: MessageType.error);
          }
        },
        child: RefreshIndicator(
          onRefresh: () {
            return Future.sync(() => cubit.pagingController.refresh());
          },
          child: PagedListView<int, MovieModel>(
            pagingController: cubit.pagingController,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(20, 30, 20, 20),
            builderDelegate: PagedChildBuilderDelegate<MovieModel>(
              // firstPageProgressIndicatorBuilder: (_) => WatchScreenShimmer(),
              firstPageProgressIndicatorBuilder: (_) => Center(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: CupertinoActivityIndicator(),
                ),
              ),
              firstPageErrorIndicatorBuilder: (_) => Center(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: CupertinoActivityIndicator(),
                ),
              ),
              newPageErrorIndicatorBuilder: (_) => Center(
                child: Text(
                  AppStrings.errorLoadingMoreMovie,
                  style: AppTypography.titleLarge.copyWith(color: AppColors.error),
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
                  AppStrings.noMovieFound,
                  style: AppTypography.titleLarge.copyWith(color: AppColors.textPrimary),
                ),
              ),
              itemBuilder: (context, movie, index) => Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: MovieCard(
                  title: movie.title,
                  imageUrl: movie.posterPath,
                  onTap: () {
                    context.pushMovieDetail(movie.id);
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
