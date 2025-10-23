import 'package:flutter/foundation.dart';

/// Logger Mixin - Provides logging capabilities with emoji prefixes
///
/// This mixin provides consistent logging methods across services.
/// All logs automatically include the class name for better debugging.
///
/// Usage:
/// ```dart
/// class MyApiService with LoggerMixin {
///   Future<void> fetchData() async {
///     logInfo('Fetching data...');
///     try {
///       // API call
///       logSuccess('Data fetched successfully');
///     } catch (e) {
///       logError('Failed to fetch data: $e');
///     }
///   }
/// }
/// ```
mixin LoggerMixin {
  /// Get the service name for logging (uses runtime type)
  String get _serviceName => runtimeType.toString();

  /// Log informational message
  ///
  /// [message] - The message to log
  ///
  /// Output: ℹ️ ServiceName: message
  void logInfo(String message) {
    print('ℹ️ $_serviceName: $message');
  }

  /// Log success message
  ///
  /// [message] - The message to log
  ///
  /// Output: ✅ ServiceName: message
  void logSuccess(String message) {
    print('✅ $_serviceName: $message');
  }

  /// Log error message
  ///
  /// [message] - The message to log
  ///
  /// Output: ❌ ServiceName: message
  void logError(String message) {
    print('❌ $_serviceName: $message');
  }

  /// Log warning message
  ///
  /// [message] - The message to log
  ///
  /// Output: ⚠️ ServiceName: message
  void logWarning(String message) {
    print('⚠️ $_serviceName: $message');
  }

  /// Log debug message (only in debug mode)
  ///
  /// [message] - The message to log
  ///
  /// Output: 🐛 ServiceName: message
  void logDebug(String message) {
    if (kDebugMode) {
      print('🐛 $_serviceName: $message');
    }
  }

  /// Log API request
  ///
  /// [method] - HTTP method (GET, POST, etc.)
  /// [path] - API endpoint path
  /// [data] - Optional request data
  ///
  /// Output: 🌐 ServiceName: [METHOD] /path
  void logRequest(String method, String path, {dynamic data}) {
    print('🌐 $_serviceName: [$method] $path');
    if (data != null && kDebugMode) {
      print('📤 $_serviceName: Request data: $data');
    }
  }

  /// Log API response
  ///
  /// [method] - HTTP method (GET, POST, etc.)
  /// [path] - API endpoint path
  /// [statusCode] - HTTP status code
  /// [data] - Optional response data
  ///
  /// Output: 📥 ServiceName: [METHOD] /path -> 200
  void logResponse(
    String method,
    String path,
    int statusCode, {
    dynamic data,
  }) {
    print('📥 $_serviceName: [$method] $path -> $statusCode');
    if (data != null && kDebugMode) {
      print('📦 $_serviceName: Response data: $data');
    }
  }

  /// Log progress update
  ///
  /// [message] - The progress message
  /// [progress] - Progress value (0.0 to 1.0)
  ///
  /// Output: 📊 ServiceName: message (50%)
  void logProgress(String message, double progress) {
    final percentage = (progress * 100).toInt();
    print('📊 $_serviceName: $message ($percentage%)');
  }

  /// Log custom message with emoji
  ///
  /// [emoji] - The emoji prefix
  /// [message] - The message to log
  ///
  /// Output: [emoji] ServiceName: message
  void logCustom(String emoji, String message) {
    print('$emoji $_serviceName: $message');
  }
}
