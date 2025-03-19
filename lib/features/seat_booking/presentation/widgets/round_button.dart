import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class RoundButton extends StatelessWidget {
  const RoundButton({
    super.key,
    required this.icon,
    this.onPressed,
  });

  final IconData icon;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Container(
        padding: EdgeInsets.all(9),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            18.2,
          ),
          color: AppColors.white.withValues(
            alpha: 0.88,
          ),
          border: Border.all(
            width: 0.91,
            color: AppColors.border,
          ),
        ),
        child: Icon(
          icon,
          weight: 1.46,
          color: AppColors.textPrimary,
        ),
      ),
    );
  }
}
