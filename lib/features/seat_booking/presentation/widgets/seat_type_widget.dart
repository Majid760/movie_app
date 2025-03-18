import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/utils/app_path.dart';

class SeatTypeWidget extends StatelessWidget {
  const SeatTypeWidget({
    super.key,
    required this.label,
    this.assetPath,
  });
  final String label;

  final String? assetPath;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AppSvgWidget.seatIcon.copyWith(
          assetPath: assetPath ?? AppAssets.seat,
          height: 17.76,
          width: 20.01,
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
