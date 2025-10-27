import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_routes.dart';

/// 个人中心Tab
class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Profile Header
            _buildProfileHeader(context),
            const SizedBox(height: 24),

            // Your Tone Card
            _buildYourToneCard(context),
            const SizedBox(height: 32),

            // My Saved Looks Section
            _buildSavedLooksSection(context),
            const SizedBox(height: 24),

            // Upgrade to Pro Card
            _buildUpgradeCard(context),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  /// Profile header with avatar and name
  Widget _buildProfileHeader(BuildContext context) {
    return Row(
      children: [
        // Profile Avatar
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color(0xFFB5A68A),
            border: Border.all(color: Colors.white, width: 3),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Center(
            child: Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),

        // User Name
        const Expanded(
          child: Text(
            'Olivia Chen',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w600,
              color: Colors.black,
              letterSpacing: -0.5,
            ),
          ),
        ),

        // Settings Icon
        InkWell(
          onTap: () {
            Get.toNamed(AppRoutes.settings);
          },
          child: Container(
            padding: const EdgeInsets.all(8),
            child: const Icon(
              Icons.settings_outlined,
              size: 24,
              color: Colors.black87,
            ),
          ),
        ),
      ],
    );
  }

  /// Your Tone card with color palette
  Widget _buildYourToneCard(BuildContext context) {
    // Color palette - Cool Summer tones
    final List<Color> colorPalette = [
      const Color(0xFFB8D4E8),
      const Color(0xFF8EBEDB),
      const Color(0xFF5A9AB8),
      const Color(0xFF0078A8),
      const Color(0xFF004E7A),
      const Color(0xFF002B4D),
    ];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          const Text(
            'Your Tone',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: Colors.black,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 8),

          // Subtitle
          Text(
            'Cool Summer',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Colors.grey[600],
              letterSpacing: -0.2,
            ),
          ),
          const SizedBox(height: 24),

          // Color Palette
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: colorPalette.map((color) {
              return Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(shape: BoxShape.circle, color: color),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  /// My Saved Looks section with grid
  Widget _buildSavedLooksSection(BuildContext context) {
    // Placeholder outfit images - in production, these would be actual images
    final List<String> outfitImages = List.generate(
      6,
      (index) => 'outfit_$index',
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Title
        const Text(
          'My Saved Looks',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: Colors.black,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 16),

        // Grid of outfit cards
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 0.65,
          ),
          itemCount: outfitImages.length,
          itemBuilder: (context, index) {
            return _buildOutfitCard(context, index);
          },
        ),
      ],
    );
  }

  /// Individual outfit card
  Widget _buildOutfitCard(BuildContext context, int index) {
    // Different background colors for variety
    final List<Color> placeholderColors = [
      const Color(0xFFF0F4F8),
      const Color(0xFFF5F5F5),
      const Color(0xFFF8F3F0),
      const Color(0xFFF0F8F5),
      const Color(0xFFF5F0F8),
      const Color(0xFFF8F5F0),
    ];

    return InkWell(
      onTap: () {
        Get.snackbar(
          '查看',
          '查看保存的穿搭 ${index + 1}',
          snackPosition: SnackPosition.BOTTOM,
        );
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Container(
            color: placeholderColors[index % placeholderColors.length],
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.checkroom, size: 48, color: Colors.grey[400]),
                  const SizedBox(height: 8),
                  Text(
                    'Look ${index + 1}',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
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

  /// Upgrade to Pro card
  Widget _buildUpgradeCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          const Text(
            'Upgrade to Pro for unlimited AI looks',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black,
              letterSpacing: -0.3,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 20),

          // Go Pro Button
          SizedBox(
            height: 48,
            child: ElevatedButton(
              onPressed: () {
                Get.toNamed(AppRoutes.subscription);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF7C3AED),
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 32),
              ),
              child: const Text(
                'Go Pro',
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
