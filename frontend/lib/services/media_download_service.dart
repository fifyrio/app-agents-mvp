import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:typed_data';

/// 媒体文件类型枚举
enum MediaType {
  image,
  video,
}

/// 下载结果状态
enum DownloadStatus {
  idle,
  checkingPermission,
  downloading,
  saving,
  success,
  failed,
}

/// 下载进度回调
typedef ProgressCallback = void Function(int received, int total);

/// 状态变化回调
typedef StatusCallback = void Function(DownloadStatus status, String message);

/// 通用媒体下载服务
/// 支持图片和视频下载到相册，提供权限管理、进度回调等功能
class MediaDownloadService extends GetxController {
  static MediaDownloadService get instance => Get.find<MediaDownloadService>();
  
  // 响应式状态
  final RxBool isDownloading = false.obs;
  final RxString statusMessage = ''.obs;
  final RxDouble downloadProgress = 0.0.obs;
  final Rx<DownloadStatus> currentStatus = DownloadStatus.idle.obs;
  
  /// 下载媒体文件到相册
  /// 
  /// [mediaUrl] 媒体文件URL
  /// [mediaType] 媒体类型（图片或视频）
  /// [fileName] 可选的文件名，不提供则自动生成
  /// [quality] 图片质量（仅对图片有效，1-100）
  /// [progressCallback] 下载进度回调
  /// [statusCallback] 状态变化回调
  Future<bool> downloadToGallery({
    required String mediaUrl,
    required MediaType mediaType,
    String? fileName,
    int quality = 100,
    ProgressCallback? progressCallback,
    StatusCallback? statusCallback,
  }) async {
    if (mediaUrl.isEmpty) {
      _updateStatus(DownloadStatus.failed, 'No media URL provided', statusCallback);
      _showError('Error', 'No media URL provided');
      return false;
    }

    try {
      isDownloading.value = true;
      downloadProgress.value = 0.0;
      
      // 检查权限
      _updateStatus(DownloadStatus.checkingPermission, 'Checking permissions...', statusCallback);
      final hasPermission = await _requestPermission();
      if (!hasPermission) {
        _updateStatus(DownloadStatus.failed, 'Permission denied', statusCallback);
        return false;
      }

      // 下载文件
      _updateStatus(DownloadStatus.downloading, 'Downloading ${mediaType.name}...', statusCallback);
      final fileData = await _downloadFile(
        mediaUrl,
        onProgress: (received, total) {
          final progress = received / total;
          downloadProgress.value = progress;
          progressCallback?.call(received, total);
        },
      );

      // 保存到相册
      _updateStatus(DownloadStatus.saving, 'Saving to gallery...', statusCallback);
      final success = await _saveToGallery(
        fileData: fileData,
        mediaType: mediaType,
        fileName: fileName,
        quality: quality,
      );

      if (success) {
        _updateStatus(DownloadStatus.success, 'Saved successfully!', statusCallback);
        _showSuccess('Success', '${mediaType.name.capitalizeFirst} saved to gallery successfully!');
        return true;
      } else {
        throw Exception('Failed to save ${mediaType.name} to gallery');
      }
    } catch (e) {
      _updateStatus(DownloadStatus.failed, 'Download failed: ${e.toString()}', statusCallback);
      _showError('Error', 'Failed to save ${mediaType.name}: ${e.toString()}');
      return false;
    } finally {
      isDownloading.value = false;
      // 3秒后清除状态
      Future.delayed(const Duration(seconds: 3), () {
        _updateStatus(DownloadStatus.idle, '', statusCallback);
      });
    }
  }

  /// 下载图片到相册（便捷方法）
  Future<bool> downloadImageToGallery({
    required String imageUrl,
    String? fileName,
    int quality = 100,
    ProgressCallback? progressCallback,
    StatusCallback? statusCallback,
  }) {
    return downloadToGallery(
      mediaUrl: imageUrl,
      mediaType: MediaType.image,
      fileName: fileName,
      quality: quality,
      progressCallback: progressCallback,
      statusCallback: statusCallback,
    );
  }

  /// 下载视频到相册（便捷方法）
  Future<bool> downloadVideoToGallery({
    required String videoUrl,
    String? fileName,
    ProgressCallback? progressCallback,
    StatusCallback? statusCallback,
  }) {
    return downloadToGallery(
      mediaUrl: videoUrl,
      mediaType: MediaType.video,
      fileName: fileName,
      progressCallback: progressCallback,
      statusCallback: statusCallback,
    );
  }

  /// 检查是否有相册访问权限
  Future<bool> hasGalleryPermission() async {
    final status = await Permission.photos.status;
    return status.isGranted || status.isLimited;
  }

  /// 请求相册访问权限
  Future<bool> _requestPermission() async {
    var status = await Permission.photos.status;
    
    if (status.isPermanentlyDenied) {
      await _showPermissionDialog();
      return false;
    }
    
    if (status.isDenied) {
      status = await Permission.photos.request();
      if (status.isDenied || status.isPermanentlyDenied) {
        if (status.isPermanentlyDenied) {
          await _showPermissionDialog();
        }
        return false;
      }
    }
    
    if (status.isRestricted) {
      _showError('Error', 'Photo access is restricted on this device.');
      return false;
    }
    
    return status.isGranted || status.isLimited;
  }

  /// 下载文件数据
  Future<Uint8List> _downloadFile(String url, {Function(int, int)? onProgress}) async {
    final dio = Dio();
    final response = await dio.get(
      url,
      options: Options(responseType: ResponseType.bytes),
      onReceiveProgress: onProgress,
    );
    return Uint8List.fromList(response.data);
  }

  /// 保存文件到相册
  Future<bool> _saveToGallery({
    required Uint8List fileData,
    required MediaType mediaType,
    String? fileName,
    int quality = 100,
  }) async {
    final defaultFileName = fileName ?? 
        'sova_${mediaType.name}_${DateTime.now().millisecondsSinceEpoch}';
    
    dynamic result;
    
    switch (mediaType) {
      case MediaType.image:
        result = await ImageGallerySaver.saveImage(
          fileData,
          name: defaultFileName,
          isReturnImagePathOfIOS: true,
          quality: quality,
        );
        break;
      case MediaType.video:
        // 对于视频，需要先保存到临时文件
        final tempDir = Directory.systemTemp;
        final tempFile = File('${tempDir.path}/$defaultFileName.mp4');
        await tempFile.writeAsBytes(fileData);
        
        result = await ImageGallerySaver.saveFile(
          tempFile.path,
          name: defaultFileName,
          isReturnPathOfIOS: true,
        );
        
        // 清理临时文件
        if (await tempFile.exists()) {
          await tempFile.delete();
        }
        break;
    }
    
    return result != null && result['isSuccess'] == true;
  }

  /// 更新状态
  void _updateStatus(DownloadStatus status, String message, StatusCallback? callback) {
    currentStatus.value = status;
    statusMessage.value = message;
    callback?.call(status, message);
  }

  /// 显示成功消息
  void _showSuccess(String title, String message) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
    );
  }

  /// 显示错误消息
  void _showError(String title, String message) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      duration: const Duration(seconds: 3),
    );
  }

  /// 显示权限对话框
  Future<void> _showPermissionDialog() async {
    Get.dialog(
      AlertDialog(
        backgroundColor: const Color(0xFF3A2B1E),
        title: const Text(
          'Permission Required',
          style: TextStyle(color: Colors.white),
        ),
        content: const Text(
          'This app needs access to your photo library to save videos. '
          'Please go to Settings > Privacy & Security > Photos and allow access.',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text(
              'Cancel',
              style: TextStyle(color: Colors.grey),
            ),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              openAppSettings();
            },
            child: const Text(
              'Open Settings',
              style: TextStyle(color: Color(0xFFE91E63)),
            ),
          ),
        ],
      ),
    );
  }
}
