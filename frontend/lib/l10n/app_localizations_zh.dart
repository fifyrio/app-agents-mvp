// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get commonCancel => '取消';

  @override
  String get commonConfirm => '确认';

  @override
  String get commonSave => '保存';

  @override
  String get commonDelete => '删除';

  @override
  String get commonRetry => '重试';

  @override
  String get commonLoading => '加载中...';

  @override
  String get commonError => '错误';

  @override
  String get commonSuccess => '成功';

  @override
  String get commonClose => '关闭';

  @override
  String get settingsTitle => '设置';

  @override
  String get settingsLanguage => '语言';

  @override
  String get settingsTermsOfUse => '使用条款';

  @override
  String get settingsPrivacy => '隐私政策';

  @override
  String get settingsHelpSupport => '帮助与支持';

  @override
  String get settingsSelectLanguage => '选择语言';

  @override
  String get profileTitle => '个人中心';

  @override
  String get profileHelloCreator => '你好，创作者';

  @override
  String get profileMyVideos => '我的视频';

  @override
  String get profileNoVideos => '还没有视频';

  @override
  String get profileCreateFirst => '从首页创建您的第一个视频';

  @override
  String get homeCreate => '创作';

  @override
  String get homeTextToVideo => '文字转视频';

  @override
  String get homeImageToVideo => '图片转视频';

  @override
  String homeGenerate(String credit) {
    return '生成（$credit 积分）';
  }

  @override
  String get homeGenerateUnlimited => '生成（不限次数）';

  @override
  String get homeGetPro => '升级专业版';

  @override
  String get homePro => '专业版';

  @override
  String get homeStyles => '风格';

  @override
  String get homeInspireMe => '获取灵感';

  @override
  String get homeUploadImage => '上传图片';

  @override
  String get homeImageReady => '图片就绪';

  @override
  String get homeUploading => '上传中...';

  @override
  String get homeEnterPrompt => '在此输入您的提示词...';

  @override
  String get homeAnimateImage => '描述您想要如何让图片动起来...';

  @override
  String get homeTryPrompts => '试试这些提示';

  @override
  String get homeStartingGeneration => '开始生成...';

  @override
  String get homeGeneratingVideo => '生成视频中...';

  @override
  String get homeViewVideo => '查看视频';

  @override
  String get msgNoCredits => '积分不足';

  @override
  String get msgNoCreditsDesc => '您的积分已用完。升级到专业版即可无限次生成视频！';

  @override
  String get msgEmptyPrompt => '提示词为空';

  @override
  String get msgEmptyPromptDesc => '请输入提示词以生成视频';

  @override
  String get msgImageUploading => '图片上传中';

  @override
  String get msgImageUploadingDesc => '请等待图片上传完成';

  @override
  String get msgNoImageUploaded => '未上传图片';

  @override
  String get msgNoImageUploadedDesc => '请上传图片以进行图片转视频生成';

  @override
  String get msgUploadComplete => '上传完成';

  @override
  String get msgUploadCompleteDesc => '图片上传成功，可以开始生成视频了';

  @override
  String get msgUploadFailed => '上传失败';

  @override
  String msgUploadFailedDesc(String error) {
    return '图片上传失败：$error';
  }

  @override
  String get msgStyleApplied => '风格已应用';

  @override
  String msgStyleAppliedDesc(String style) {
    return '已选择 $style 风格';
  }

  @override
  String get msgInspirationReady => '灵感已就绪！';

  @override
  String get msgInspirationReadyDesc => 'AI 已为您生成增强版提示词';

  @override
  String get msgInspirationFailed => '获取灵感失败';

  @override
  String msgInspirationFailedDesc(String error) {
    return '获取 AI 灵感失败：$error';
  }

  @override
  String get msgCreditRefunded => '积分已退还';

  @override
  String get msgCreditRefundedDesc => '由于生成失败，您的积分已退还。';

  @override
  String get msgLanguageChanged => '语言已更改';

  @override
  String get msgLanguageChangedDesc => '应用语言已更新';

  @override
  String get msgCouldNotOpenLink => '无法打开链接';

  @override
  String msgFailedToOpenLink(String error) {
    return '打开链接失败：$error';
  }

  @override
  String get msgVideoFailed => '视频生成失败';

  @override
  String get msgVideoFailedDesc => '此视频生成失败';

  @override
  String get msgVideoProcessing => '视频处理中';

  @override
  String get msgVideoProcessingDesc => '此视频仍在生成中';

  @override
  String msgLoadVideosFailed(String error) {
    return '加载视频失败：$error';
  }

  @override
  String get timeJustNow => '刚刚';

  @override
  String get timeMinuteAgo => '1 分钟前';

  @override
  String timeMinutesAgo(String count) {
    return '$count 分钟前';
  }

  @override
  String get timeHourAgo => '1 小时前';

  @override
  String timeHoursAgo(String count) {
    return '$count 小时前';
  }

  @override
  String get timeDayAgo => '1 天前';

  @override
  String timeDaysAgo(String count) {
    return '$count 天前';
  }

  @override
  String get timeMonthAgo => '1 个月前';

  @override
  String timeMonthsAgo(String count) {
    return '$count 个月前';
  }

  @override
  String get timeYearAgo => '1 年前';

  @override
  String timeYearsAgo(String count) {
    return '$count 年前';
  }

  @override
  String get videoResultTitle => '结果';

  @override
  String get videoLoadingVideo => '视频加载中...';

  @override
  String get videoFailedToLoad => '视频加载失败';

  @override
  String videoFailedToLoadDesc(String error) {
    return '视频加载失败：$error';
  }

  @override
  String get videoPlayerNotAvailable => '视频播放器不可用';

  @override
  String get videoShare => '分享';

  @override
  String get videoDownload => '下载';

  @override
  String get videoRegenerate => '重新生成';

  @override
  String get videoCopy => '复制';

  @override
  String get videoCopied => '已复制';

  @override
  String get videoCopiedDesc => '标题已复制到剪贴板';

  @override
  String videoShareMessage(String url) {
    return '看看这个 AI 生成的视频：$url';
  }

  @override
  String get videoShareSubject => '来自 Sova 的 AI 生成视频';

  @override
  String get videoShareFailed => '分享视频失败，请重试。';

  @override
  String get videoDownloadFailed => '下载视频失败，请重试。';

  @override
  String get videoRegenerating => '重新生成中';

  @override
  String get videoRegeneratingDesc => '请输入新的提示词以生成另一个视频。';

  @override
  String get pricingTitle => '解锁全部潜能';

  @override
  String get pricingSubtitle => '用 AI 创作精美视频';

  @override
  String get pricingUnlimitedGeneration => '无限次视频生成';

  @override
  String get pricingNoWatermarks => '无水印';

  @override
  String get pricingPriorityProcessing => '优先处理';

  @override
  String get pricingWeekly => '每周';

  @override
  String get pricingWeeklyPrice => '\$7.99/周';

  @override
  String get pricingMonthly => '每月';

  @override
  String get pricingMonthlyPrice => '\$39.99/月';

  @override
  String get pricingBestValue => '最超值';

  @override
  String get pricingSubscribe => '订阅';

  @override
  String get pricingRestorePurchases => '恢复购买';

  @override
  String get pricingSubscriptionSuccess => '订阅激活成功！';

  @override
  String get pricingSubscriptionFailed => '处理订阅失败';

  @override
  String get pricingRestoreSuccess => '购买恢复成功！';

  @override
  String get pricingRestoreFailed => '恢复购买失败';

  @override
  String get onboardingTitle1 => '用 AI 魔法生成视频';

  @override
  String get onboardingDesc1 => '将文字或图片转换为精美的 AI 生成视频，只需几秒钟。';

  @override
  String get onboardingTitle2 => '即刻实现你的创意';

  @override
  String get onboardingDesc2 => '只需一个提示词即可创作专业视频，无需编辑技能。';

  @override
  String get onboardingTitle3 => '无限创作力量';

  @override
  String get onboardingDesc3 => '用尖端 AI 视频生成技术让您的想象力变为现实。';

  @override
  String get onboardingNext => '下一步';

  @override
  String get promptPreviewPrompt => '提示词';

  @override
  String get promptPreviewTryUsecase => '试试这个案例';

  @override
  String get promptPreviewFailedToLoad => '加载媒体失败';

  @override
  String get promptPreviewGif => 'GIF';

  @override
  String get analyzeVideoTitle => '分析视频';

  @override
  String get analyzeVideoAnalyzeImages => '分析图片';

  @override
  String get analyzeVideoHelp => '帮助';

  @override
  String get analyzeVideoHelpMessage => '视频分析帮助即将推出';

  @override
  String get analyzeVideoImportVideo => '导入视频';

  @override
  String get analyzeVideoUploadVideo => '上传视频';

  @override
  String get analyzeVideoSupportedFormats => '支持格式：MP4、MOV、AVI | 最长时长：5 分钟';

  @override
  String get analyzeVideoVideoPreview => '视频预览';

  @override
  String get analyzeVideoAnalysisPanel => '分析面板';

  @override
  String get analyzeVideoAnalyzeButton => '分析视频';

  @override
  String get analyzeVideoAnalyzing => '分析中...';

  @override
  String get analyzeVideoExtractingThumbnail => '提取缩略图中...';

  @override
  String get analyzeVideoUploadingThumbnail => '上传缩略图中...';

  @override
  String get analyzeVideoAiAnalyzing => 'AI 分析中...';

  @override
  String analyzeVideoUploadProgress(Object progress) {
    return '上传：$progress%';
  }

  @override
  String get analyzeVideoGeneratedPrompts => 'AI 生成的提示词';

  @override
  String get analyzeVideoSelectPrompt => '选择一个提示词使用或在下方自定义';

  @override
  String analyzeVideoOption(Object number) {
    return '选项 $number';
  }

  @override
  String get analyzeVideoPromptPanel => '提示词面板';

  @override
  String get analyzeVideoEnterPrompt => '输入您的提示词...';

  @override
  String get analyzeVideoSeed => '种子';

  @override
  String get analyzeVideoCopy => '复制';

  @override
  String get analyzeVideoClear => '清除';

  @override
  String get analyzeVideoError => '错误';

  @override
  String analyzeVideoFailedToSelect(Object error) {
    return '选择视频失败：$error';
  }

  @override
  String analyzeVideoFailedToLoad(Object error) {
    return '加载视频失败：$error';
  }

  @override
  String get analyzeVideoNoVideo => '无视频';

  @override
  String get analyzeVideoNoVideoMessage => '请先选择视频';

  @override
  String get analyzeVideoEmptyPrompt => '提示词为空';

  @override
  String get analyzeVideoEmptyPromptMessage => '没有提示词可复制';

  @override
  String get analyzeVideoCopied => '已复制';

  @override
  String get analyzeVideoCopiedMessage => '提示词已复制到剪贴板';

  @override
  String get analyzeVideoSuccess => '成功';

  @override
  String analyzeVideoSuccessMessage(Object count) {
    return '生成了 $count 个提示词建议';
  }

  @override
  String get analyzeVideoAnalysisFailed => '分析失败';

  @override
  String get langEnglish => 'English';

  @override
  String get langChinese => '简体中文';

  @override
  String get langGerman => 'Deutsch';

  @override
  String get langIcelandic => 'Íslenska';

  @override
  String get navHome => '首页';

  @override
  String get navStudio => '工作室';

  @override
  String get navAnalyze => '分析';

  @override
  String get navProfile => '我的';
}
