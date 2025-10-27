import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_routes.dart';

/// 色彩分析Tab
class ColorAnalysisTab extends StatelessWidget {
  const ColorAnalysisTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          children: [
            const SizedBox(height: 16),

            // Header with avatar, greeting, and notification
            _buildHeader(context),
            const SizedBox(height: 40),

            // Hero section with title and description
            _buildHeroSection(context),
            const SizedBox(height: 32),

            // Primary CTA button
            _buildPrimaryButton(context),
            const SizedBox(height: 16),

            // Secondary action buttons
            _buildSecondaryButtons(context),
            const SizedBox(height: 48),

            // Recent analyses section
            _buildRecentAnalysesSection(context),
            const SizedBox(height: 32),

            // Premium upsell card
            _buildPremiumCard(context),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  /// Header with profile avatar, greeting, and notification bell
  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        // Profile Avatar
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey[300],
            image: const DecorationImage(
              image: NetworkImage(
                'https://ui-avatars.com/api/?name=Sarah&background=E5B299&color=fff&size=128',
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(width: 12),

        // Greeting Text
        const Expanded(
          child: Text(
            'Hello, Sarah!',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w600,
              color: Colors.black,
              letterSpacing: -0.5,
            ),
          ),
        ),

        // Get Pro Button
        ElevatedButton(
          onPressed: () {
            Get.toNamed(AppRoutes.subscription);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF7C3AED),
            foregroundColor: Colors.white,
            elevation: 0,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          child: const Text(
            'Get Pro',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              letterSpacing: -0.1,
            ),
          ),
        ),
      ],
    );
  }

  /// Hero section with main heading and description
  Widget _buildHeroSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Main Heading
        const Text(
          'Discover Your Perfect Colors',
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.w700,
            color: Colors.black,
            height: 1.2,
            letterSpacing: -1.0,
          ),
        ),
        const SizedBox(height: 16),

        // Description
        Text(
          'Get a detailed analysis of your skin tone and find the colors that suit you best.',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Colors.grey[700],
            height: 1.5,
            letterSpacing: -0.2,
          ),
        ),
      ],
    );
  }

  /// Primary call-to-action button
  Widget _buildPrimaryButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 64,
      child: ElevatedButton(
        onPressed: () {
          Get.snackbar(
            '开始分析',
            '色彩分析功能开发中...',
            snackPosition: SnackPosition.BOTTOM,
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF7C3AED), // Purple color
          foregroundColor: Colors.white,
          elevation: 0,
          shadowColor: const Color(0xFF7C3AED).withValues(alpha: 0.3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32),
          ),
        ),
        child: const Text(
          'Start Your Color Analysis',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            letterSpacing: -0.3,
          ),
        ),
      ),
    );
  }

  /// Secondary action buttons (Use Camera, Upload Photo)
  Widget _buildSecondaryButtons(BuildContext context) {
    return Row(
      children: [
        // Use Camera Button
        Expanded(
          child: _buildSecondaryButton(
            context: context,
            icon: Icons.camera_alt_outlined,
            label: 'Use Camera',
            onTap: () {
              Get.snackbar(
                '相机',
                '打开相机功能开发中...',
                snackPosition: SnackPosition.BOTTOM,
              );
            },
          ),
        ),
        const SizedBox(width: 16),

        // Upload Photo Button
        Expanded(
          child: _buildSecondaryButton(
            context: context,
            icon: Icons.photo_library_outlined,
            label: 'Upload Photo',
            onTap: () {
              Get.snackbar(
                '上传照片',
                '选择照片功能开发中...',
                snackPosition: SnackPosition.BOTTOM,
              );
            },
          ),
        ),
      ],
    );
  }

  /// Individual secondary button widget
  Widget _buildSecondaryButton({
    required BuildContext context,
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return SizedBox(
      height: 56,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFE9D5FF), // Light purple
          foregroundColor: const Color(0xFF7C3AED), // Purple text
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 20),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                letterSpacing: -0.2,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Recent analyses section with analysis cards
  Widget _buildRecentAnalysesSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Title
        const Text(
          'Your Recent Analyses',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: Colors.black,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 20),

        // Analysis Cards Grid
        Row(
          children: [
            // Cool Summer Card
            Expanded(
              child: _buildAnalysisCard(
                context: context,
                seasonName: 'Cool Summer',
                date: 'May 15, 2024',
                imageUrl: 'https://ui-avatars.com/api/?name=CS&background=4A5568&color=fff&size=400',
                backgroundColor: const Color(0xFFE5E7EB),
              ),
            ),
            const SizedBox(width: 16),

            // Warm Autumn Card
            Expanded(
              child: _buildAnalysisCard(
                context: context,
                seasonName: 'Warm Autumn',
                date: 'Apr 28, 2024',
                imageUrl: 'https://ui-avatars.com/api/?name=WA&background=C2410C&color=fff&size=400',
                backgroundColor: const Color(0xFFB45F3E),
              ),
            ),
          ],
        ),
      ],
    );
  }

  /// Individual analysis card
  Widget _buildAnalysisCard({
    required BuildContext context,
    required String seasonName,
    required String date,
    required String imageUrl,
    required Color backgroundColor,
  }) {
    return InkWell(
      onTap: () {
        Get.snackbar(
          '查看分析',
          '查看 $seasonName 分析结果',
          snackPosition: SnackPosition.BOTTOM,
        );
      },
      borderRadius: BorderRadius.circular(20),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Section
            Container(
              height: 200,
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
                image: DecorationImage(
                  image: NetworkImage(imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // Info Section
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    seasonName,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      letterSpacing: -0.3,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    date,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey[600],
                      letterSpacing: -0.2,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Premium upsell card
  Widget _buildPremiumCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: const Color(0xFFF3E8FF), // Light purple background
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Premium Icon
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: const Color(0xFF7C3AED).withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.workspace_premium_outlined,
              size: 32,
              color: Color(0xFF7C3AED),
            ),
          ),
          const SizedBox(height: 24),

          // Title
          const Text(
            'Unlock Your Full Color Potential',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: Colors.black,
              letterSpacing: -0.5,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 12),

          // Description
          Text(
            'Get access to advanced features, personalized palettes, and outfit recommendations with Premium.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: Colors.grey[700],
              height: 1.5,
              letterSpacing: -0.2,
            ),
          ),
          const SizedBox(height: 28),

          // Upgrade Button
          SizedBox(
            height: 56,
            child: ElevatedButton(
              onPressed: () {
                Get.toNamed(AppRoutes.subscription);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF7C3AED),
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 40),
              ),
              child: const Text(
                'Upgrade to Premium',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  letterSpacing: -0.2,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
