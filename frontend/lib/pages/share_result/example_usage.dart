import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../routes/app_routes.dart';
import 'dart:typed_data';

/// Example usage of ShareResultPage
///
/// This file demonstrates how to navigate to the Share Result page
/// with different parameter configurations.

class ShareResultExample {
  /// Example 1: Navigate with all parameters
  static void navigateWithFullParameters() {
    // In a real app, these would be actual image bytes from the camera or gallery
    final Uint8List? beforeImageBytes = null; // Replace with actual image bytes
    final Uint8List? afterImageBytes = null; // Replace with actual image bytes

    Get.toNamed(
      AppRoutes.shareResult,
      arguments: {
        'beforeImage': beforeImageBytes,
        'afterImage': afterImageBytes,
        'colorSeason': 'Cool Summer',
        'colorPalette': [
          const Color(0xFF93A8CF), // Blue
          const Color(0xFFE89B9B), // Coral
          const Color(0xFFB58EC9), // Purple
          const Color(0xFFAEDBCE), // Mint
          const Color(0xFFE8B4D4), // Pink
        ],
      },
    );
  }

  /// Example 2: Navigate with minimal parameters (uses defaults)
  static void navigateWithDefaults() {
    Get.toNamed(AppRoutes.shareResult);
  }

  /// Example 3: Navigate with custom color season only
  static void navigateWithCustomSeason() {
    Get.toNamed(
      AppRoutes.shareResult,
      arguments: {
        'colorSeason': 'Warm Autumn',
        'colorPalette': [
          const Color(0xFFD4A574), // Warm beige
          const Color(0xFFB85C38), // Terracotta
          const Color(0xFF8B6F47), // Brown
          const Color(0xFFE8B4A0), // Peach
          const Color(0xFFA67C52), // Caramel
        ],
      },
    );
  }

  /// Example 4: Navigate from a button press
  static Widget buildNavigationButton() {
    return ElevatedButton(
      onPressed: navigateWithDefaults,
      child: const Text('Share Your Result'),
    );
  }

  /// Example 5: Navigate after color analysis completion
  static void navigateAfterAnalysis({
    required Uint8List beforeImage,
    required Uint8List afterImage,
    required String season,
    required List<Color> palette,
  }) {
    Get.toNamed(
      AppRoutes.shareResult,
      arguments: {
        'beforeImage': beforeImage,
        'afterImage': afterImage,
        'colorSeason': season,
        'colorPalette': palette,
      },
    );
  }
}

/// Example Widget showing how to integrate the navigation
class ColorAnalysisResultWidget extends StatelessWidget {
  const ColorAnalysisResultWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Color Analysis Result'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Your color season is: Cool Summer',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: () {
                // Navigate to share page
                ShareResultExample.navigateWithDefaults();
              },
              icon: const Icon(Icons.share),
              label: const Text('Share Result'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF7C3AED),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Pre-defined color palettes for different seasons
class ColorSeasonPalettes {
  static const Map<String, List<Color>> palettes = {
    'Cool Summer': [
      Color(0xFF93A8CF), // Blue
      Color(0xFFE89B9B), // Coral
      Color(0xFFB58EC9), // Purple
      Color(0xFFAEDBCE), // Mint
      Color(0xFFE8B4D4), // Pink
    ],
    'Warm Autumn': [
      Color(0xFFD4A574), // Warm beige
      Color(0xFFB85C38), // Terracotta
      Color(0xFF8B6F47), // Brown
      Color(0xFFE8B4A0), // Peach
      Color(0xFFA67C52), // Caramel
    ],
    'Cool Winter': [
      Color(0xFF2C3E50), // Navy
      Color(0xFF8E44AD), // Purple
      Color(0xFFE74C3C), // Red
      Color(0xFF3498DB), // Blue
      Color(0xFFECF0F1), // White
    ],
    'Warm Spring': [
      Color(0xFFFFF4E6), // Cream
      Color(0xFFFFB347), // Orange
      Color(0xFF90EE90), // Light green
      Color(0xFFFFD700), // Gold
      Color(0xFFFF6B9D), // Pink
    ],
  };

  static List<Color> getPalette(String season) {
    return palettes[season] ?? palettes['Cool Summer']!;
  }
}
