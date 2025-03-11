import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_assessment/configs/routes/app_routes.dart';
import 'package:movie_app_assessment/core/presentation/widgets/network_image_widget.dart';
import 'package:movie_app_assessment/core/theme/app_colors.dart';
import 'package:movie_app_assessment/core/theme/app_typography.dart';
import 'package:movie_app_assessment/core/utils/app_ui_utils.dart';
import 'package:movie_app_assessment/core/utils/extensions/string_extension.dart';
import 'package:movie_app_assessment/features/movies/presentation/manager/movie_detail_cubit.dart';

import '../../../../core/presentation/widgets/app_button.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_utils.dart';
import '../../../../core/utils/enums/app_enums.dart';
import '../../../seat_booking/presentation/pages/seat_booking_screen.dart';
import '../manager/movie_detail_state.dart';

class MovieDetailsScreen extends StatefulWidget {
  const MovieDetailsScreen({super.key, required this.movieId});

  final int movieId;

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  final String videoKey = '';

  @override
  void initState() {
    super.initState();
    _loadMovieDetail();
    _loadMovieTrailer();
  }

  void _loadMovieDetail() {
    context.read<MovieDetailCubit>().getMovieDetail(widget.movieId);
  }

  void _loadMovieTrailer() {
    context.read<MovieDetailCubit>().getMovieTrailerKey(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: BlocConsumer<MovieDetailCubit, MovieDetailState>(
          listener: (context, state) {
            if (state.status == MovieDetailStatus.error && (state.errorMessage?.isNotEmpty ?? false)) {
              AppUIUtils.showTopSnackBar(context, message: state.errorMessage!, type: MessageType.error);
            }
          },
          builder: (context, state) {
            final movieDetail = state.movieDetail;
            final inTheaters = 'In Theaters ${movieDetail?.releaseDate.monthName} ${movieDetail?.releaseDate ?? ''}';
            if (state.status == MovieDetailStatus.loading) {
              return Center(child: CupertinoActivityIndicator());
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    SizedBox(
                      height: AppUtils.instance.getScreenHeight(context) * 0.60,
                      width: double.infinity,
                      child: CachedImageWidget(imageUrl: movieDetail?.posterPath ?? '', fit: BoxFit.cover),
                    ),
                    // Back Button
                    Positioned(
                      left: 0,
                      top: 0,
                      child: Container(
                        padding: EdgeInsets.fromLTRB(12, 59, 0, 75),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          gradient: LinearGradient(
                            colors: [
                              Color(0xFF000000), // Black (#000000)
                              Color(0x00000000), // Transparent (#00000000)
                            ],
                            begin: Alignment.topCenter, // Gradient starts from the top
                            end: Alignment.bottomCenter, // Gradient fades to the bottom
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            IconButton(
                              icon: Icon(Icons.arrow_back_ios_rounded, color: Colors.white),
                              onPressed: () => Navigator.pop(context),
                            ),
                            SizedBox(width: 8),
                            Text(
                              AppStrings.watch,
                              style: AppTypography.titleMedium.copyWith(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                        padding: const EdgeInsets.fromLTRB(20, 27, 20, 20),
                        height: 359,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color.fromRGBO(0, 0, 0, 0), // transparent
                              Color.fromRGBO(0, 0, 0, .8),
                            ],
                            // transform: GradientRotation(0.5 * 3.14),
                          ),
                        )),
                    Positioned(
                        bottom: 34,
                        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                          // Release Date
                          Hero(
                            tag: "theater",
                            child: Text(
                              inTheaters,
                              style: AppTypography.titleMedium.copyWith(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(height: 16),
                          // Action Buttons
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CustomButton(
                                text: AppStrings.getTicket,
                                padding: EdgeInsets.symmetric(horizontal: 81, vertical: 15),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return SeatBookingScreen(
                                          title: movieDetail?.title ?? '',
                                          description: inTheaters,
                                        );
                                      },
                                    ),
                                  );
                                },
                              ),
                              SizedBox(height: 10),
                              CustomButton(
                                  text: AppStrings.watchTrailer,
                                  textStyle: AppTypography.titleSmall.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                                  icon: Icon(
                                    Icons.play_arrow,
                                    color: Colors.white,
                                    size: 24,
                                  ),
                                  isOutlined: true,
                                  onPressed: () {
                                    if (state.videoKey.isNotEmpty) {
                                      context.pushMovieTrailer(state.videoKey);
                                    } else {
                                      _loadMovieTrailer();
                                    }
                                  }),
                            ],
                          ),
                        ]))
                  ],
                ),

                // generate movie details sections
                Padding(
                  padding: const EdgeInsets.fromLTRB(40, 27, 40, 0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Genres
                        Text(
                          AppStrings.genres,
                          style: AppTypography.titleMedium.copyWith(color: AppColors.textPrimary),
                        ),
                        SizedBox(height: 8),
                        SizedBox(
                          height: 40,
                          child: ListView.separated(
                            separatorBuilder: (_, __) => SizedBox(width: 5),
                            scrollDirection: Axis.horizontal,
                            itemCount: movieDetail?.genres.length ?? 0,
                            padding: EdgeInsets.zero,
                            itemBuilder: (context, index) {
                              final genre = movieDetail?.genres[index];
                              return _buildGenreChip(genre?.name ?? '', genreColors[index % genreColors.length]);
                            },
                          ),
                        ),
                        SizedBox(height: 22),
                        Divider(color: Colors.black.withValues(alpha: .05), height: 1),
                        SizedBox(height: 15),
                        // Overview
                        Text(
                          AppStrings.overView,
                          style: AppTypography.titleMedium.copyWith(color: AppColors.textPrimary),
                        ),
                        SizedBox(height: 8),
                        Text(movieDetail?.overview ?? '',
                            style: AppTypography.bodySmall.copyWith(
                              color: Color(0xFF8F8F8F),
                              height: 1.6,
                            )),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildGenreChip(String label, Color color) {
    return Material(
      color: Colors.transparent,
      child: Chip(
        label: Text(label),
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: color, width: 1),
          borderRadius: BorderRadius.circular(16), // Adjust radius as needed
        ),
        labelStyle: AppTypography.labelMedium.copyWith(
          fontWeight: FontWeight.w600,
        ),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      ),
    );
  }

  // Predefined colors
  final List<Color> genreColors = [
    Color(0xFF15D2BC),
    Color(0xFFE26CA5),
    Color(0xFF564CA3),
    Color(0xFFCD9D0F),
  ];
}
