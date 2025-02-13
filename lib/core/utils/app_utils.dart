import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppUtils {
  // Private constructor for Singleton pattern
  AppUtils._privateConstructor();

  // The single instance of this class
  static final AppUtils _instance = AppUtils._privateConstructor();

  // Accessor to the instance
  static AppUtils get instance => _instance;

  Timer? _debounceTimer;

  static void unFocus() => WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();

  // static Future<bool> isConnected() async {
  //   final List<ConnectivityResult> result = await sl<Connectivity>().checkConnectivity();
  //   if (result.contains(ConnectivityResult.mobile) || result.contains(ConnectivityResult.wifi)) {
  //     return true;
  //   }
  //   return false;
  // }

  /// Check if the current platform is iOS
  bool isIOS() => Platform.isIOS;

  /// Check if the current platform is Android
  bool isAndroid() => Platform.isAndroid;

  /// Check if the device is a mobile (iOS/Android)
  bool isMobile() => Platform.isIOS || Platform.isAndroid;

  /// Check if the device is running on a web platform
  bool isWeb() => !Platform.isIOS && !Platform.isAndroid && kIsWeb;

  /// Get the screen width
  double getScreenWidth(BuildContext context) => MediaQuery.of(context).size.width;

  /// Get the screen height
  double getScreenHeight(BuildContext context) => MediaQuery.of(context).size.height;

  /// Check if the device is in portrait mode
  bool isPortrait(BuildContext context) => MediaQuery.of(context).orientation == Orientation.portrait;

  /// Check if the device is in landscape mode
  bool isLandscape(BuildContext context) => MediaQuery.of(context).orientation == Orientation.landscape;

  /// Show a toast message (works for both iOS and Android)
  void showToast(BuildContext context, String message) {
    final SnackBar snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  /// Get the current system locale
  Locale getSystemLocale(BuildContext context) => Localizations.localeOf(context);

  /// Check if dark mode is enabled
  bool isDarkMode(BuildContext context) => MediaQuery.of(context).platformBrightness == Brightness.dark;

  /// Parse a string to integer safely
  int? parseStringToInt(String value) => int.tryParse(value);

  /// Convert string to double safely
  double? parseStringToDouble(String value) => double.tryParse(value);

  /// Validate email format
  bool isValidEmail(String email) {
    final RegExp emailRegex = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return emailRegex.hasMatch(email);
  }

  /// Generate a random alphanumeric string of given length
  String generateRandomString(int length) {
    const String chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    return List<String>.generate(
      length,
      (int index) => chars[(DateTime.now().millisecondsSinceEpoch + index) % chars.length],
    ).join();
  }

  /// Delay the execution

  Future<void> delayExecution(int seconds) async {
    // Convert seconds to milliseconds for Future.delayed
    await Future<void>.delayed(Duration(seconds: seconds));
    // Execution will resume after the specified delay
  }

  /// Debouncer method to delay execution of a function
  void debounce(VoidCallback action, {int milliseconds = 500}) {
    if (_debounceTimer?.isActive ?? false) {
      _debounceTimer?.cancel();
    }
    _debounceTimer = Timer(Duration(milliseconds: milliseconds), action);
  }

  /// Convert UTC date to local date
  static String? utcToLocal(
    String? utcDate, {
    bool showAmPm = false,
  }) {
    String? localDateTime;
    final StringBuffer format = StringBuffer('dd-MM-yy HH:mm:ss');
    if (showAmPm) {
      format.write(' a');
    }
    if (utcDate != null) {
      final DateTime dateTime = DateFormat('MM/dd/yy HH:mm:ss').parse(utcDate, true).toLocal();
      localDateTime = formattedDateTime(
        dateTime,
        format.toString(),
      );
    }
    return localDateTime;
  }

  static String? formattedDateTime(DateTime? date, [String? format]) =>
      date != null ? DateFormat(format ?? 'dd-MM-yy hh:mm a').format(date) : null;
}

class Debouncer {
  Debouncer({required this.milliseconds});
  final int milliseconds;
  Timer? _timer;

  // Utility function that accepts the action (callback) to run
  void call(VoidCallback action) {
    _timer?.cancel(); // Cancel any existing timer
    _timer = Timer(Duration(milliseconds: milliseconds), action); // Start a new timer
  }

  // Dispose method to cancel the timer when no longer needed
  void dispose() {
    _timer?.cancel();
  }
}
