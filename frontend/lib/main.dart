import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'services/service_locator.dart';
import 'routes/app_pages.dart';
import 'config/localization_config.dart';
import 'controllers/locale_controller.dart';
import 'services/analytics_service.dart';

void main() async {
  // 确保Flutter绑定初始化
  WidgetsFlutterBinding.ensureInitialized();

  // 全局错误处理
  FlutterError.onError = (details) {
    debugPrint('Flutter error: ${details.exception}');
    debugPrint('Stack trace: ${details.stack}');
  };

  // 初始化所有服务（必须在runApp之前完成）
  await ServiceLocator.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // 获取LocaleController和AnalyticsService
    final localeController = Get.find<LocaleController>();
    final analyticsService = Get.find<AnalyticsService>();

    // 使用Obx包裹GetMaterialApp以响应locale变化
    return Obx(() => GetMaterialApp(
      title: 'ColorWise',

      // ==================== 国际化配置 ====================
      locale: localeController.locale,
      supportedLocales: LocalizationConfig.supportedLocales,
      localizationsDelegates: LocalizationConfig.delegates,
      fallbackLocale: LocalizationConfig.fallbackLocale,

      // ==================== 主题配置 ====================
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFE91E63),
        ),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 0,
        ),
      ),

      // 暗色主题
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFE91E63),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 0,
        ),
      ),

      // 主题模式（跟随系统）
      themeMode: ThemeMode.system,

      // ==================== 路由配置 ====================
      initialRoute: AppPages.initial,
      getPages: AppPages.routes,

      // 未知路由处理
      unknownRoute: GetPage(
        name: '/not-found',
        page: () => const Scaffold(
          body: Center(
            child: Text('页面未找到'),
          ),
        ),
      ),

      // ==================== 导航监听 ====================
      navigatorObservers: [analyticsService.observer],

      // ==================== 其他配置 ====================
      debugShowCheckedModeBanner: false,

      // 默认页面切换动画
      defaultTransition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),

      // 启用智能管理（自动处理内存）
      smartManagement: SmartManagement.full,
    ));
  }
}
