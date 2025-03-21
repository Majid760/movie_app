import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:movie_app_assessment/core/services/network_service.dart';
import 'package:movie_app_assessment/core/theme/app_colors.dart';
import 'package:movie_app_assessment/core/utils/app_strings.dart';
import 'package:movie_app_assessment/features/movies/data/models/movie_model.dart';
import 'package:movie_app_assessment/features/movies/presentation/manager/home_cubit.dart';
import 'package:movie_app_assessment/features/movies/presentation/manager/home_state.dart';

import '../../../../core/di/service_locator.dart';
import '../../../../core/presentation/widgets/custom_snackbar.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/utils/app_ui_utils.dart';
import '../../../../core/utils/enums/app_enums.dart';
import '../widgets/app_bar.dart';
import 'movie_item.dart';

class WatchScreen extends StatefulWidget {
  const WatchScreen({super.key});

  @override
  State<WatchScreen> createState() => _WatchScreenState();
}

class _WatchScreenState extends State<WatchScreen> {
  late StreamSubscription _connectivitySubscription;
  late NetworkService _networkService;
  bool _isConnected = true; // Default to true or check initially

  @override
  void initState() {
    //listen the connectivity
    _networkService = sl<NetworkService>();
    // Subscribe to connectivity changes
    _connectivitySubscription = _networkService.connectivityStream.listen((isConnected) {
      setState(() {
        _isConnected = isConnected;
      });
      if (!_isConnected) {
        AppSnackBar.show(context: context, message: 'Ops! internet is not connected!', type: SnackBarType.error);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HomeCubit>();
    return Scaffold(
      backgroundColor: AppColors.lightMist,
      appBar: const AnimatedWatchAppBar(),
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
              itemBuilder: (context, movie, index) {
                return SmoothEntranceMovieCard(
                  movie: movie,
                  index: index,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
