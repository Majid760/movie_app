import 'package:flutter/material.dart';
import 'package:movie_app_assessment/core/theme/app_colors.dart';
import 'package:movie_app_assessment/core/theme/app_typography.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final TextStyle? textStyle;
  final Icon? icon;
  final VoidCallback onPressed;
  final bool isPrimary;
  final bool isFullWidth;
  final bool isOutlined;
  final EdgeInsets? padding;
  final double height;
  final double width;

  const CustomButton({
    super.key,
    required this.text,
    this.textStyle,
    this.icon,
    required this.onPressed,
    this.isPrimary = true,
    this.isFullWidth = true,
    this.isOutlined = false,
    this.padding,
    this.width = 243,
    this.height = 50,
  });

  @override
  Widget build(BuildContext context) {
    if (isOutlined) {
      return Container(
        height: height,
        width: width,
        child: OutlinedButton(
          onPressed: onPressed,
          style: OutlinedButton.styleFrom(
            side: BorderSide(
              color: isPrimary ? AppColors.skyBlue : Colors.transparent,
              width: 1,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[
                icon!,
                SizedBox(width: 4),
              ],
              Text(
                text,
                style: textStyle ??
                    AppTypography.titleSmall.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ],
          ),
        ),
      );
    }
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isPrimary ? AppColors.skyBlue : Colors.transparent,
          side: BorderSide(
            color: AppColors.skyBlue,
            width: 2,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              icon!,
              SizedBox(width: 4),
            ],
            Text(
              text,
              style: textStyle ??
                  AppTypography.titleSmall.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

class ResponsiveButtonGroup extends StatelessWidget {
  const ResponsiveButtonGroup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get screen orientation
    final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    final screenWidth = MediaQuery.of(context).size.width;
    final padding = screenWidth * 0.04;

    return Padding(
      padding: EdgeInsets.all(padding),
      child: isPortrait
          ? Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildGetTicketsButton(),
                SizedBox(height: padding),
                _buildWatchTrailerButton(),
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(child: _buildGetTicketsButton()),
                SizedBox(width: padding),
                Expanded(child: _buildWatchTrailerButton()),
              ],
            ),
    );
  }

  Widget _buildGetTicketsButton() {
    return CustomButton(
      text: 'Get Tickets',
      onPressed: () {},
      isPrimary: true,
    );
  }

  Widget _buildWatchTrailerButton() {
    return CustomButton(
      text: 'Watch Trailer',
      icon: Icon(Icons.play_arrow),
      onPressed: () {},
      isPrimary: false,
    );
  }
}

// Example usage in your movie details screen
class MovieDetailsButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Movie title and other content...

        ResponsiveButtonGroup(),

        // Rest of the content...
      ],
    );
  }
}
