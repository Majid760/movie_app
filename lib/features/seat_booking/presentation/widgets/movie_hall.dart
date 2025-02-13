import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/utils/app_path.dart';

class MovieHall extends StatelessWidget {
  const MovieHall({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: "12:30",
            style: AppTypography.labelMedium.copyWith(
              color: AppColors.textPrimary,
            ),
            children: [
              TextSpan(
                text: "\t\tCinetech + Hall 1",
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.grey,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Image.asset(
          AppAssets.seatMap,
        ),
        SizedBox(
          height: 10,
        ),
        RichText(
          text: TextSpan(
            text: "From ",
            style: AppTypography.bodySmall.copyWith(
              color: AppColors.grey,
            ),
            children: [
              TextSpan(
                text: "50\$",
                style: AppTypography.labelMedium.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
              TextSpan(
                text: " or ",
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.grey,
                ),
              ),
              TextSpan(
                text: "2500 bonus",
                style: AppTypography.labelMedium.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
