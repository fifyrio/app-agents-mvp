import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'share_result_controller.dart';

/// Share Your AI Result Page
///
/// Displays a shareable card with before/after comparison images,
/// color season analysis result, and color palette.
/// Provides options to save the image or share to social media platforms.
class ShareResultPage extends GetView<ShareResultController> {
  const ShareResultPage({super.key});

  // Design colors matching the UI specification
  static const Color _backgroundColor = Color(0xFFFAFAFA);
  static const Color _primaryPurple = Color(0xFF7C3AED);
  static const Color _subtitleGray = Color(0xFF9CA3AF);
  static const Color _textBlack = Color(0xFF1F2937);
  static const Color _tiktokBlack = Color(0xFF000000);
  static const Color _copyLinkGray = Color(0xFFE5E7EB);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      appBar: _buildAppBar(),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
                    _buildSubtitle(),
                    const SizedBox(height: 24),
                    _buildShareableCard(),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }

  /// Build custom app bar with back button and title
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: _backgroundColor,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: _textBlack),
        onPressed: () => Get.back(),
      ),
      title: const Text(
        'Share Your AI Result',
        style: TextStyle(
          color: _textBlack,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      centerTitle: true,
    );
  }

  /// Build subtitle text
  Widget _buildSubtitle() {
    return const Text(
      'Share your color transformation with friends!',
      style: TextStyle(
        fontSize: 16,
        color: _subtitleGray,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  /// Build shareable result card with before/after comparison
  Widget _buildShareableCard() {
    return RepaintBoundary(
      key: controller.cardKey,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 24,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Column(
            children: [
              _buildBeforeAfterComparison(),
              _buildResultInfo(),
            ],
          ),
        ),
      ),
    );
  }

  /// Build before/after image comparison (split view)
  Widget _buildBeforeAfterComparison() {
    return Obx(() {
      final beforeImage = controller.beforeImage.value;
      final afterImage = controller.afterImage.value;

      return AspectRatio(
        aspectRatio: 0.8,
        child: Row(
          children: [
            // Before image (left half)
            Expanded(
              child: beforeImage != null
                  ? Image.memory(
                      beforeImage,
                      fit: BoxFit.cover,
                    )
                  : Container(
                      color: const Color(0xFFF3E5D7),
                      child: const Center(
                        child: Icon(
                          Icons.person_outline,
                          size: 64,
                          color: Colors.white,
                        ),
                      ),
                    ),
            ),

            // After image (right half)
            Expanded(
              child: afterImage != null
                  ? Image.memory(
                      afterImage,
                      fit: BoxFit.cover,
                    )
                  : Container(
                      color: const Color(0xFFE8D5C7),
                      child: const Center(
                        child: Icon(
                          Icons.person,
                          size: 64,
                          color: Colors.white,
                        ),
                      ),
                    ),
            ),
          ],
        ),
      );
    });
  }

  /// Build result information section (color season and palette)
  Widget _buildResultInfo() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      child: Column(
        children: [
          // Title
          const Text(
            'MY AI COLOR ANALYSIS',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.2,
              color: _textBlack,
            ),
          ),
          const SizedBox(height: 8),

          // Color Season
          Obx(() => Text(
                controller.colorSeason.value,
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                  color: _primaryPurple,
                  letterSpacing: -0.5,
                ),
              )),
          const SizedBox(height: 20),

          // Color Palette
          Obx(() => _buildColorPalette(controller.colorPalette)),
          const SizedBox(height: 20),

          // Footer text
          const Text(
            'Find your palette! @AppName',
            style: TextStyle(
              fontSize: 13,
              color: _subtitleGray,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  /// Build color palette circles
  Widget _buildColorPalette(List<Color> colors) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: colors.map((color) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          child: Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white,
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
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

  /// Build action buttons at the bottom
  Widget _buildActionButtons() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Save Image button
          _buildPrimaryButton(
            onPressed: controller.saveImage,
            icon: Icons.image_outlined,
            label: 'Save Image',
          ),
          const SizedBox(height: 12),

          // Social media buttons row
          Row(
            children: [
              // TikTok button
              Expanded(
                child: _buildSocialButton(
                  onPressed: controller.shareToTikTok,
                  label: 'TikTok',
                  backgroundColor: _tiktokBlack,
                  iconPath: 'tiktok',
                ),
              ),
              const SizedBox(width: 12),

              // Instagram button
              Expanded(
                child: _buildSocialButton(
                  onPressed: controller.shareToInstagram,
                  label: 'Instagram',
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFFC13584),
                      Color(0xFFE1306C),
                      Color(0xFFFD1D1D),
                      Color(0xFFF77737),
                      Color(0xFFFCAF45),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  iconPath: 'instagram',
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Copy Link button
          _buildSecondaryButton(
            onPressed: controller.copyLink,
            icon: Icons.link,
            label: 'Copy Link',
          ),
        ],
      ),
    );
  }

  /// Build primary action button (purple background)
  Widget _buildPrimaryButton({
    required VoidCallback onPressed,
    required IconData icon,
    required String label,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, size: 24),
        label: Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: _primaryPurple,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
        ),
      ),
    );
  }

  /// Build secondary action button (gray background)
  Widget _buildSecondaryButton({
    required VoidCallback onPressed,
    required IconData icon,
    required String label,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, size: 24),
        label: Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: _copyLinkGray,
          foregroundColor: _textBlack,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
        ),
      ),
    );
  }

  /// Build social media button with custom styling
  Widget _buildSocialButton({
    required VoidCallback onPressed,
    required String label,
    Color? backgroundColor,
    Gradient? gradient,
    required String iconPath,
  }) {
    return SizedBox(
      height: 56,
      child: Material(
        borderRadius: BorderRadius.circular(28),
        child: Ink(
          decoration: BoxDecoration(
            color: backgroundColor,
            gradient: gradient,
            borderRadius: BorderRadius.circular(28),
          ),
          child: InkWell(
            onTap: onPressed,
            borderRadius: BorderRadius.circular(28),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildSocialIcon(iconPath),
                  const SizedBox(width: 8),
                  Text(
                    label,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Build social media icon (placeholder using Material icons)
  Widget _buildSocialIcon(String platform) {
    IconData iconData;
    switch (platform) {
      case 'tiktok':
        iconData = Icons.music_note; // Placeholder for TikTok icon
        break;
      case 'instagram':
        iconData = Icons.camera_alt; // Placeholder for Instagram icon
        break;
      default:
        iconData = Icons.share;
    }

    return Icon(
      iconData,
      color: Colors.white,
      size: 24,
    );
  }
}
