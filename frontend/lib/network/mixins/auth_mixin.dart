import 'package:dio/dio.dart';
import '../../utils/jwt_manager.dart';
import '../../config/network_config.dart';

/// Authentication Mixin - Provides JWT authentication capabilities
///
/// This mixin provides methods to generate authentication headers
/// and create Options with JWT tokens automatically included.
///
/// Usage:
/// ```dart
/// class MyApiService with HttpClientMixin, AuthMixin {
///   Future<User> getProfile() async {
///     return await get<User>('/profile', options: await withAuth());
///   }
/// }
/// ```
mixin AuthMixin {
  /// Get JWT authentication token
  ///
  /// Returns the token string or throws an Exception if token generation fails
  Future<String> getAuthToken() async {
    final token = await JWTManager().apiKey;
    if (token == null) {
      throw Exception('Failed to generate authentication token');
    }
    return token;
  }

  /// Get authentication headers
  ///
  /// Returns a Map containing:
  /// - Authorization: Bearer token
  /// - Content-Type: application/json
  /// - User-Agent: App user agent string
  Future<Map<String, dynamic>> getAuthHeaders() async {
    final token = await getAuthToken();
    return {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
      'User-Agent': NetworkConfig.userAgent,
    };
  }

  /// Create Options with authentication headers
  ///
  /// [options] - Optional base Options to merge with auth headers
  ///
  /// Returns new Options with authentication headers included
  ///
  /// Usage:
  /// ```dart
  /// // Simple usage
  /// final response = await get('/api/data', options: await withAuth());
  ///
  /// // With custom options
  /// final customOptions = Options(headers: {'Custom-Header': 'value'});
  /// final response = await get('/api/data', options: await withAuth(customOptions));
  /// ```
  Future<Options> withAuth([Options? options]) async {
    final headers = await getAuthHeaders();
    return (options ?? Options()).copyWith(
      headers: {
        ...?options?.headers,
        ...headers,
      },
    );
  }

  /// Create Options with authentication token only (for custom content types)
  ///
  /// [options] - Optional base Options
  /// [contentType] - Custom content type (e.g., 'image/jpeg')
  ///
  /// Returns new Options with Bearer token and custom content type
  ///
  /// Usage for file uploads:
  /// ```dart
  /// final response = await post(
  ///   '/upload',
  ///   data: imageBytes,
  ///   options: await withAuthToken(contentType: 'image/jpeg'),
  /// );
  /// ```
  Future<Options> withAuthToken({
    Options? options,
    String? contentType,
  }) async {
    final token = await getAuthToken();
    return (options ?? Options()).copyWith(
      headers: {
        ...?options?.headers,
        'Authorization': 'Bearer $token',
        if (contentType != null) 'Content-Type': contentType,
        'User-Agent': NetworkConfig.userAgent,
      },
    );
  }
}
