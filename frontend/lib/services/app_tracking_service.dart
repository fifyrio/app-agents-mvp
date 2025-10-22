import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'dart:io' show Platform;

class AppTrackingService {
  static bool _hasRequestedPermission = false;
  static String? _idfa;

  /// 重置权限请求状态（用于测试）
  static void resetPermissionRequestStatus() {
    _hasRequestedPermission = false;
    _idfa = null;
  }

  /// 请求 App Tracking Transparency 权限
  static Future<void> requestTrackingPermission() async {
    // 只在 iOS 上请求 ATT 权限
    if (!Platform.isIOS || _hasRequestedPermission) {
      return;
    }

    try {
      // 获取当前授权状态
      final status = await AppTrackingTransparency.trackingAuthorizationStatus;

      print('当前ATT权限状态: $status');

      // iOS 14+ 必须延迟一点时间，否则有可能还没加载完成
      if (status == TrackingStatus.notDetermined) {
        await Future.delayed(const Duration(milliseconds: 300));
        print('正在请求ATT权限...');
        final newStatus = await AppTrackingTransparency.requestTrackingAuthorization();

        switch (newStatus) {
          case TrackingStatus.authorized:
            print('✅ ATT权限已授予');
            break;
          case TrackingStatus.denied:
            print('❌ ATT权限被拒绝');
            break;
          case TrackingStatus.restricted:
            print('⚠️ ATT权限受限制（可能是家长控制等原因）');
            break;
          case TrackingStatus.notDetermined:
            print('❓ ATT权限状态未确定');
            break;
          case TrackingStatus.notSupported:
            print('⚠️ 当前设备不支持ATT（可能是旧版本iOS）');
            break;
        }
      } else if (status == TrackingStatus.authorized) {
        print('✅ ATT权限已授予（之前已获得）');
      } else if (status == TrackingStatus.denied) {
        print('❌ ATT权限已被拒绝');
      } else if (status == TrackingStatus.restricted) {
        print('⚠️ ATT权限受限制（可能是家长控制等原因）');
      }

      // 获取设备的广告标识符 (IDFA)
      _idfa = await AppTrackingTransparency.getAdvertisingIdentifier();
      print('IDFA: $_idfa');

      _hasRequestedPermission = true;
    } catch (e) {
      print('❌ 请求ATT权限时出错: $e');
    }
  }

  /// 检查是否已有 ATT 权限
  static Future<bool> hasTrackingPermission() async {
    if (!Platform.isIOS) {
      return true; // Android 不需要此权限
    }

    try {
      final status = await AppTrackingTransparency.trackingAuthorizationStatus;
      return status == TrackingStatus.authorized;
    } catch (e) {
      print('检查ATT权限状态时出错: $e');
      return false;
    }
  }

  /// 获取广告标识符（IDFA）
  static String? get idfa => _idfa;

  /// 获取当前的广告标识符
  static Future<String> getAdvertisingIdentifier() async {
    if (_idfa != null) {
      return _idfa!;
    }

    try {
      _idfa = await AppTrackingTransparency.getAdvertisingIdentifier();
      return _idfa ?? '';
    } catch (e) {
      print('获取IDFA时出错: $e');
      return '';
    }
  }
}
