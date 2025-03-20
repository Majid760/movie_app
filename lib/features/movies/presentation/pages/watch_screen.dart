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
import 'package:movie_app_assessment/features/movies/presentation/manager/movie_detail_cubit.dart';
import 'package:movie_app_assessment/features/movies/presentation/widgets/movie_card.dart';

import '../../../../core/theme/app_typography.dart';
import '../../../../core/utils/app_ui_utils.dart';
import '../../../../core/utils/enums/app_enums.dart';
import '../../data/models/movie_detail_model.dart';

class WatchScreen extends StatefulWidget {
  const WatchScreen({super.key});

  @override
  State<WatchScreen> createState() => _WatchScreenState();
}

class _WatchScreenState extends State<WatchScreen> {
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

class SmoothEntranceMovieCard extends StatefulWidget {
  final MovieModel movie;
  final int index;

  const SmoothEntranceMovieCard({
    super.key,
    required this.movie,
    required this.index,
  });

  @override
  State<SmoothEntranceMovieCard> createState() => _SmoothEntranceMovieCardState();
}

class _SmoothEntranceMovieCardState extends State<SmoothEntranceMovieCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _slideAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();

    // Slower animation duration
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    // Longer stagger delay
    Future.delayed(Duration(milliseconds: 150 * widget.index), () {
      if (mounted) {
        _controller.forward();
      }
    });

    // Smoother curves instead of bouncy ones
    _slideAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutQuad, // Smoother curve without bouncing
    );

    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween(begin: 1.05, end: 1.0).chain(CurveTween(curve: Curves.easeOutCubic)),
        weight: 100,
      ),
    ]).animate(_controller);

    _opacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.7, curve: Curves.easeOut),
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, 50 * (1 - _slideAnimation.value)),
          child: Transform.scale(
            scale: _scaleAnimation.value,
            alignment: Alignment.center,
            child: Opacity(
              opacity: _opacityAnimation.value,
              child: child,
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Hero(
          tag: widget.movie.id,
          child: MovieCard(
            title: widget.movie.title,
            imageUrl: widget.movie.posterPath,
            onTap: () {
              context.pushMovieDetail(widget.movie.id);
              context.read<MovieDetailCubit>().setMovieDetail(MovieDetailModel.fromMovieModel(widget.movie));
            },
          ),
        ),
      ),
    );
  }
}

// Separate AppBar Widget
class AnimatedWatchAppBar extends StatefulWidget implements PreferredSizeWidget {
  const AnimatedWatchAppBar({
    super.key,
  });

  @override
  State<AnimatedWatchAppBar> createState() => _AnimatedWatchAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _AnimatedWatchAppBarState extends State<AnimatedWatchAppBar> with SingleTickerProviderStateMixin {
  late AnimationController _appBarAnimationController;
  late Animation<Offset> _titleSlideAnimation;
  late Animation<Offset> _searchButtonSlideAnimation;

  @override
  void initState() {
    super.initState();

    // Create controller for AppBar animations
    _appBarAnimationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    // Create slide animation for title (right to left)
    _titleSlideAnimation = Tween<Offset>(
      begin: const Offset(1.0, 0.0), // Start from right
      end: Offset.zero, // End at original position
    ).animate(CurvedAnimation(
      parent: _appBarAnimationController,
      curve: Curves.easeOutCubic,
    ));

    // Create slide animation for search button (right to left)
    _searchButtonSlideAnimation = Tween<Offset>(
      begin: const Offset(2.0, 0.0), // Start further right
      end: Offset.zero, // End at original position
    ).animate(CurvedAnimation(
      parent: _appBarAnimationController,
      curve: Curves.easeOutCubic,
    ));

    // Start the animation when widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _appBarAnimationController.forward();
    });
  }

  @override
  void dispose() {
    _appBarAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leadingWidth: 100,
      backgroundColor: AppColors.white,
      leading: SlideTransition(
        position: _titleSlideAnimation,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
          child: Text(AppStrings.watch, style: AppTypography.titleMedium),
        ),
      ),
      elevation: 2,
      actions: [
        SlideTransition(
          position: _searchButtonSlideAnimation,
          child: Padding(
            padding: const EdgeInsets.only(right: 12),
            child: IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                context.pushSearch();
              },
            ),
          ),
        ),
      ],
    );
  }
}
