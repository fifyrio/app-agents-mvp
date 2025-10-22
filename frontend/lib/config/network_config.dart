import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';
import 'dart:io';

/// Network configuration for the app
class NetworkConfig {
  // Backend API base URL
  // Development: Local Cloudflare Workers dev server
  // Production: Deployed Cloudflare Workers domain
  static const String _baseUrl = kReleaseMode
      ? 'https://your-worker.your-subdomain.workers.dev'
      : 'http://localhost:8787';

  /// Get the backend base URL
  static String get baseUrl => _baseUrl;

  // Proxy configuration
  // Automatically disabled in release builds, enabled in debug/profile builds
  static const bool enableProxy = !kReleaseMode;
  static const String proxyHost = '127.0.0.1';
  static const int proxyPort = 7890;

  /// Create a configured Dio instance
  static Dio createDio({
    String? baseUrl,
    Map<String, dynamic>? headers,
    Duration? connectTimeout,
    Duration? receiveTimeout,
  }) {
    final dio = Dio(
      BaseOptions(
        baseUrl: baseUrl ?? '',
        connectTimeout: connectTimeout ?? const Duration(seconds: 30),
        receiveTimeout: receiveTimeout ?? const Duration(seconds: 30),
        headers: headers ?? {},
      ),
    );

    // Configure proxy if enabled
    if (enableProxy) {
      dio.httpClientAdapter = IOHttpClientAdapter(
        createHttpClient: () {
          final client = HttpClient();

          // Set proxy
          client.findProxy = (uri) {
            return 'PROXY $proxyHost:$proxyPort';
          };

          // Allow bad certificates when using proxy (for debugging only)
          // IMPORTANT: This should NEVER be enabled in production!
          client.badCertificateCallback = (cert, host, port) => true;

          return client;
        },
      );

      print('🌐 Proxy enabled: $proxyHost:$proxyPort');
    }

    // Add interceptor for logging (optional)
    dio.interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        requestHeader: true,
        responseHeader: false,
        error: true,
        logPrint: (obj) => print('🌐 Dio: $obj'),
      ),
    );

    return dio;
  }

  /// Get User-Agent string
  static String get userAgent {
    return 'SOVAApp/1.0 (${Platform.operatingSystem} ${Platform.operatingSystemVersion}) Dart/${Platform.version}';
  }
}
