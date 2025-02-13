import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_app_assessment/features/movies/presentation/manager/home_cubit.dart';
import 'package:movie_app_assessment/features/movies/presentation/pages/category_screen.dart';
import 'package:movie_app_assessment/features/search/presentation/pages/search_screen.dart';
import 'package:movie_app_assessment/features/seat_booking/presentation/pages/seat_booking_screen.dart';
import 'package:movie_app_assessment/main.dart';

import '../../core/theme/app_colors.dart';
import '../../features/movies/presentation/pages/movie_detail_screen.dart';
import '../../features/movies/presentation/pages/watch_screen.dart';
import '../../features/movies/presentation/pages/watch_trailer.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/watch',
    debugLogDiagnostics: true,
    routes: [
      ShellRoute(
        builder: (context, state, child) {
          // return AppNavbar(child: child);
          return MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => HomeCubit(), lazy: false),
              // BlocProvider(create: (context) => HomeCubit(), lazy: false),
            ],
            child: HomeScreen(),
          );
          // return child;
        },
        routes: [
          GoRoute(
            path: AppRoutes.watchPath,
            name: AppRoutes.watch,
            pageBuilder: (context, state) => CustomTransitionPage(
              key: state.pageKey,
              child: const WatchScreen(),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                return FadeTransition(opacity: animation, child: child);
              },
            ),
          ),
        ],
      ),

      GoRoute(
          path: AppRoutes.movieDetailPath,
          name: AppRoutes.movieDetail,
          pageBuilder: (context, state) {
            final movieId = int.tryParse(state.pathParameters['id'] ?? '0') ?? 0;
            return CustomTransitionPage(
              key: state.pageKey,
              child: MovieDetailsScreen(movieId: movieId),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                return ScaleTransition(
                  scale: Tween<double>(begin: 0.8, end: 1.0).animate(
                    CurvedAnimation(parent: animation, curve: Curves.easeInOut),
                  ),
                  child: child,
                );
              },
            );
          }),

      GoRoute(
          path: AppRoutes.watchTrailerPath,
          name: AppRoutes.watchTrailer,
          pageBuilder: (context, state) {
            final videoKey = (state.pathParameters['id'] ?? '');
            return CustomTransitionPage(
              key: state.pageKey,
              child: VideoPlayerScreen(videoKey: videoKey),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                return ScaleTransition(
                  scale: Tween<double>(begin: 0.8, end: 1.0).animate(
                    CurvedAnimation(parent: animation, curve: Curves.easeInOut),
                  ),
                  child: child,
                );
              },
            );
          }),

      // Search Route with slide animation
      GoRoute(
          path: AppRoutes.searchPath,
          name: AppRoutes.search,
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              key: state.pageKey,
              child: SearchScreen(),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                return ScaleTransition(
                  scale: Tween<double>(begin: 0.8, end: 1.0).animate(
                    CurvedAnimation(parent: animation, curve: Curves.easeInOut),
                  ),
                  child: child,
                );
              },
            );
          }),

      GoRoute(
        path: AppRoutes.categoryPath,
        name: AppRoutes.category,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: CategoryScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        ),
      ),

      // Get Ticket Route
      GoRoute(
        path: AppRoutes.getTicketPath,
        name: AppRoutes.getTicket,
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            key: state.pageKey,
            child: SeatBookingScreen(
              title: state.pathParameters['movie'] ?? "",
              description: state.pathParameters['description'] ?? "",
            ),
            // child: GetTicketScreen(movieId: movieId),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return FadeTransition(opacity: animation, child: child);
            },
          );
        },
      ),
    ],
    errorBuilder: (context, state) => _errorPage(state.error),
  );

  static Widget _errorPage(Object? error) {
    return Scaffold(
      backgroundColor: AppColors.error,
      body: Center(
        child: Text(
          'Error: ${error.toString()}',
          style: const TextStyle(color: AppColors.black),
        ),
      ),
    );
  }
}

// Helper extension for easier navigation
extension RouterExtension on BuildContext {
  void pushSearch() => GoRouter.of(this).pushNamed('search');

  void pushCategoryScreen() => GoRouter.of(this).pushNamed('category');

  void pushMovieDetail(int movieId) =>
      GoRouter.of(this).pushNamed('movieDetail', pathParameters: {'id': movieId.toString()});

  void pushMovieTrailer(String videoKey) =>
      GoRouter.of(this).pushNamed('watchTrailer', pathParameters: {'id': videoKey});

  void pushGetTicket(
    String title,
    String description,
  ) =>
      GoRouter.of(this).pushNamed(
        'getTicket',
        queryParameters: {
          'movie': title,
          'description': description,
        },
      );
}

class AppRoutes {
  // names
  static const watch = 'watch';
  static const category = 'category';
  static const dashboard = 'dashboard';
  static const more = 'more';
  static const library = 'library';
  static const search = 'search';
  static const movieDetail = 'movieDetail';
  static const getTicket = 'getTicket';
  static const watchTrailer = 'watchTrailer';

  // path
  static const watchPath = '/watch';
  static const categoryPath = '/category';
  static const dashboardPath = '/dashboard';
  static const morePath = '/more';
  static const libraryPath = '/library';
  static const searchPath = '/search';
  static const movieDetailPath = '/movieDetail/:id';
  static const getTicketPath = '/ticket/:movie/:description';
  static const watchTrailerPath = '/watchTrailer/:id';
}
