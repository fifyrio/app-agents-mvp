import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

/// Share Result Controller
///
/// Manages the state and business logic for the Share Result page.
/// Handles image saving, social media sharing, and link copying.
class ShareResultController extends GetxController {
  /// Key for capturing the shareable card as an image
  final GlobalKey cardKey = GlobalKey();

  /// Before image (as bytes)
  final Rx<Uint8List?> beforeImage = Rx<Uint8List?>(null);

  /// After image (as bytes)
  final Rx<Uint8List?> afterImage = Rx<Uint8List?>(null);

  /// Color season name (e.g., "Cool Summer")
  final RxString colorSeason = 'Cool Summer'.obs;

  /// Color palette
  final RxList<Color> colorPalette = <Color>[
    const Color(0xFF93A8CF), // Blue
    const Color(0xFFE89B9B), // Coral
    const Color(0xFFB58EC9), // Purple
    const Color(0xFFAEDBCE), // Mint
    const Color(0xFFE8B4D4), // Pink
  ].obs;

  @override
  void onInit() {
    super.onInit();
    _loadArgumentsFromRoute();
  }

  /// Load arguments passed from previous page
  void _loadArgumentsFromRoute() {
    final args = Get.arguments as Map<String, dynamic>?;
    if (args != null) {
      if (args['beforeImage'] != null) {
        beforeImage.value = args['beforeImage'] as Uint8List;
      }
      if (args['afterImage'] != null) {
        afterImage.value = args['afterImage'] as Uint8List;
      }
      if (args['colorSeason'] != null) {
        colorSeason.value = args['colorSeason'] as String;
      }
      if (args['colorPalette'] != null) {
        colorPalette.value = args['colorPalette'] as List<Color>;
      }
    }
  }

  /// Capture the shareable card as an image
  Future<Uint8List?> _captureCardAsImage() async {
    try {
      final RenderRepaintBoundary boundary = cardKey.currentContext!
          .findRenderObject() as RenderRepaintBoundary;

      // Capture at higher resolution for better quality
      final ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      final ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);

      return byteData?.buffer.asUint8List();
    } catch (e) {
      debugPrint('Error capturing card as image: $e');
      Get.snackbar(
        'Error',
        'Failed to capture image',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withValues(alpha: 0.9),
        colorText: Colors.white,
      );
      return null;
    }
  }

  /// Save the shareable card as an image to device gallery
  Future<void> saveImage() async {
    try {
      final imageBytes = await _captureCardAsImage();
      if (imageBytes == null) return;

      // Save to gallery
      final result = await ImageGallerySaver.saveImage(
        imageBytes,
        quality: 100,
        name: 'colorwise_result_${DateTime.now().millisecondsSinceEpoch}',
      );

      if (result['isSuccess'] == true) {
        Get.snackbar(
          'Success',
          'Image saved to gallery',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green.withValues(alpha: 0.9),
          colorText: Colors.white,
          duration: const Duration(seconds: 2),
        );
      } else {
        throw Exception('Failed to save image');
      }
    } catch (e) {
      debugPrint('Error saving image: $e');
      Get.snackbar(
        'Error',
        'Failed to save image. Please check permissions.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withValues(alpha: 0.9),
        colorText: Colors.white,
      );
    }
  }

  /// Share to TikTok
  Future<void> shareToTikTok() async {
    try {
      final imageBytes = await _captureCardAsImage();
      if (imageBytes == null) return;

      // Save to temporary file
      final tempDir = await getTemporaryDirectory();
      final file = File(
          '${tempDir.path}/colorwise_result_${DateTime.now().millisecondsSinceEpoch}.png');
      await file.writeAsBytes(imageBytes);

      // Share using share_plus
      await Share.shareXFiles(
        [XFile(file.path)],
        text: 'Check out my AI color analysis result! ${colorSeason.value} #ColorWise',
      );

      Get.snackbar(
        'Share',
        'Opening share options...',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
      );
    } catch (e) {
      debugPrint('Error sharing to TikTok: $e');
      Get.snackbar(
        'Error',
        'Failed to share to TikTok',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withValues(alpha: 0.9),
        colorText: Colors.white,
      );
    }
  }

  /// Share to Instagram
  Future<void> shareToInstagram() async {
    try {
      final imageBytes = await _captureCardAsImage();
      if (imageBytes == null) return;

      // Save to temporary file
      final tempDir = await getTemporaryDirectory();
      final file = File(
          '${tempDir.path}/colorwise_result_${DateTime.now().millisecondsSinceEpoch}.png');
      await file.writeAsBytes(imageBytes);

      // Share using share_plus
      await Share.shareXFiles(
        [XFile(file.path)],
        text: 'Check out my AI color analysis result! ${colorSeason.value} #ColorWise',
      );

      Get.snackbar(
        'Share',
        'Opening share options...',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
      );
    } catch (e) {
      debugPrint('Error sharing to Instagram: $e');
      Get.snackbar(
        'Error',
        'Failed to share to Instagram',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withValues(alpha: 0.9),
        colorText: Colors.white,
      );
    }
  }

  /// Copy shareable link to clipboard
  Future<void> copyLink() async {
    try {
      // In a real app, this would generate a deep link or web URL
      // For now, we'll use a placeholder URL
      final link = 'https://colorwise.app/results/${DateTime.now().millisecondsSinceEpoch}';

      // Copy to clipboard
      await Share.share(link);

      Get.snackbar(
        'Success',
        'Link copied to clipboard',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.withValues(alpha: 0.9),
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );
    } catch (e) {
      debugPrint('Error copying link: $e');
      Get.snackbar(
        'Error',
        'Failed to copy link',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withValues(alpha: 0.9),
        colorText: Colors.white,
      );
    }
  }

  /// Update before image
  void updateBeforeImage(Uint8List image) {
    beforeImage.value = image;
  }

  /// Update after image
  void updateAfterImage(Uint8List image) {
    afterImage.value = image;
  }

  /// Update color season
  void updateColorSeason(String season) {
    colorSeason.value = season;
  }

  /// Update color palette
  void updateColorPalette(List<Color> palette) {
    colorPalette.value = palette;
  }
}
