import 'package:dio/dio.dart';

/// Error Handler Mixin - Provides unified error handling capabilities
///
/// This mixin wraps API calls with consistent error handling and logging.
/// It converts DioException into user-friendly Exception messages.
///
/// Usage:
/// ```dart
/// class MyApiService with HttpClientMixin, ErrorHandlerMixin {
///   Future<User> getUser(String id) async {
///     return handleApiCall(
///       () async => await get<User>('/users/$id'),
///       context: 'getUser',
///     );
///   }
/// }
/// ```
mixin ErrorHandlerMixin {
  /// Handle API call with unified error handling
  ///
  /// [apiCall] - The API call function to execute
  /// [context] - Optional context for debugging (e.g., method name)
  ///
  /// Returns the result of the API call
  /// Throws Exception with user-friendly message on error
  Future<T> handleApiCall<T>(
    Future<T> Function() apiCall, {
    String? context,
  }) async {
    try {
      return await apiCall();
    } on DioException catch (e) {
      final contextPrefix = context != null ? '[$context] ' : '';
      print('❌ ${contextPrefix}Dio error: ${e.type} - ${e.message}');

      // Handle different error types
      switch (e.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          throw Exception('${contextPrefix}Request timeout. Please check your network connection.');

        case DioExceptionType.badResponse:
          // Try to extract error message from response
          if (e.response != null) {
            final statusCode = e.response!.statusCode;
            final data = e.response!.data;

            print('❌ ${contextPrefix}Response data: $data');

            // Try to extract error message from response
            String errorMessage;
            if (data is Map<String, dynamic> && data.containsKey('error')) {
              errorMessage = data['error'].toString();
            } else if (data is String) {
              errorMessage = data;
            } else {
              errorMessage = 'Request failed with status $statusCode';
            }

            throw Exception('${contextPrefix}API Error: $errorMessage');
          }
          throw Exception('${contextPrefix}Bad response: ${e.message}');

        case DioExceptionType.cancel:
          throw Exception('${contextPrefix}Request was cancelled');

        case DioExceptionType.connectionError:
          throw Exception('${contextPrefix}Connection error. Please check your network connection.');

        case DioExceptionType.badCertificate:
          throw Exception('${contextPrefix}SSL certificate error');

        case DioExceptionType.unknown:
          throw Exception('${contextPrefix}Network error: ${e.message}');
      }
    } catch (e) {
      final contextPrefix = context != null ? '[$context] ' : '';
      print('❌ ${contextPrefix}Error: $e');
      rethrow;
    }
  }

  /// Handle API call with custom error handler
  ///
  /// [apiCall] - The API call function to execute
  /// [onError] - Custom error handler function
  /// [context] - Optional context for debugging
  ///
  /// Returns the result of the API call or the result from error handler
  Future<T> handleApiCallWithCustomError<T>(
    Future<T> Function() apiCall, {
    required T Function(Exception e) onError,
    String? context,
  }) async {
    try {
      return await handleApiCall(apiCall, context: context);
    } on Exception catch (e) {
      return onError(e);
    }
  }

  /// Parse error message from DioException
  ///
  /// [error] - The DioException to parse
  ///
  /// Returns a user-friendly error message
  String parseErrorMessage(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return 'Request timeout. Please try again.';

      case DioExceptionType.badResponse:
        if (error.response != null) {
          final data = error.response!.data;
          if (data is Map<String, dynamic> && data.containsKey('error')) {
            return data['error'].toString();
          }
          return 'Request failed with status ${error.response!.statusCode}';
        }
        return 'Bad response from server';

      case DioExceptionType.cancel:
        return 'Request was cancelled';

      case DioExceptionType.connectionError:
        return 'Connection error. Please check your network.';

      case DioExceptionType.badCertificate:
        return 'SSL certificate error';

      case DioExceptionType.unknown:
        return error.message ?? 'Unknown network error';
    }
  }
}
