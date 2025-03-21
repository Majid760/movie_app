import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_assessment/configs/routes/app_routes.dart';

import '../../data/models/movie_detail_model.dart';
import '../../data/models/movie_model.dart';
import '../manager/movie_detail_cubit.dart';
import '../widgets/movie_card.dart';

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
    // Only animate the first 5 items
    if (widget.index < 5) {
      Future.delayed(Duration(milliseconds: 150 * widget.index), () {
        if (mounted) {
          _controller.forward();
        }
      });
    } else {
      // For items beyond the first 5, start at the end state
      _controller.value = 1.0;
    }

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
