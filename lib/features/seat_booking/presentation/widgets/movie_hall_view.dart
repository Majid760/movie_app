import 'package:flutter/material.dart';
import 'package:movie_app_assessment/core/theme/app_typography.dart';
import 'package:movie_app_assessment/core/utils/app_path.dart';

import '../../../../core/theme/app_colors.dart';
import '../../data/models/movie_model.dart';

class RoomItem extends StatelessWidget {
  final bool isActive;
  final CinemaHallRoom room;

  const RoomItem({super.key, required this.isActive, required this.room});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "12:30 ",
                  style: AppTypography.labelMedium.copyWith(color: AppColors.textPrimary, height: 1.6),
                ),
                TextSpan(
                  text: " Cinema",
                  style: AppTypography.labelMedium
                      .copyWith(fontWeight: FontWeight.w400, color: AppColors.grey, height: 1.6),
                ),
              ],
            ),
          ),
          SizedBox(height: 5),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 52, vertical: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: isActive
                  ? [
                      BoxShadow(
                        color: AppColors.black.withValues(alpha: 0.25),
                        offset: Offset(0, 1),
                        blurRadius: 4,
                        spreadRadius: 0,
                      ),
                    ]
                  : [],
              border: Border.all(color: isActive ? AppColors.skyBlue : AppColors.grey),
              borderRadius: BorderRadius.circular(10),
            ),
            child: AppSvgWidget.cinemaPreview,
          ),
          SizedBox(height: 10),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "From ",
                  style: AppTypography.labelMedium.copyWith(color: AppColors.grey, height: 1.6),
                ),
                TextSpan(
                  text: "${room.prices[0]}\$",
                  style: AppTypography.labelMedium
                      .copyWith(color: AppColors.textPrimary, height: 1.6, fontWeight: FontWeight.w700),
                ),
                TextSpan(
                  text: " or ",
                  style: AppTypography.labelMedium.copyWith(color: AppColors.grey, height: 1.6),
                ),
                TextSpan(
                  text: "${room.prices[1]} bonus",
                  style: AppTypography.labelMedium
                      .copyWith(color: AppColors.textPrimary, fontWeight: FontWeight.w700, height: 1.6),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
