import 'dart:io';
import 'package:dio/dio.dart';
import 'http_client_mixin.dart';
import 'auth_mixin.dart';

/// Upload Mixin - Provides file upload capabilities with progress tracking
///
/// This mixin requires HttpClientMixin and AuthMixin to function properly.
/// It provides methods for uploading files with progress callbacks.
///
/// Usage:
/// ```dart
/// class MyApiService with HttpClientMixin, AuthMixin, UploadMixin {
///   Future<String> uploadProfileImage(File image) async {
///     return await uploadFile(
///       '/upload/profile',
///       image,
///       contentType: 'image/jpeg',
///       onProgress: (progress) => print('Uploading: ${progress * 100}%'),
///     );
///   }
/// }
/// ```
mixin UploadMixin on HttpClientMixin, AuthMixin {
  /// Upload file to server
  ///
  /// [path] - The upload endpoint path
  /// [file] - The file to upload
  /// [contentType] - MIME type of the file (auto-detected if null)
  /// [onProgress] - Optional progress callback (0.0 to 1.0)
  /// [cancelToken] - Optional cancel token
  ///
  /// Returns the uploaded file URL from server response
  Future<String> uploadFile(
    String path,
    File file, {
    String? contentType,
    void Function(double progress)? onProgress,
    CancelToken? cancelToken,
  }) async {
    // Read file bytes
    final bytes = await file.readAsBytes();
    final fileName = file.path.split('/').last;

    // Auto-detect content type if not provided
    final mimeType = contentType ?? _detectContentType(fileName);

    print('📤 Uploading: $fileName (${bytes.length} bytes, $mimeType)');

    // Create options with auth and content type
    final options = await withAuthToken(contentType: mimeType);

    // Upload file
    final response = await dio.post(
      path,
      data: bytes,
      options: options,
      cancelToken: cancelToken,
      onSendProgress: (sent, total) {
        if (onProgress != null && total > 0) {
          final progress = sent / total;
          onProgress(progress);
          print('📤 Upload progress: ${(progress * 100).toInt()}%');
        }
      },
    );

    if (response.statusCode == 200) {
      final responseData = response.data as Map<String, dynamic>;
      final url = responseData['url'] as String;
      print('✅ Upload complete: $url');
      return url;
    } else {
      throw Exception(
        'Upload failed with status ${response.statusCode}: ${response.data}',
      );
    }
  }

  /// Upload multiple files
  ///
  /// [path] - The upload endpoint path
  /// [files] - List of files to upload
  /// [contentType] - MIME type (same for all files, auto-detected if null)
  /// [onProgress] - Optional progress callback for total progress
  /// [cancelToken] - Optional cancel token
  ///
  /// Returns list of uploaded file URLs
  Future<List<String>> uploadFiles(
    String path,
    List<File> files, {
    String? contentType,
    void Function(double progress)? onProgress,
    CancelToken? cancelToken,
  }) async {
    final urls = <String>[];
    final totalFiles = files.length;

    for (var i = 0; i < files.length; i++) {
      final file = files[i];
      final fileProgress = i / totalFiles;

      final url = await uploadFile(
        path,
        file,
        contentType: contentType,
        onProgress: (progress) {
          // Calculate total progress across all files
          final totalProgress = (fileProgress + (progress / totalFiles));
          onProgress?.call(totalProgress);
        },
        cancelToken: cancelToken,
      );

      urls.add(url);
    }

    return urls;
  }

  /// Detect content type from file name
  String _detectContentType(String fileName) {
    final extension = fileName.toLowerCase().split('.').last;

    // Images
    if (extension == 'png') return 'image/png';
    if (extension == 'jpg' || extension == 'jpeg') return 'image/jpeg';
    if (extension == 'gif') return 'image/gif';
    if (extension == 'webp') return 'image/webp';
    if (extension == 'svg') return 'image/svg+xml';

    // Videos
    if (extension == 'mp4') return 'video/mp4';
    if (extension == 'mov') return 'video/quicktime';
    if (extension == 'avi') return 'video/x-msvideo';
    if (extension == 'webm') return 'video/webm';

    // Audio
    if (extension == 'mp3') return 'audio/mpeg';
    if (extension == 'wav') return 'audio/wav';
    if (extension == 'ogg') return 'audio/ogg';

    // Documents
    if (extension == 'pdf') return 'application/pdf';
    if (extension == 'doc') return 'application/msword';
    if (extension == 'docx') {
      return 'application/vnd.openxmlformats-officedocument.wordprocessingml.document';
    }

    // Default
    return 'application/octet-stream';
  }
}
