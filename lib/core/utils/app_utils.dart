import 'dart:math';

class AppUtils {
  /// Generates a unique `trackId` based on the current timestamp
  /// and a random alphanumeric string.
  static String generateTrackId() {
    final timestamp = DateTime.now()
        .millisecondsSinceEpoch; // Current timestamp in milliseconds
    return "$timestamp${randomAlphaNumericString(7)}";
  }

  /// Generates a random alphanumeric string of the specified length.
  static String randomAlphaNumericString(int length) {
    const chars =
        'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    final random = Random();
    return String.fromCharCodes(
      Iterable.generate(
        length,
        (_) => chars.codeUnitAt(random.nextInt(chars.length)),
      ),
    );
  }
}
