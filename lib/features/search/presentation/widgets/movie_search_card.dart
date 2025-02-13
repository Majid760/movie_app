import 'package:flutter/material.dart';
import 'package:movie_app_assessment/core/presentation/widgets/network_image_widget.dart';
import 'package:movie_app_assessment/core/theme/app_typography.dart';

import '../../../../core/theme/app_colors.dart';

class SearchCard extends StatelessWidget {
  final String title;
  final String type;
  final String imageUrl;
  final VoidCallback onTap;

  const SearchCard({
    super.key,
    required this.title,
    required this.type,
    required this.imageUrl,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: 100,
        child: Row(
          children: [
            Container(
              height: 100,
              width: 130,
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
            const SizedBox(width: 21),

            // Title and Subtitle
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Text(
                      title,
                      overflow: TextOverflow.visible,
                      style: AppTypography.titleMedium.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    type,
                    style: AppTypography.labelMedium.copyWith(color: AppColors.gray),
                  ),
                ],
              ),
            ),

            // More Options Button
            IconButton(icon: Icon(Icons.more_horiz, color: AppColors.skyBlue, size: 32), onPressed: onTap),
          ],
        ),
      ),
    );
  }
}
