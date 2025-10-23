import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../routes/app_routes.dart';

/// 主页
///
/// 使用IndexedStack实现底部导航，保持各Tab状态
class HomePage extends StatefulWidget {
  const HomePage({super.key, this.initialIndex = 0});

  final int initialIndex;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  /// Tab页面列表
  final List<Widget> _pages = const [
    _ColorAnalysisTab(),
    _ImageGenerationTab(),
    _HistoryTab(),
    _ProfileTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() => _currentIndex = index);
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFFE91E63),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.palette), label: '色彩分析'),
          BottomNavigationBarItem(
            icon: Icon(Icons.auto_awesome),
            label: 'AI生成',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: '历史'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: '我的'),
        ],
      ),
    );
  }
}

// ==================== Tab页面内容 ====================

/// 色彩分析Tab
class _ColorAnalysisTab extends StatelessWidget {
  const _ColorAnalysisTab();

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

        // Notification Bell
        InkWell(
          onTap: () {
            Get.snackbar(
              '通知',
              '暂无新通知',
              snackPosition: SnackPosition.BOTTOM,
            );
          },
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.all(8),
            child: const Icon(
              Icons.notifications_outlined,
              size: 28,
              color: Colors.black87,
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

/// AI图片生成Tab
class _ImageGenerationTab extends StatelessWidget {
  const _ImageGenerationTab();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('AI图片生成')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.auto_awesome, size: 80, color: Color(0xFF9C27B0)),
            const SizedBox(height: 24),
            const Text(
              'AI图片生成',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              '使用AI生成个性化的色彩方案',
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: () {
                // TODO: 实现AI生成功能
                Get.snackbar(
                  '提示',
                  'AI生成功能开发中...',
                  snackPosition: SnackPosition.BOTTOM,
                );
              },
              icon: const Icon(Icons.create),
              label: const Text('创建图片'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF9C27B0),
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

/// 历史记录Tab
class _HistoryTab extends StatelessWidget {
  const _HistoryTab();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('历史记录')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.history, size: 80, color: Colors.grey[400]),
            const SizedBox(height: 24),
            const Text(
              '暂无历史记录',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 16),
            Text(
              '开始使用色彩分析功能吧',
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }
}

/// 个人中心Tab
class _ProfileTab extends StatelessWidget {
  const _ProfileTab();

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

        // Edit Icon
        InkWell(
          onTap: () {
            Get.snackbar(
              '编辑',
              '编辑个人资料功能开发中...',
              snackPosition: SnackPosition.BOTTOM,
            );
          },
          child: Container(
            padding: const EdgeInsets.all(8),
            child: const Icon(
              Icons.edit_outlined,
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
