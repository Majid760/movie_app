import 'package:flutter/material.dart';
import 'package:movie_app_assessment/core/presentation/widgets/network_image_widget.dart';
import 'package:movie_app_assessment/core/theme/app_typography.dart';

class CategoryCard extends StatelessWidget {
  final String title;
  final String imageUrl;
  final VoidCallback onTap;

  const CategoryCard({
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
        height: 100,
        width: double.infinity,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.black,
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Background Image
            CachedImageWidget(imageUrl: imageUrl, fit: BoxFit.cover),

            // Title
            Positioned(
              left: 10,
              bottom: 20,
              child: Text(
                title,
                style: AppTypography.titleMedium.copyWith(color: Colors.white),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
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
