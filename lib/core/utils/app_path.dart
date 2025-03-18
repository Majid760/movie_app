import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../theme/app_colors.dart';

class AppAssets {
  // common assets paths
  static const String iconPath = "assets/icons";
  static const String svgIconPath = "$iconPath/svg";

  static const String imagePath = "assets/images";

  // Images
  static const String logo = "$imagePath/logo.png";
  static const String moviePlaceholder = "$imagePath/movie_placeholder.png";
  static const String seatMap = "$imagePath/seat_map.png";
  static const String seatMapWide = "$imagePath/seat_map_wide.png";

  // svg icons
  static const String searchIcon = "$svgIconPath/search_icon.svg";
  static const String crossIcon = "$svgIconPath/cross_icon.svg";
  static const String dashboardIcon = "$svgIconPath/dashboard_icon.svg";
  static const String watchIcon = "$svgIconPath/watch_icon.svg";
  static const String mediaLabIcon = "$svgIconPath/media_lab_icon.svg";
  static const String moreIcon = "$svgIconPath/more_icon.svg";
  static const String seat = "$svgIconPath/seat.svg";

  // Icons
  static const String seatIcon = "assets/icons/seat_icon.png";

  // Animations (Lottie)
  static const String loadingAnimation = "assets/animations/loading.json";

  // svg
  static const String backIcon = "assets/icons/back_icon.svg";
  static const String cinemaPreview = "assets/svgs/cinema_preview.svg";
  static const String screenPreview = "assets/svgs/screen_shape.svg";
  static const String close = "assets/svgs/close.svg";
  static const String find = "assets/svgs/find.svg";
  static const String seatBooked = "assets/svgs/seat_booked.svg";
  static const String seatDisabled = "assets/svgs/seat_disabled.svg";
  static const String seatSelect = "assets/svgs/seat_select.svg";
  static const String seatUnselected = "assets/svgs/seat_unselected.svg";

  // Fonts
  static const String poppins = "Poppins";
}

class AppSvgWidget {
  AppSvgWidget._();

  static SvgWidget searchIcon = const SvgWidget(
    assetPath: AppAssets.searchIcon,
    width: 18,
    height: 18,
  );
  static SvgWidget crossIcon = const SvgWidget(
    assetPath: AppAssets.crossIcon,
    color: ColorFilter.mode(AppColors.textPrimary, BlendMode.srcIn),
    width: 16,
    height: 16,
  );
  static SvgWidget dashboardIcon = const SvgWidget(
    assetPath: AppAssets.dashboardIcon,
    width: 18,
    height: 18,
  );
  static SvgWidget watchIcon = const SvgWidget(
    assetPath: AppAssets.watchIcon,
    color: ColorFilter.mode(AppColors.ashLavender, BlendMode.srcIn),
    width: 18,
    height: 18,
  );
  static SvgWidget mediaLabIcon = const SvgWidget(
    assetPath: AppAssets.mediaLabIcon,
    width: 18,
    height: 18,
  );
  static SvgWidget moreIcon = const SvgWidget(
    assetPath: AppAssets.moreIcon,
    color: ColorFilter.mode(AppColors.ashLavender, BlendMode.srcIn),
    width: 18,
    height: 18,
  );
  static SvgWidget seatIcon = const SvgWidget(
    assetPath: AppAssets.seat,
  );

  // booking seat_view
  static SvgWidget cinemaPreview = const SvgWidget(
    assetPath: AppAssets.cinemaPreview,
    // color: ColorFilter.mode(AppColors.ashLavender, BlendMode.srcIn),
    height: 113,
    width: 144,
  );
  static SvgWidget screenShape = const SvgWidget(
    assetPath: AppAssets.screenPreview,
    // color: ColorFilter.mode(AppColors.ashLavender, BlendMode.srcIn),
    height: 36, width: 327,
  );
}

class SvgWidget extends StatelessWidget {
  final String assetPath;
  final double? width;
  final double? height;
  final ColorFilter? color;
  final BoxFit fit;

  const SvgWidget({
    super.key,
    required this.assetPath,
    this.width,
    this.height,
    this.color,
    this.fit = BoxFit.contain,
  });

  // Add copyWith method
  SvgWidget copyWith({
    String? assetPath,
    double? width,
    double? height,
    ColorFilter? color,
  }) {
    return SvgWidget(
      assetPath: assetPath ?? this.assetPath,
      width: width ?? this.width,
      height: height ?? this.height,
      color: color ?? this.color,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      assetPath,
      width: width,
      height: height,
      colorFilter: color,
      fit: fit,
    );
  }
}
