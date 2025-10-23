import 'dart:io';
import 'package:get/get.dart' as getx;
import '../../network/mixins/http_client_mixin.dart';
import '../../network/mixins/auth_mixin.dart';
import '../../network/mixins/error_handler_mixin.dart';
import '../../network/mixins/logger_mixin.dart';
import '../../network/mixins/upload_mixin.dart';

/// SOVA API Service - Business API implementation using Mixin architecture
///
/// This service combines multiple mixins to provide:
/// - HTTP communication (HttpClientMixin)
/// - JWT authentication (AuthMixin)
/// - Error handling (ErrorHandlerMixin)
/// - Logging (LoggerMixin)
/// - File upload (UploadMixin)
///
/// Usage:
/// ```dart
/// final sovaApi = Get.find<ApiService>();
/// final prompt = await sovaApi.getInspiration(prompt: 'A beautiful sunset');
/// ```
class ApiService extends getx.GetxService
    with
        HttpClientMixin,
        AuthMixin,
        ErrorHandlerMixin,
        LoggerMixin,
        UploadMixin {
  /// Singleton accessor
  static ApiService get to => getx.Get.find();

  // Implement HttpClientMixin required properties
  @override
  String get baseUrl => 'https://cf-sova-api-prod.fifyrio.workers.dev';

  @override
  void onInit() {
    super.onInit();
    logInfo('Initialized with base URL: $baseUrl');
  }

  @override
  void onClose() {
    disposeDio();
    super.onClose();
  }

  /// Cancel all ongoing requests
  void cancelAll() {
    cancelAllRequests();
    logInfo('All requests cancelled');
  }
}
