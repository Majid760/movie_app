import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart' as top_snack_bar;

import '../theme/app_colors.dart';
import 'enums/app_enums.dart';

class AppUIUtils {
  // Private constructor for Singleton
  AppUIUtils._internal();

  // Singleton instance
  static final AppUIUtils instance = AppUIUtils._internal();

  // Show a dialog progress indicator
  void showDialogProgressIndicator(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => const Center(
        child: CircularProgressIndicator.adaptive(),
      ),
    );
  }

  // show simple progress indicator
  Widget showProgressIndicator(BuildContext context) => const Center(
        child: CircularProgressIndicator.adaptive(),
      );

  // Hide a progress indicator
  void hideProgressIndicator(BuildContext context) {
    Navigator.of(context).pop();
  }

  // Show a snackbar
  void showSnackBar(BuildContext context, String message, {Color? color}) {
    final SnackBar snackBar = SnackBar(
      content: Text(
        message,
        style: const TextStyle(color: AppColors.white),
      ),
      backgroundColor: color ?? Colors.black45,
      behavior: SnackBarBehavior.floating,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static void showTopSnackBar(
    BuildContext context, {
    required String message,
    MessageType type = MessageType.defaultType,
    Color backgroundColor = AppColors.skyBlue,
  }) {
    top_snack_bar.showTopSnackBar(
      Overlay.of(context),
      Material(
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 18,
          ),
          decoration: BoxDecoration(
            color: getColorFromType(type),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(child: Text(message, style: const TextStyle(color: Colors.white, fontSize: 16))),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      reverseAnimationDuration: const Duration(milliseconds: 800),
    );
  }

  // get the color from the type

  static Color getColorFromType(MessageType type) {
    switch (type) {
      case MessageType.error:
        return AppColors.error;
      case MessageType.info:
        return AppColors.skyBlue;
      case MessageType.success:
        return AppColors.skyBlue;
      case MessageType.warning:
        return AppColors.skyBlue;
      case MessageType.primary:
        return AppColors.skyBlue;
      case MessageType.defaultType:
        return AppColors.skyBlue;
    }
  }

  // get icons from the type

  static IconData getIconFromType(MessageType type) {
    switch (type) {
      case MessageType.error:
        return Icons.error;
      case MessageType.info:
        return Icons.info;
      case MessageType.success:
        return Icons.check_circle;
      case MessageType.warning:
        return Icons.warning;
      case MessageType.primary:
        return Icons.info;
      case MessageType.defaultType:
        return Icons.info;
    }
  }
}
