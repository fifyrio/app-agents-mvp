import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app_routes.dart';
import '../pages/splash/splash_page.dart';
import '../pages/onboarding/onboarding_page.dart';
import '../pages/home/home_page.dart';
import '../pages/settings/settings_page.dart';
import '../pages/settings/settings_binding.dart';
import '../pages/subscription/subscription_page.dart';
import '../pages/subscription/subscription_binding.dart';

/// 应用页面配置
///
/// 定义所有GetX路由和页面绑定
/// 使用GetPage配置每个路由的页面、绑定、过渡动画等
class AppPages {
  // 私有构造函数，防止实例化
  AppPages._();

  /// 初始路由（应用启动时的第一个页面）
  static const String initial = AppRoutes.splash;

  /// 所有路由配置
  static final routes = [
    // ==================== 启动页 ====================
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashPage(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 300),
    ),

    // ==================== 引导页 ====================
    GetPage(
      name: AppRoutes.onboarding,
      page: () => const OnboardingPage(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),

    // ==================== 主页 ====================
    GetPage(
      name: AppRoutes.home,
      page: () => const HomePage(),
      // binding: HomeBinding(), // 如果需要的话可以添加
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 400),
    ),

    // ==================== 设置页 ====================
    GetPage(
      name: AppRoutes.settings,
      page: () => const SettingsPage(),
      binding: SettingsBinding(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),

    // ==================== 订阅页 ====================
    GetPage(
      name: AppRoutes.subscription,
      page: () => const SubscriptionPage(),
      binding: SubscriptionBinding(),
      transition: Transition.downToUp,
      transitionDuration: const Duration(milliseconds: 300),
    ),

    // ==================== 颜色分析页 ====================
    GetPage(
      name: AppRoutes.colorAnalysis,
      page: () => const ColorAnalysisPage(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),

    // ==================== AI图片生成页 ====================
    GetPage(
      name: AppRoutes.imageGeneration,
      page: () => const ImageGenerationPage(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),

    // ==================== 历史记录页 ====================
    GetPage(
      name: AppRoutes.history,
      page: () => const HistoryPage(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),

    // ==================== 个人资料页 ====================
    GetPage(
      name: AppRoutes.profile,
      page: () => const ProfilePage(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),

    // ==================== 辅助页面 ====================
    GetPage(
      name: AppRoutes.about,
      page: () => const AboutPage(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),

    GetPage(
      name: AppRoutes.privacy,
      page: () => const PrivacyPage(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),

    GetPage(
      name: AppRoutes.terms,
      page: () => const TermsPage(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),

    GetPage(
      name: AppRoutes.help,
      page: () => const HelpPage(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),

    GetPage(
      name: AppRoutes.language,
      page: () => const LanguagePage(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
  ];
}

// ==================== 临时占位页面 ====================
// 这些是临时占位页面，实际开发时应该创建独立的文件

/// 颜色分析页（占位）
class ColorAnalysisPage extends StatelessWidget {
  const ColorAnalysisPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('颜色分析')),
      body: const Center(child: Text('颜色分析页面 - 待实现')),
    );
  }
}

/// AI图片生成页（占位）
class ImageGenerationPage extends StatelessWidget {
  const ImageGenerationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('AI图片生成')),
      body: const Center(child: Text('AI图片生成页面 - 待实现')),
    );
  }
}

/// 历史记录页（占位）
class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('历史记录')),
      body: const Center(child: Text('历史记录页面 - 待实现')),
    );
  }
}

/// 个人资料页（占位）
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('个人资料')),
      body: const Center(child: Text('个人资料页面 - 待实现')),
    );
  }
}

/// 关于页（占位）
class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('关于')),
      body: const Center(child: Text('关于页面 - 待实现')),
    );
  }
}

/// 隐私政策页（占位）
class PrivacyPage extends StatelessWidget {
  const PrivacyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('隐私政策')),
      body: const Center(child: Text('隐私政策 - 待实现')),
    );
  }
}

/// 服务条款页（占位）
class TermsPage extends StatelessWidget {
  const TermsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('服务条款')),
      body: const Center(child: Text('服务条款 - 待实现')),
    );
  }
}

/// 帮助页（占位）
class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('帮助中心')),
      body: const Center(child: Text('帮助中心 - 待实现')),
    );
  }
}

/// 语言设置页（占位）
class LanguagePage extends StatelessWidget {
  const LanguagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('语言设置')),
      body: const Center(child: Text('语言设置 - 待实现')),
    );
  }
}
