// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get commonCancel => 'Cancel';

  @override
  String get commonConfirm => 'Confirm';

  @override
  String get commonSave => 'Save';

  @override
  String get commonDelete => 'Delete';

  @override
  String get commonRetry => 'Retry';

  @override
  String get commonLoading => 'Loading...';

  @override
  String get commonError => 'Error';

  @override
  String get commonSuccess => 'Success';

  @override
  String get commonClose => 'Close';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get settingsLanguage => 'Language';

  @override
  String get settingsTermsOfUse => 'Terms of Use';

  @override
  String get settingsPrivacy => 'Privacy';

  @override
  String get settingsHelpSupport => 'Help & Support';

  @override
  String get settingsSelectLanguage => 'Select Language';

  @override
  String get profileTitle => 'Profile';

  @override
  String get profileHelloCreator => 'Hello Creator';

  @override
  String get profileMyVideos => 'My Videos';

  @override
  String get profileNoVideos => 'No videos yet';

  @override
  String get profileCreateFirst => 'Create your first video from the home page';

  @override
  String get homeCreate => 'Create';

  @override
  String get homeTextToVideo => 'Text to Video';

  @override
  String get homeImageToVideo => 'Image to Video';

  @override
  String homeGenerate(String credit) {
    return 'Generate ($credit credit)';
  }

  @override
  String get homeGenerateUnlimited => 'Generate (Unlimited)';

  @override
  String get homeGetPro => 'Get Pro';

  @override
  String get homePro => 'Pro';

  @override
  String get homeStyles => 'Styles';

  @override
  String get homeInspireMe => 'Inspire me';

  @override
  String get homeUploadImage => 'Upload Image';

  @override
  String get homeImageReady => 'Image Ready';

  @override
  String get homeUploading => 'Uploading...';

  @override
  String get homeEnterPrompt => 'Enter your prompt here...';

  @override
  String get homeAnimateImage =>
      'Describe how you want to animate your image...';

  @override
  String get homeTryPrompts => 'Try Prompts';

  @override
  String get homeStartingGeneration => 'Starting Generation...';

  @override
  String get homeGeneratingVideo => 'Generating Video...';

  @override
  String get homeViewVideo => 'View Video';

  @override
  String get msgNoCredits => 'No Credits';

  @override
  String get msgNoCreditsDesc =>
      'You have no credits left. Upgrade to Pro for unlimited video generation!';

  @override
  String get msgEmptyPrompt => 'Empty Prompt';

  @override
  String get msgEmptyPromptDesc => 'Please enter a prompt to generate video';

  @override
  String get msgImageUploading => 'Image Uploading';

  @override
  String get msgImageUploadingDesc =>
      'Please wait for image upload to complete';

  @override
  String get msgNoImageUploaded => 'No Image Uploaded';

  @override
  String get msgNoImageUploadedDesc =>
      'Please upload an image for image-to-video generation';

  @override
  String get msgUploadComplete => 'Upload Complete';

  @override
  String get msgUploadCompleteDesc =>
      'Image uploaded successfully and ready for video generation';

  @override
  String get msgUploadFailed => 'Upload Failed';

  @override
  String msgUploadFailedDesc(String error) {
    return 'Failed to upload image: $error';
  }

  @override
  String get msgStyleApplied => 'Style Applied';

  @override
  String msgStyleAppliedDesc(String style) {
    return '$style style has been selected';
  }

  @override
  String get msgInspirationReady => 'Inspiration Ready!';

  @override
  String get msgInspirationReadyDesc =>
      'AI has generated an enhanced prompt for you';

  @override
  String get msgInspirationFailed => 'Inspiration Failed';

  @override
  String msgInspirationFailedDesc(String error) {
    return 'Failed to get AI inspiration: $error';
  }

  @override
  String get msgCreditRefunded => 'Credit Refunded';

  @override
  String get msgCreditRefundedDesc =>
      'Your credit has been refunded due to generation failure.';

  @override
  String get msgLanguageChanged => 'Language Changed';

  @override
  String get msgLanguageChangedDesc => 'App language has been updated';

  @override
  String get msgCouldNotOpenLink => 'Could not open the link';

  @override
  String msgFailedToOpenLink(String error) {
    return 'Failed to open the link: $error';
  }

  @override
  String get msgVideoFailed => 'Video Failed';

  @override
  String get msgVideoFailedDesc => 'This video generation failed';

  @override
  String get msgVideoProcessing => 'Video Processing';

  @override
  String get msgVideoProcessingDesc => 'This video is still being generated';

  @override
  String msgLoadVideosFailed(String error) {
    return 'Failed to load videos: $error';
  }

  @override
  String get timeJustNow => 'Just now';

  @override
  String get timeMinuteAgo => '1 minute ago';

  @override
  String timeMinutesAgo(String count) {
    return '$count minutes ago';
  }

  @override
  String get timeHourAgo => '1 hour ago';

  @override
  String timeHoursAgo(String count) {
    return '$count hours ago';
  }

  @override
  String get timeDayAgo => '1 day ago';

  @override
  String timeDaysAgo(String count) {
    return '$count days ago';
  }

  @override
  String get timeMonthAgo => '1 month ago';

  @override
  String timeMonthsAgo(String count) {
    return '$count months ago';
  }

  @override
  String get timeYearAgo => '1 year ago';

  @override
  String timeYearsAgo(String count) {
    return '$count years ago';
  }

  @override
  String get videoResultTitle => 'Result';

  @override
  String get videoLoadingVideo => 'Loading video...';

  @override
  String get videoFailedToLoad => 'Failed to load video';

  @override
  String videoFailedToLoadDesc(String error) {
    return 'Failed to load video: $error';
  }

  @override
  String get videoPlayerNotAvailable => 'Video player not available';

  @override
  String get videoShare => 'Share';

  @override
  String get videoDownload => 'Download';

  @override
  String get videoRegenerate => 'Regenerate';

  @override
  String get videoCopy => 'Copy';

  @override
  String get videoCopied => 'Copied';

  @override
  String get videoCopiedDesc => 'Title copied to clipboard';

  @override
  String videoShareMessage(String url) {
    return 'Check out this AI-generated video: $url';
  }

  @override
  String get videoShareSubject => 'AI Generated Video from Sova';

  @override
  String get videoShareFailed => 'Failed to share video. Please try again.';

  @override
  String get videoDownloadFailed =>
      'Failed to download video. Please try again.';

  @override
  String get videoRegenerating => 'Regenerating';

  @override
  String get videoRegeneratingDesc =>
      'Please enter a new prompt to generate another video.';

  @override
  String get pricingTitle => 'Unlock Full Potential';

  @override
  String get pricingSubtitle => 'Create stunning videos with AI';

  @override
  String get pricingUnlimitedGeneration => 'Unlimited video generation';

  @override
  String get pricingNoWatermarks => 'No watermarks';

  @override
  String get pricingPriorityProcessing => 'Priority processing';

  @override
  String get pricingWeekly => 'Weekly';

  @override
  String get pricingWeeklyPrice => '\$7.99/week';

  @override
  String get pricingMonthly => 'Monthly';

  @override
  String get pricingMonthlyPrice => '\$39.99/month';

  @override
  String get pricingBestValue => 'BEST VALUE';

  @override
  String get pricingSubscribe => 'Subscribe';

  @override
  String get pricingRestorePurchases => 'Restore Purchases';

  @override
  String get pricingSubscriptionSuccess =>
      'Subscription activated successfully!';

  @override
  String get pricingSubscriptionFailed => 'Failed to process subscription';

  @override
  String get pricingRestoreSuccess => 'Purchases restored successfully!';

  @override
  String get pricingRestoreFailed => 'Failed to restore purchases';

  @override
  String get onboardingTitle1 => 'Generate Videos with AI Magic';

  @override
  String get onboardingDesc1 =>
      'Turn text or images into stunning AI-generated videos in seconds.';

  @override
  String get onboardingTitle2 => 'Transform Your Ideas Instantly';

  @override
  String get onboardingDesc2 =>
      'Create professional videos with just a prompt. No editing skills required.';

  @override
  String get onboardingTitle3 => 'Unlimited Creative Power';

  @override
  String get onboardingDesc3 =>
      'Bring your imagination to life with cutting-edge AI video generation.';

  @override
  String get onboardingNext => 'Next';

  @override
  String get promptPreviewPrompt => 'Prompt';

  @override
  String get promptPreviewTryUsecase => 'Try this usecase';

  @override
  String get promptPreviewFailedToLoad => 'Failed to load media';

  @override
  String get promptPreviewGif => 'GIF';

  @override
  String get analyzeVideoTitle => 'Analyze Video';

  @override
  String get analyzeVideoAnalyzeImages => 'Analyze Images';

  @override
  String get analyzeVideoHelp => 'Help';

  @override
  String get analyzeVideoHelpMessage => 'Video analysis help coming soon';

  @override
  String get analyzeVideoImportVideo => 'Import Video';

  @override
  String get analyzeVideoUploadVideo => 'Upload Video';

  @override
  String get analyzeVideoSupportedFormats =>
      'Supported formats: MP4, MOV, AVI | Max duration: 5 minutes';

  @override
  String get analyzeVideoVideoPreview => 'Video Preview';

  @override
  String get analyzeVideoAnalysisPanel => 'Analysis Panel';

  @override
  String get analyzeVideoAnalyzeButton => 'Analyze Video';

  @override
  String get analyzeVideoAnalyzing => 'Analyzing...';

  @override
  String get analyzeVideoExtractingThumbnail => 'Extracting thumbnail...';

  @override
  String get analyzeVideoUploadingThumbnail => 'Uploading thumbnail...';

  @override
  String get analyzeVideoAiAnalyzing => 'AI analyzing...';

  @override
  String analyzeVideoUploadProgress(Object progress) {
    return 'Upload: $progress%';
  }

  @override
  String get analyzeVideoGeneratedPrompts => 'AI Generated Prompts';

  @override
  String get analyzeVideoSelectPrompt =>
      'Select a prompt to use or customize it below';

  @override
  String analyzeVideoOption(Object number) {
    return 'Option $number';
  }

  @override
  String get analyzeVideoPromptPanel => 'Prompt Panel';

  @override
  String get analyzeVideoEnterPrompt => 'Enter your prompt...';

  @override
  String get analyzeVideoSeed => 'Seed';

  @override
  String get analyzeVideoCopy => 'Copy';

  @override
  String get analyzeVideoClear => 'Clear';

  @override
  String get analyzeVideoError => 'Error';

  @override
  String analyzeVideoFailedToSelect(Object error) {
    return 'Failed to select video: $error';
  }

  @override
  String analyzeVideoFailedToLoad(Object error) {
    return 'Failed to load video: $error';
  }

  @override
  String get analyzeVideoNoVideo => 'No Video';

  @override
  String get analyzeVideoNoVideoMessage => 'Please select a video first';

  @override
  String get analyzeVideoEmptyPrompt => 'Empty Prompt';

  @override
  String get analyzeVideoEmptyPromptMessage => 'No prompt text to copy';

  @override
  String get analyzeVideoCopied => 'Copied';

  @override
  String get analyzeVideoCopiedMessage => 'Prompt copied to clipboard';

  @override
  String get analyzeVideoSuccess => 'Success';

  @override
  String analyzeVideoSuccessMessage(Object count) {
    return 'Generated $count prompt suggestions';
  }

  @override
  String get analyzeVideoAnalysisFailed => 'Analysis Failed';

  @override
  String get langEnglish => 'English';

  @override
  String get langChinese => '简体中文';

  @override
  String get langGerman => 'Deutsch';

  @override
  String get langIcelandic => 'Íslenska';

  @override
  String get navHome => 'Home';

  @override
  String get navStudio => 'Studio';

  @override
  String get navAnalyze => 'Analyze';

  @override
  String get navProfile => 'Profile';
}
