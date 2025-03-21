// Separate AppBar Widget
import 'package:flutter/material.dart';
import 'package:movie_app_assessment/configs/routes/app_routes.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/utils/app_strings.dart';

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
