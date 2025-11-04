/// 应用路由常量
///
/// 所有路由名称都定义在这个类中，方便统一管理和维护
/// 使用私有构造函数防止实例化
class AppRoutes {
  // 私有构造函数，防止实例化
  AppRoutes._();

  // ==================== 核心页面 ====================

  /// 启动页
  static const String splash = '/splash';

  /// 引导页（首次使用）
  static const String onboarding = '/onboarding';

  /// 主页（带底部导航栏）
  static const String home = '/home';

  // ==================== 功能页面 ====================

  /// 设置页
  static const String settings = '/settings';

  /// 订阅管理页
  static const String subscription = '/subscription';

  /// 颜色分析页
  static const String colorAnalysis = '/color-analysis';

  /// AI图片生成页
  static const String imageGeneration = '/image-generation';

  /// 历史记录页
  static const String history = '/history';

  /// 个人资料页
  static const String profile = '/profile';

  // ==================== 辅助页面 ====================

  /// 关于页面
  static const String about = '/about';

  /// 隐私政策
  static const String privacy = '/privacy';

  /// 服务条款
  static const String terms = '/terms';

  /// 帮助中心
  static const String help = '/help';

  /// 语言设置
  static const String language = '/language';

  /// 分享AI结果页
  static const String shareResult = '/share-result';

  // ==================== 工具方法 ====================

  /// 获取所有路由列表（用于调试）
  static List<String> get allRoutes => [
    splash,
    onboarding,
    home,
    settings,
    subscription,
    colorAnalysis,
    imageGeneration,
    history,
    profile,
    about,
    privacy,
    terms,
    help,
    language,
    shareResult,
  ];
}
