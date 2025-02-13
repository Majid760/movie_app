import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/utils/app_path.dart';

class SeatTypeWidget extends StatelessWidget {
  const SeatTypeWidget({
    super.key,
    required this.color,
    required this.label,
  });

  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AppSvgWidget.seatIcon.copyWith(
          color: ColorFilter.mode(
            color,
            BlendMode.srcIn,
          ),
        ),
        const SizedBox(
          width: 12,
        ),
        Text(
          label,
          style: AppTypography.labelMedium.copyWith(
            color: AppColors.grey,
          ),
        ),
      ],
    );
  }
}
