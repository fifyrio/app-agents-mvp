import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:app_tracking_transparency/app_tracking_transparency.dart';

/// App Tracking Transparency (ATT) 服务
///
/// 处理iOS的App Tracking Transparency权限请求
/// 根据Apple的要求，在iOS 14.5+上收集IDFA需要用户授权
///
/// 注意：需要在Info.plist中添加NSUserTrackingUsageDescription
class AppTrackingService extends GetxService {
  static AppTrackingService get to => Get.find();

  /// 是否已获得追踪权限
  final RxBool hasPermission = false.obs;

  /// 权限状态
  final Rx<TrackingStatus> status = TrackingStatus.notDetermined.obs;

  /// 广告标识符（IDFA）
  String? _idfa;

  @override
  void onInit() {
    super.onInit();
    _checkStatus();
  }

  /// 检查当前权限状态
  Future<void> _checkStatus() async {
    if (!Platform.isIOS) {
      // 非iOS平台默认允许
      hasPermission.value = true;
      status.value = TrackingStatus.authorized;
      debugPrint('AppTrackingService: Non-iOS platform, tracking allowed');
      return;
    }

    try {
      final currentStatus = await AppTrackingTransparency.trackingAuthorizationStatus;
      status.value = currentStatus;
      hasPermission.value = currentStatus == TrackingStatus.authorized;

      debugPrint('AppTrackingService initialized - Current status: $currentStatus');
    } catch (e) {
      debugPrint('AppTrackingService: Error checking status - $e');
      status.value = TrackingStatus.notDetermined;
      hasPermission.value = false;
    }
  }

  /// 请求追踪权限
  ///
  /// 在iOS上会显示系统弹窗询问用户
  /// 在其他平台上直接返回true
  Future<bool> requestPermission() async {
    if (!Platform.isIOS) {
      hasPermission.value = true;
      status.value = TrackingStatus.authorized;
      return true;
    }

    try {
      final currentStatus = await AppTrackingTransparency.trackingAuthorizationStatus;

      debugPrint('当前ATT权限状态: $currentStatus');

      if (currentStatus == TrackingStatus.notDetermined) {
        // iOS 14+ 必须延迟一点时间，否则有可能还没加载完成
        await Future.delayed(const Duration(milliseconds: 300));

        debugPrint('正在请求ATT权限...');
        final newStatus = await AppTrackingTransparency.requestTrackingAuthorization();

        status.value = newStatus;
        hasPermission.value = newStatus == TrackingStatus.authorized;

        _logPermissionStatus(newStatus);
      } else {
        status.value = currentStatus;
        hasPermission.value = currentStatus == TrackingStatus.authorized;
        _logPermissionStatus(currentStatus);
      }

      // 如果获得权限，获取IDFA
      if (hasPermission.value) {
        await _fetchIDFA();
      }

      return hasPermission.value;
    } catch (e) {
      debugPrint('❌ 请求ATT权限时出错: $e');
      hasPermission.value = false;
      status.value = TrackingStatus.denied;
      return false;
    }
  }

  /// 记录权限状态
  void _logPermissionStatus(TrackingStatus permissionStatus) {
    switch (permissionStatus) {
      case TrackingStatus.authorized:
        debugPrint('✅ ATT权限已授予');
        break;
      case TrackingStatus.denied:
        debugPrint('❌ ATT权限被拒绝');
        break;
      case TrackingStatus.restricted:
        debugPrint('⚠️ ATT权限受限制（可能是家长控制等原因）');
        break;
      case TrackingStatus.notDetermined:
        debugPrint('❓ ATT权限状态未确定');
        break;
      case TrackingStatus.notSupported:
        debugPrint('⚠️ 当前设备不支持ATT（可能是旧版本iOS）');
        break;
    }
  }

  /// 获取IDFA
  Future<void> _fetchIDFA() async {
    try {
      _idfa = await AppTrackingTransparency.getAdvertisingIdentifier();
      debugPrint('IDFA: $_idfa');
    } catch (e) {
      debugPrint('获取IDFA时出错: $e');
      _idfa = null;
    }
  }

  /// 获取广告标识符（IDFA）
  ///
  /// 只有在获得权限后才能获取
  /// 未获得权限时返回null
  Future<String?> getAdvertisingIdentifier() async {
    if (!hasPermission.value) {
      debugPrint('Cannot get IDFA: No tracking permission');
      return null;
    }

    if (_idfa != null) {
      return _idfa;
    }

    await _fetchIDFA();
    return _idfa;
  }

  /// 获取缓存的IDFA
  String? get idfa => _idfa;

  /// 是否应该显示权限请求
  ///
  /// 只有在状态为"未确定"时才应该请求
  bool get shouldRequestPermission {
    return status.value == TrackingStatus.notDetermined;
  }

  /// 是否被拒绝
  bool get isDenied {
    return status.value == TrackingStatus.denied;
  }

  /// 是否已授权
  bool get isAuthorized {
    return status.value == TrackingStatus.authorized;
  }

  /// 是否受限（例如家长控制）
  bool get isRestricted {
    return status.value == TrackingStatus.restricted;
  }

  /// 重置权限请求状态（用于测试）
  void resetPermissionRequestStatus() {
    _idfa = null;
    status.value = TrackingStatus.notDetermined;
    hasPermission.value = false;
    debugPrint('AppTrackingService: Permission status reset');
  }
}
