extension StringExtensions on String {
  /// Capitalizes the first letter of a string
  String capitalize() {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }

  ///  (e.g., "hello world" → "Hello World")
  String toTitleCase() {
    return split(' ').map((word) => word.isNotEmpty ? word.capitalize() : word).join(' ');
  }

  /// Checks if the string is a valid email
  bool isValidEmail() {
    final regex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return regex.hasMatch(this);
  }

  /// Checks if the string contains only numeric characters
  bool isNumeric() {
    final regex = RegExp(r'^[0-9]+$');
    return regex.hasMatch(this);
  }

  /// Checks if the string contains only alphabetic characters
  bool isAlphabetic() {
    final regex = RegExp(r'^[a-zA-Z]+$');
    return regex.hasMatch(this);
  }

  /// Masks an email (e.g., test@example.com → t***@example.com)
  String maskEmail() {
    if (!isValidEmail()) return this;
    final parts = split('@');
    return '${parts[0][0]}***@${parts[1]}';
  }

  /// Hides part of a phone number (e.g., +923001234567 → +92******4567)
  String maskPhoneNumber({int visibleStart = 3, int visibleEnd = 4}) {
    if (length < visibleStart + visibleEnd) return this;
    return '${substring(0, visibleStart)}******${substring(length - visibleEnd)}';
  }

  /// Extracts numbers from a string (e.g., "Price: $120" → "120")
  String extractNumbers() {
    return replaceAll(RegExp(r'[^0-9]'), '');
  }

  /// Shortens a string and adds "..." if it exceeds the given length
  String truncate(int maxLength) {
    if (length <= maxLength) return this;
    return '${substring(0, maxLength)}...';
  }

  String get monthName {
    try {
      final date = DateTime.parse(this);
      const months = [
        'January',
        'February',
        'March',
        'April',
        'May',
        'June',
        'July',
        'August',
        'September',
        'October',
        'November',
        'December'
      ];
      return months[date.month - 1]; // Adjusting for zero-based index
    } catch (e) {
      return 'Invalid Date';
    }
  }
}
