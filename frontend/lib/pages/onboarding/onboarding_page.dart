import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../routes/app_routes.dart';

/// 引导页数据模型
class OnboardingItem {
  final String title;
  final String description;
  final IconData icon;
  final Color color;

  const OnboardingItem({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
  });
}

/// 引导页
///
/// 首次启动时展示，介绍应用的主要功能
class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  /// 引导页内容
  final List<OnboardingItem> _items = const [
    OnboardingItem(
      title: '发现你的专属色彩',
      description: '通过AI分析，找到最适合你的颜色搭配方案',
      icon: Icons.palette,
      color: Color(0xFFE91E63),
    ),
    OnboardingItem(
      title: 'AI图片生成',
      description: '使用先进的AI技术，生成个性化的色彩方案图片',
      icon: Icons.auto_awesome,
      color: Color(0xFF9C27B0),
    ),
    OnboardingItem(
      title: '保存与分享',
      description: '保存你喜欢的色彩方案，并与朋友分享',
      icon: Icons.favorite,
      color: Color(0xFF3F51B5),
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  /// 完成引导
  Future<void> _completeOnboarding() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('has_seen_onboarding', true);
      Get.offAllNamed(AppRoutes.home);
    } catch (e) {
      debugPrint('Error saving onboarding status: $e');
      Get.offAllNamed(AppRoutes.home);
    }
  }

  /// 跳过引导
  void _skipOnboarding() {
    _completeOnboarding();
  }

  /// 下一页
  void _nextPage() {
    if (_currentPage < _items.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _completeOnboarding();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // 跳过按钮
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.topRight,
                child: TextButton(
                  onPressed: _skipOnboarding,
                  child: const Text(
                    '跳过',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ),

            // 内容区域
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemCount: _items.length,
                itemBuilder: (context, index) {
                  final item = _items[index];
                  return _buildPage(item);
                },
              ),
            ),

            // 指示器
            _buildIndicator(),

            const SizedBox(height: 32),

            // 下一步/开始按钮
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _nextPage,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _items[_currentPage].color,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    _currentPage == _items.length - 1 ? '开始使用' : '下一步',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  /// 构建单个引导页
  Widget _buildPage(OnboardingItem item) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // 图标
          Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              color: item.color.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              item.icon,
              size: 80,
              color: item.color,
            ),
          ),

          const SizedBox(height: 48),

          // 标题
          Text(
            item.title,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.grey[900],
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 16),

          // 描述
          Text(
            item.description,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  /// 构建页面指示器
  Widget _buildIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        _items.length,
        (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: _currentPage == index ? 24 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: _currentPage == index
                ? _items[_currentPage].color
                : Colors.grey[300],
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }
}
