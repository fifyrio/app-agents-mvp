import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../routes/app_routes.dart';

/// Widget Showcase for Share Result Page
///
/// This file provides a visual showcase/demo page that demonstrates
/// the Share Result page with different configurations.
/// Useful for testing and visual verification during development.
class ShareResultShowcase extends StatelessWidget {
  const ShareResultShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Share Result Showcase'),
        backgroundColor: const Color(0xFF7C3AED),
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildShowcaseCard(
            title: 'Cool Summer',
            description: 'Default configuration with Cool Summer palette',
            season: 'Cool Summer',
            colors: const [
              Color(0xFF93A8CF), // Blue
              Color(0xFFE89B9B), // Coral
              Color(0xFFB58EC9), // Purple
              Color(0xFFAEDBCE), // Mint
              Color(0xFFE8B4D4), // Pink
            ],
          ),
          const SizedBox(height: 16),
          _buildShowcaseCard(
            title: 'Warm Autumn',
            description: 'Warm earthy tones for autumn season',
            season: 'Warm Autumn',
            colors: const [
              Color(0xFFD4A574), // Warm beige
              Color(0xFFB85C38), // Terracotta
              Color(0xFF8B6F47), // Brown
              Color(0xFFE8B4A0), // Peach
              Color(0xFFA67C52), // Caramel
            ],
          ),
          const SizedBox(height: 16),
          _buildShowcaseCard(
            title: 'Cool Winter',
            description: 'Bold and vibrant winter palette',
            season: 'Cool Winter',
            colors: const [
              Color(0xFF2C3E50), // Navy
              Color(0xFF8E44AD), // Purple
              Color(0xFFE74C3C), // Red
              Color(0xFF3498DB), // Blue
              Color(0xFFECF0F1), // White
            ],
          ),
          const SizedBox(height: 16),
          _buildShowcaseCard(
            title: 'Warm Spring',
            description: 'Fresh and bright spring colors',
            season: 'Warm Spring',
            colors: const [
              Color(0xFFFFF4E6), // Cream
              Color(0xFFFFB347), // Orange
              Color(0xFF90EE90), // Light green
              Color(0xFFFFD700), // Gold
              Color(0xFFFF6B9D), // Pink
            ],
          ),
          const SizedBox(height: 16),
          _buildShowcaseCard(
            title: 'Deep Autumn',
            description: 'Rich and deep autumn tones',
            season: 'Deep Autumn',
            colors: const [
              Color(0xFF8B4513), // Saddle brown
              Color(0xFFCD853F), // Peru
              Color(0xFF556B2F), // Dark olive
              Color(0xFFB8860B), // Dark goldenrod
              Color(0xFFA0522D), // Sienna
            ],
          ),
          const SizedBox(height: 16),
          _buildShowcaseCard(
            title: 'Light Summer',
            description: 'Soft and delicate summer pastels',
            season: 'Light Summer',
            colors: const [
              Color(0xFFB0C4DE), // Light steel blue
              Color(0xFFFFC0CB), // Pink
              Color(0xFFDDA0DD), // Plum
              Color(0xFFAFEEEE), // Pale turquoise
              Color(0xFFE6E6FA), // Lavender
            ],
          ),
          const SizedBox(height: 32),
          _buildInfoCard(),
        ],
      ),
    );
  }

  /// Build showcase card for each color season
  Widget _buildShowcaseCard({
    required String title,
    required String description,
    required String season,
    required List<Color> colors,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: () => _navigateToSharePage(season, colors),
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF7C3AED),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          description,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xFF6B7280),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: Color(0xFF9CA3AF),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _buildColorPalettePreview(colors),
            ],
          ),
        ),
      ),
    );
  }

  /// Build color palette preview
  Widget _buildColorPalettePreview(List<Color> colors) {
    return Row(
      children: colors.map((color) {
        return Padding(
          padding: const EdgeInsets.only(right: 8),
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white,
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.15),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  /// Build information card
  Widget _buildInfoCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F4F6),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.info_outline,
                color: const Color(0xFF7C3AED),
                size: 24,
              ),
              const SizedBox(width: 12),
              const Text(
                'How to use',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1F2937),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            'Tap any card above to see how the Share Result page looks with that color season and palette.',
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF6B7280),
              height: 1.5,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'The page will open with placeholder images. In a real scenario, these would be replaced with actual before/after photos from the color analysis.',
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF6B7280),
              height: 1.5,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFEDE9FE),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Row(
              children: [
                Icon(
                  Icons.lightbulb_outline,
                  color: Color(0xFF7C3AED),
                  size: 20,
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Tip: Try the save and share features on a real device to see the full functionality.',
                    style: TextStyle(
                      fontSize: 13,
                      color: Color(0xFF7C3AED),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Navigate to share result page with parameters
  void _navigateToSharePage(String season, List<Color> colors) {
    Get.toNamed(
      AppRoutes.shareResult,
      arguments: {
        'colorSeason': season,
        'colorPalette': colors,
      },
    );
  }
}

/// Quick access button widget to add to any page
class ShareResultQuickAccessButton extends StatelessWidget {
  const ShareResultQuickAccessButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () => Get.to(() => const ShareResultShowcase()),
      backgroundColor: const Color(0xFF7C3AED),
      foregroundColor: Colors.white,
      icon: const Icon(Icons.color_lens),
      label: const Text('View Showcase'),
    );
  }
}
