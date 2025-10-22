import 'dart:io';
import 'package:dio/dio.dart';
import 'package:get/get.dart' as getx;
import '../config/network_config.dart';
import '../utils/jwt_manager.dart';

/// API Service for home page network requests using Dio
/// Handles all API calls for the home page including inspire me and image upload
class ApiService extends getx.GetxService {
  static ApiService get to => getx.Get.find();

  // Base URL from NetworkConfig
  static String get baseUrl => NetworkConfig.baseUrl;

  // Dio instance - initialized lazily
  Dio? _dioInstance;
  Dio get _dio {
    _dioInstance ??= NetworkConfig.createDio(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
    );
    return _dioInstance!;
  }

  @override
  void onInit() {
    super.onInit();
    // Initialize Dio on first access via getter
    print('🌐 ApiService: Initialized');
    print('✅ ApiService: Dio will be configured with base URL: $baseUrl');
  }

  /// Get JWT token for authentication
  Future<String> _getAuthToken() async {
    final token = await JWTManager().apiKey;
    if (token == null) {
      throw Exception('Failed to generate authentication token');
    }
    return token;
  }

  /// Get common headers including auth token
  Future<Map<String, dynamic>> _getHeaders() async {
    final token = await _getAuthToken();
    return {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
      'User-Agent': NetworkConfig.userAgent,
    };
  }

  /// Test API connectivity
  ///
  /// Returns true if API is reachable, false otherwise
  Future<bool> testConnection() async {
    try {
      print('🔗 ApiService: Testing connection...');

      final response = await _dio
          .get(
            '/',
            options: Options(
              headers: {'User-Agent': NetworkConfig.userAgent},
              validateStatus: (status) => status != null && status < 500,
            ),
          )
          .timeout(const Duration(seconds: 10));

      final isConnected =
          response.statusCode != null && response.statusCode! < 500;
      print(
        isConnected
            ? '✅ ApiService: Connection test passed'
            : '⚠️ ApiService: Connection test failed',
      );

      return isConnected;
    } catch (e) {
      print('❌ ApiService: Connection test failed: $e');
      return false;
    }
  }

  /// Cancel all ongoing requests
  void cancelAll() {
    _dio.close(force: true);
    print('🛑 ApiService: All requests cancelled');
  }
}
