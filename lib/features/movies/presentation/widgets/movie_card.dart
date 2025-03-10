import 'package:flutter/material.dart';
import 'package:movie_app_assessment/core/presentation/widgets/network_image_widget.dart';
import 'package:movie_app_assessment/core/theme/app_typography.dart';

class MovieCard extends StatelessWidget {
  final String title;
  final String imageUrl;
  final VoidCallback onTap;

  const MovieCard({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 180,
        width: double.infinity,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.red,
        ),
        child: Stack(
          fit: StackFit.expand,
          alignment: Alignment.bottomCenter,
          children: [
            // Background Image
            CachedImageWidget(imageUrl: imageUrl, fit: BoxFit.cover),

            // Title
            Positioned(
              left: 0,
              bottom: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.fromLTRB(20, 27, 20, 20),
                height: 70,
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
                      Color.fromRGBO(0, 0, 0, 1),
                    ],
                    // transform: GradientRotation(0.5 * 3.14),
                  ),
                ),
                child: Text(
                  title,
                  style: AppTypography.titleLarge.copyWith(color: Colors.white),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),

            // Ripple Effect Overlay
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onTap,
                splashColor: Colors.white.withValues(alpha: 0.1),
                highlightColor: Colors.white.withValues(alpha: 0.1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
