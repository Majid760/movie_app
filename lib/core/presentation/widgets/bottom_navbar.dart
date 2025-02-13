import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../theme/app_colors.dart';

class AppNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int>? onTap;
  final List<BottomNavigationBarItem> navbarItems;

  const AppNavBar({
    required this.currentIndex,
    required this.navbarItems,
    super.key,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        decoration: BoxDecoration(
          color: AppColors.deepTwilight,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(27),
            topRight: Radius.circular(27),
          ),
        ),
        clipBehavior: Clip.antiAlias,
        child: Theme(
          data: Theme.of(context).copyWith(
            splashColor: Colors.transparent,
          ),
          child: BottomNavigationBar(
            elevation: 0,
            type: BottomNavigationBarType.fixed,
            onTap: onTap,
            backgroundColor: Colors.transparent,
            showUnselectedLabels: true,
            showSelectedLabels: true,
            selectedItemColor: AppColors.white,
            unselectedItemColor: AppColors.ashLavender,
            unselectedLabelStyle: GoogleFonts.roboto(
              fontSize: 10,
              fontWeight: FontWeight.w700,
            ),
            selectedLabelStyle: GoogleFonts.roboto(
              fontSize: 10,
              fontWeight: FontWeight.w700,
            ),
            items: navbarItems,
            currentIndex: currentIndex,
          ),
        ),
      ),
    );
  }
}

class AppNavBarItem extends BottomNavigationBarItem {
  /// Icon when the item is inactive.
  final Widget navbarIcon;

  /// Icon when the item is active.
  final Widget? active;

  /// Background color for the item.
  final Color? backgroundColor;

  /// Label for the item.
  final String label;

  /// Tooltip for accessibility.
  @override
  final String? tooltip;

  /// Constructor
  AppNavBarItem({
    required this.navbarIcon,
    this.backgroundColor,
    required this.label,
    this.tooltip,
    this.active,
  }) : super(
          icon: Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: navbarIcon,
          ),
          activeIcon: Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: active ?? navbarIcon,
          ),
          backgroundColor: backgroundColor,
          label: label,
          tooltip: tooltip,
        );
}
