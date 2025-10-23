import 'package:dio/dio.dart';
import '../../config/network_config.dart';

/// HTTP Client Mixin - Provides basic HTTP capabilities
///
/// This mixin provides fundamental HTTP methods (GET, POST, PUT, DELETE)
/// and Dio instance management with lazy initialization.
///
/// Usage:
/// ```dart
/// class MyApiService with HttpClientMixin {
///   @override
///   String get baseUrl => 'https://api.example.com';
///
///   Future<User> getUser(String id) async {
///     return await get<User>('/users/$id');
///   }
/// }
/// ```
mixin HttpClientMixin {
  Dio? _dioInstance;

  /// Lazy-initialized Dio instance
  Dio get dio {
    _dioInstance ??= _createDio();
    return _dioInstance!;
  }

  /// Create and configure Dio instance
  Dio _createDio() {
    return NetworkConfig.createDio(
      baseUrl: baseUrl,
      connectTimeout: connectTimeout,
      receiveTimeout: receiveTimeout,
    );
  }

  // Abstract configuration properties - must be implemented by subclass
  String get baseUrl;

  Duration get connectTimeout => const Duration(seconds: 30);
  Duration get receiveTimeout => const Duration(seconds: 30);

  /// HTTP GET request
  ///
  /// [path] - The endpoint path (e.g., '/users/123')
  /// [queryParameters] - Optional query parameters
  /// [options] - Optional Dio options (headers, etc.)
  ///
  /// Returns the response data cast to type T
  Future<T> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    final response = await dio.get(
      path,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
    return response.data as T;
  }

  /// HTTP POST request
  ///
  /// [path] - The endpoint path
  /// [data] - Request body data
  /// [options] - Optional Dio options
  ///
  /// Returns the response data cast to type T
  Future<T> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
  }) async {
    final response = await dio.post(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
    );
    return response.data as T;
  }

  /// HTTP PUT request
  ///
  /// [path] - The endpoint path
  /// [data] - Request body data
  /// [options] - Optional Dio options
  ///
  /// Returns the response data cast to type T
  Future<T> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    final response = await dio.put(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
    return response.data as T;
  }

  /// HTTP DELETE request
  ///
  /// [path] - The endpoint path
  /// [data] - Optional request body data
  /// [options] - Optional Dio options
  ///
  /// Returns the response data cast to type T
  Future<T> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    final response = await dio.delete(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
    return response.data as T;
  }

  /// HTTP PATCH request
  ///
  /// [path] - The endpoint path
  /// [data] - Request body data
  /// [options] - Optional Dio options
  ///
  /// Returns the response data cast to type T
  Future<T> patch<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    final response = await dio.patch(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
    return response.data as T;
  }

  /// Cancel all ongoing requests
  void cancelAllRequests() {
    dio.close(force: true);
  }

  /// Close Dio instance and clean up resources
  void disposeDio() {
    _dioInstance?.close(force: true);
    _dioInstance = null;
  }
}
