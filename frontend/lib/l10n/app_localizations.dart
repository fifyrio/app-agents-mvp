import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_is.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en'),
    Locale('is'),
    Locale('zh')
  ];

  /// No description provided for @commonCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get commonCancel;

  /// No description provided for @commonConfirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get commonConfirm;

  /// No description provided for @commonSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get commonSave;

  /// No description provided for @commonDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get commonDelete;

  /// No description provided for @commonRetry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get commonRetry;

  /// No description provided for @commonLoading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get commonLoading;

  /// No description provided for @commonError.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get commonError;

  /// No description provided for @commonSuccess.
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get commonSuccess;

  /// No description provided for @commonClose.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get commonClose;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @settingsLanguage.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settingsLanguage;

  /// No description provided for @settingsTermsOfUse.
  ///
  /// In en, this message translates to:
  /// **'Terms of Use'**
  String get settingsTermsOfUse;

  /// No description provided for @settingsPrivacy.
  ///
  /// In en, this message translates to:
  /// **'Privacy'**
  String get settingsPrivacy;

  /// No description provided for @settingsHelpSupport.
  ///
  /// In en, this message translates to:
  /// **'Help & Support'**
  String get settingsHelpSupport;

  /// No description provided for @settingsSelectLanguage.
  ///
  /// In en, this message translates to:
  /// **'Select Language'**
  String get settingsSelectLanguage;

  /// No description provided for @profileTitle.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profileTitle;

  /// No description provided for @profileHelloCreator.
  ///
  /// In en, this message translates to:
  /// **'Hello Creator'**
  String get profileHelloCreator;

  /// No description provided for @profileMyVideos.
  ///
  /// In en, this message translates to:
  /// **'My Videos'**
  String get profileMyVideos;

  /// No description provided for @profileNoVideos.
  ///
  /// In en, this message translates to:
  /// **'No videos yet'**
  String get profileNoVideos;

  /// No description provided for @profileCreateFirst.
  ///
  /// In en, this message translates to:
  /// **'Create your first video from the home page'**
  String get profileCreateFirst;

  /// No description provided for @homeCreate.
  ///
  /// In en, this message translates to:
  /// **'Create'**
  String get homeCreate;

  /// No description provided for @homeTextToVideo.
  ///
  /// In en, this message translates to:
  /// **'Text to Video'**
  String get homeTextToVideo;

  /// No description provided for @homeImageToVideo.
  ///
  /// In en, this message translates to:
  /// **'Image to Video'**
  String get homeImageToVideo;

  /// No description provided for @homeGenerate.
  ///
  /// In en, this message translates to:
  /// **'Generate ({credit} credit)'**
  String homeGenerate(String credit);

  /// No description provided for @homeGenerateUnlimited.
  ///
  /// In en, this message translates to:
  /// **'Generate (Unlimited)'**
  String get homeGenerateUnlimited;

  /// No description provided for @homeGetPro.
  ///
  /// In en, this message translates to:
  /// **'Get Pro'**
  String get homeGetPro;

  /// No description provided for @homePro.
  ///
  /// In en, this message translates to:
  /// **'Pro'**
  String get homePro;

  /// No description provided for @homeStyles.
  ///
  /// In en, this message translates to:
  /// **'Styles'**
  String get homeStyles;

  /// No description provided for @homeInspireMe.
  ///
  /// In en, this message translates to:
  /// **'Inspire me'**
  String get homeInspireMe;

  /// No description provided for @homeUploadImage.
  ///
  /// In en, this message translates to:
  /// **'Upload Image'**
  String get homeUploadImage;

  /// No description provided for @homeImageReady.
  ///
  /// In en, this message translates to:
  /// **'Image Ready'**
  String get homeImageReady;

  /// No description provided for @homeUploading.
  ///
  /// In en, this message translates to:
  /// **'Uploading...'**
  String get homeUploading;

  /// No description provided for @homeEnterPrompt.
  ///
  /// In en, this message translates to:
  /// **'Enter your prompt here...'**
  String get homeEnterPrompt;

  /// No description provided for @homeAnimateImage.
  ///
  /// In en, this message translates to:
  /// **'Describe how you want to animate your image...'**
  String get homeAnimateImage;

  /// No description provided for @homeTryPrompts.
  ///
  /// In en, this message translates to:
  /// **'Try Prompts'**
  String get homeTryPrompts;

  /// No description provided for @homeStartingGeneration.
  ///
  /// In en, this message translates to:
  /// **'Starting Generation...'**
  String get homeStartingGeneration;

  /// No description provided for @homeGeneratingVideo.
  ///
  /// In en, this message translates to:
  /// **'Generating Video...'**
  String get homeGeneratingVideo;

  /// No description provided for @homeViewVideo.
  ///
  /// In en, this message translates to:
  /// **'View Video'**
  String get homeViewVideo;

  /// No description provided for @msgNoCredits.
  ///
  /// In en, this message translates to:
  /// **'No Credits'**
  String get msgNoCredits;

  /// No description provided for @msgNoCreditsDesc.
  ///
  /// In en, this message translates to:
  /// **'You have no credits left. Upgrade to Pro for unlimited video generation!'**
  String get msgNoCreditsDesc;

  /// No description provided for @msgEmptyPrompt.
  ///
  /// In en, this message translates to:
  /// **'Empty Prompt'**
  String get msgEmptyPrompt;

  /// No description provided for @msgEmptyPromptDesc.
  ///
  /// In en, this message translates to:
  /// **'Please enter a prompt to generate video'**
  String get msgEmptyPromptDesc;

  /// No description provided for @msgImageUploading.
  ///
  /// In en, this message translates to:
  /// **'Image Uploading'**
  String get msgImageUploading;

  /// No description provided for @msgImageUploadingDesc.
  ///
  /// In en, this message translates to:
  /// **'Please wait for image upload to complete'**
  String get msgImageUploadingDesc;

  /// No description provided for @msgNoImageUploaded.
  ///
  /// In en, this message translates to:
  /// **'No Image Uploaded'**
  String get msgNoImageUploaded;

  /// No description provided for @msgNoImageUploadedDesc.
  ///
  /// In en, this message translates to:
  /// **'Please upload an image for image-to-video generation'**
  String get msgNoImageUploadedDesc;

  /// No description provided for @msgUploadComplete.
  ///
  /// In en, this message translates to:
  /// **'Upload Complete'**
  String get msgUploadComplete;

  /// No description provided for @msgUploadCompleteDesc.
  ///
  /// In en, this message translates to:
  /// **'Image uploaded successfully and ready for video generation'**
  String get msgUploadCompleteDesc;

  /// No description provided for @msgUploadFailed.
  ///
  /// In en, this message translates to:
  /// **'Upload Failed'**
  String get msgUploadFailed;

  /// No description provided for @msgUploadFailedDesc.
  ///
  /// In en, this message translates to:
  /// **'Failed to upload image: {error}'**
  String msgUploadFailedDesc(String error);

  /// No description provided for @msgStyleApplied.
  ///
  /// In en, this message translates to:
  /// **'Style Applied'**
  String get msgStyleApplied;

  /// No description provided for @msgStyleAppliedDesc.
  ///
  /// In en, this message translates to:
  /// **'{style} style has been selected'**
  String msgStyleAppliedDesc(String style);

  /// No description provided for @msgInspirationReady.
  ///
  /// In en, this message translates to:
  /// **'Inspiration Ready!'**
  String get msgInspirationReady;

  /// No description provided for @msgInspirationReadyDesc.
  ///
  /// In en, this message translates to:
  /// **'AI has generated an enhanced prompt for you'**
  String get msgInspirationReadyDesc;

  /// No description provided for @msgInspirationFailed.
  ///
  /// In en, this message translates to:
  /// **'Inspiration Failed'**
  String get msgInspirationFailed;

  /// No description provided for @msgInspirationFailedDesc.
  ///
  /// In en, this message translates to:
  /// **'Failed to get AI inspiration: {error}'**
  String msgInspirationFailedDesc(String error);

  /// No description provided for @msgCreditRefunded.
  ///
  /// In en, this message translates to:
  /// **'Credit Refunded'**
  String get msgCreditRefunded;

  /// No description provided for @msgCreditRefundedDesc.
  ///
  /// In en, this message translates to:
  /// **'Your credit has been refunded due to generation failure.'**
  String get msgCreditRefundedDesc;

  /// No description provided for @msgLanguageChanged.
  ///
  /// In en, this message translates to:
  /// **'Language Changed'**
  String get msgLanguageChanged;

  /// No description provided for @msgLanguageChangedDesc.
  ///
  /// In en, this message translates to:
  /// **'App language has been updated'**
  String get msgLanguageChangedDesc;

  /// No description provided for @msgCouldNotOpenLink.
  ///
  /// In en, this message translates to:
  /// **'Could not open the link'**
  String get msgCouldNotOpenLink;

  /// No description provided for @msgFailedToOpenLink.
  ///
  /// In en, this message translates to:
  /// **'Failed to open the link: {error}'**
  String msgFailedToOpenLink(String error);

  /// No description provided for @msgVideoFailed.
  ///
  /// In en, this message translates to:
  /// **'Video Failed'**
  String get msgVideoFailed;

  /// No description provided for @msgVideoFailedDesc.
  ///
  /// In en, this message translates to:
  /// **'This video generation failed'**
  String get msgVideoFailedDesc;

  /// No description provided for @msgVideoProcessing.
  ///
  /// In en, this message translates to:
  /// **'Video Processing'**
  String get msgVideoProcessing;

  /// No description provided for @msgVideoProcessingDesc.
  ///
  /// In en, this message translates to:
  /// **'This video is still being generated'**
  String get msgVideoProcessingDesc;

  /// No description provided for @msgLoadVideosFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to load videos: {error}'**
  String msgLoadVideosFailed(String error);

  /// No description provided for @timeJustNow.
  ///
  /// In en, this message translates to:
  /// **'Just now'**
  String get timeJustNow;

  /// No description provided for @timeMinuteAgo.
  ///
  /// In en, this message translates to:
  /// **'1 minute ago'**
  String get timeMinuteAgo;

  /// No description provided for @timeMinutesAgo.
  ///
  /// In en, this message translates to:
  /// **'{count} minutes ago'**
  String timeMinutesAgo(String count);

  /// No description provided for @timeHourAgo.
  ///
  /// In en, this message translates to:
  /// **'1 hour ago'**
  String get timeHourAgo;

  /// No description provided for @timeHoursAgo.
  ///
  /// In en, this message translates to:
  /// **'{count} hours ago'**
  String timeHoursAgo(String count);

  /// No description provided for @timeDayAgo.
  ///
  /// In en, this message translates to:
  /// **'1 day ago'**
  String get timeDayAgo;

  /// No description provided for @timeDaysAgo.
  ///
  /// In en, this message translates to:
  /// **'{count} days ago'**
  String timeDaysAgo(String count);

  /// No description provided for @timeMonthAgo.
  ///
  /// In en, this message translates to:
  /// **'1 month ago'**
  String get timeMonthAgo;

  /// No description provided for @timeMonthsAgo.
  ///
  /// In en, this message translates to:
  /// **'{count} months ago'**
  String timeMonthsAgo(String count);

  /// No description provided for @timeYearAgo.
  ///
  /// In en, this message translates to:
  /// **'1 year ago'**
  String get timeYearAgo;

  /// No description provided for @timeYearsAgo.
  ///
  /// In en, this message translates to:
  /// **'{count} years ago'**
  String timeYearsAgo(String count);

  /// No description provided for @videoResultTitle.
  ///
  /// In en, this message translates to:
  /// **'Result'**
  String get videoResultTitle;

  /// No description provided for @videoLoadingVideo.
  ///
  /// In en, this message translates to:
  /// **'Loading video...'**
  String get videoLoadingVideo;

  /// No description provided for @videoFailedToLoad.
  ///
  /// In en, this message translates to:
  /// **'Failed to load video'**
  String get videoFailedToLoad;

  /// No description provided for @videoFailedToLoadDesc.
  ///
  /// In en, this message translates to:
  /// **'Failed to load video: {error}'**
  String videoFailedToLoadDesc(String error);

  /// No description provided for @videoPlayerNotAvailable.
  ///
  /// In en, this message translates to:
  /// **'Video player not available'**
  String get videoPlayerNotAvailable;

  /// No description provided for @videoShare.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get videoShare;

  /// No description provided for @videoDownload.
  ///
  /// In en, this message translates to:
  /// **'Download'**
  String get videoDownload;

  /// No description provided for @videoRegenerate.
  ///
  /// In en, this message translates to:
  /// **'Regenerate'**
  String get videoRegenerate;

  /// No description provided for @videoCopy.
  ///
  /// In en, this message translates to:
  /// **'Copy'**
  String get videoCopy;

  /// No description provided for @videoCopied.
  ///
  /// In en, this message translates to:
  /// **'Copied'**
  String get videoCopied;

  /// No description provided for @videoCopiedDesc.
  ///
  /// In en, this message translates to:
  /// **'Title copied to clipboard'**
  String get videoCopiedDesc;

  /// No description provided for @videoShareMessage.
  ///
  /// In en, this message translates to:
  /// **'Check out this AI-generated video: {url}'**
  String videoShareMessage(String url);

  /// No description provided for @videoShareSubject.
  ///
  /// In en, this message translates to:
  /// **'AI Generated Video from Sova'**
  String get videoShareSubject;

  /// No description provided for @videoShareFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to share video. Please try again.'**
  String get videoShareFailed;

  /// No description provided for @videoDownloadFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to download video. Please try again.'**
  String get videoDownloadFailed;

  /// No description provided for @videoRegenerating.
  ///
  /// In en, this message translates to:
  /// **'Regenerating'**
  String get videoRegenerating;

  /// No description provided for @videoRegeneratingDesc.
  ///
  /// In en, this message translates to:
  /// **'Please enter a new prompt to generate another video.'**
  String get videoRegeneratingDesc;

  /// No description provided for @pricingTitle.
  ///
  /// In en, this message translates to:
  /// **'Unlock Full Potential'**
  String get pricingTitle;

  /// No description provided for @pricingSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Create stunning videos with AI'**
  String get pricingSubtitle;

  /// No description provided for @pricingUnlimitedGeneration.
  ///
  /// In en, this message translates to:
  /// **'Unlimited video generation'**
  String get pricingUnlimitedGeneration;

  /// No description provided for @pricingNoWatermarks.
  ///
  /// In en, this message translates to:
  /// **'No watermarks'**
  String get pricingNoWatermarks;

  /// No description provided for @pricingPriorityProcessing.
  ///
  /// In en, this message translates to:
  /// **'Priority processing'**
  String get pricingPriorityProcessing;

  /// No description provided for @pricingWeekly.
  ///
  /// In en, this message translates to:
  /// **'Weekly'**
  String get pricingWeekly;

  /// No description provided for @pricingWeeklyPrice.
  ///
  /// In en, this message translates to:
  /// **'\$7.99/week'**
  String get pricingWeeklyPrice;

  /// No description provided for @pricingMonthly.
  ///
  /// In en, this message translates to:
  /// **'Monthly'**
  String get pricingMonthly;

  /// No description provided for @pricingMonthlyPrice.
  ///
  /// In en, this message translates to:
  /// **'\$39.99/month'**
  String get pricingMonthlyPrice;

  /// No description provided for @pricingBestValue.
  ///
  /// In en, this message translates to:
  /// **'BEST VALUE'**
  String get pricingBestValue;

  /// No description provided for @pricingSubscribe.
  ///
  /// In en, this message translates to:
  /// **'Subscribe'**
  String get pricingSubscribe;

  /// No description provided for @pricingRestorePurchases.
  ///
  /// In en, this message translates to:
  /// **'Restore Purchases'**
  String get pricingRestorePurchases;

  /// No description provided for @pricingSubscriptionSuccess.
  ///
  /// In en, this message translates to:
  /// **'Subscription activated successfully!'**
  String get pricingSubscriptionSuccess;

  /// No description provided for @pricingSubscriptionFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to process subscription'**
  String get pricingSubscriptionFailed;

  /// No description provided for @pricingRestoreSuccess.
  ///
  /// In en, this message translates to:
  /// **'Purchases restored successfully!'**
  String get pricingRestoreSuccess;

  /// No description provided for @pricingRestoreFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to restore purchases'**
  String get pricingRestoreFailed;

  /// No description provided for @onboardingTitle1.
  ///
  /// In en, this message translates to:
  /// **'Generate Videos with AI Magic'**
  String get onboardingTitle1;

  /// No description provided for @onboardingDesc1.
  ///
  /// In en, this message translates to:
  /// **'Turn text or images into stunning AI-generated videos in seconds.'**
  String get onboardingDesc1;

  /// No description provided for @onboardingTitle2.
  ///
  /// In en, this message translates to:
  /// **'Transform Your Ideas Instantly'**
  String get onboardingTitle2;

  /// No description provided for @onboardingDesc2.
  ///
  /// In en, this message translates to:
  /// **'Create professional videos with just a prompt. No editing skills required.'**
  String get onboardingDesc2;

  /// No description provided for @onboardingTitle3.
  ///
  /// In en, this message translates to:
  /// **'Unlimited Creative Power'**
  String get onboardingTitle3;

  /// No description provided for @onboardingDesc3.
  ///
  /// In en, this message translates to:
  /// **'Bring your imagination to life with cutting-edge AI video generation.'**
  String get onboardingDesc3;

  /// No description provided for @onboardingNext.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get onboardingNext;

  /// No description provided for @promptPreviewPrompt.
  ///
  /// In en, this message translates to:
  /// **'Prompt'**
  String get promptPreviewPrompt;

  /// No description provided for @promptPreviewTryUsecase.
  ///
  /// In en, this message translates to:
  /// **'Try this usecase'**
  String get promptPreviewTryUsecase;

  /// No description provided for @promptPreviewFailedToLoad.
  ///
  /// In en, this message translates to:
  /// **'Failed to load media'**
  String get promptPreviewFailedToLoad;

  /// No description provided for @promptPreviewGif.
  ///
  /// In en, this message translates to:
  /// **'GIF'**
  String get promptPreviewGif;

  /// No description provided for @analyzeVideoTitle.
  ///
  /// In en, this message translates to:
  /// **'Analyze Video'**
  String get analyzeVideoTitle;

  /// No description provided for @analyzeVideoAnalyzeImages.
  ///
  /// In en, this message translates to:
  /// **'Analyze Images'**
  String get analyzeVideoAnalyzeImages;

  /// No description provided for @analyzeVideoHelp.
  ///
  /// In en, this message translates to:
  /// **'Help'**
  String get analyzeVideoHelp;

  /// No description provided for @analyzeVideoHelpMessage.
  ///
  /// In en, this message translates to:
  /// **'Video analysis help coming soon'**
  String get analyzeVideoHelpMessage;

  /// No description provided for @analyzeVideoImportVideo.
  ///
  /// In en, this message translates to:
  /// **'Import Video'**
  String get analyzeVideoImportVideo;

  /// No description provided for @analyzeVideoUploadVideo.
  ///
  /// In en, this message translates to:
  /// **'Upload Video'**
  String get analyzeVideoUploadVideo;

  /// No description provided for @analyzeVideoSupportedFormats.
  ///
  /// In en, this message translates to:
  /// **'Supported formats: MP4, MOV, AVI | Max duration: 5 minutes'**
  String get analyzeVideoSupportedFormats;

  /// No description provided for @analyzeVideoVideoPreview.
  ///
  /// In en, this message translates to:
  /// **'Video Preview'**
  String get analyzeVideoVideoPreview;

  /// No description provided for @analyzeVideoAnalysisPanel.
  ///
  /// In en, this message translates to:
  /// **'Analysis Panel'**
  String get analyzeVideoAnalysisPanel;

  /// No description provided for @analyzeVideoAnalyzeButton.
  ///
  /// In en, this message translates to:
  /// **'Analyze Video'**
  String get analyzeVideoAnalyzeButton;

  /// No description provided for @analyzeVideoAnalyzing.
  ///
  /// In en, this message translates to:
  /// **'Analyzing...'**
  String get analyzeVideoAnalyzing;

  /// No description provided for @analyzeVideoExtractingThumbnail.
  ///
  /// In en, this message translates to:
  /// **'Extracting thumbnail...'**
  String get analyzeVideoExtractingThumbnail;

  /// No description provided for @analyzeVideoUploadingThumbnail.
  ///
  /// In en, this message translates to:
  /// **'Uploading thumbnail...'**
  String get analyzeVideoUploadingThumbnail;

  /// No description provided for @analyzeVideoAiAnalyzing.
  ///
  /// In en, this message translates to:
  /// **'AI analyzing...'**
  String get analyzeVideoAiAnalyzing;

  /// No description provided for @analyzeVideoUploadProgress.
  ///
  /// In en, this message translates to:
  /// **'Upload: {progress}%'**
  String analyzeVideoUploadProgress(Object progress);

  /// No description provided for @analyzeVideoGeneratedPrompts.
  ///
  /// In en, this message translates to:
  /// **'AI Generated Prompts'**
  String get analyzeVideoGeneratedPrompts;

  /// No description provided for @analyzeVideoSelectPrompt.
  ///
  /// In en, this message translates to:
  /// **'Select a prompt to use or customize it below'**
  String get analyzeVideoSelectPrompt;

  /// No description provided for @analyzeVideoOption.
  ///
  /// In en, this message translates to:
  /// **'Option {number}'**
  String analyzeVideoOption(Object number);

  /// No description provided for @analyzeVideoPromptPanel.
  ///
  /// In en, this message translates to:
  /// **'Prompt Panel'**
  String get analyzeVideoPromptPanel;

  /// No description provided for @analyzeVideoEnterPrompt.
  ///
  /// In en, this message translates to:
  /// **'Enter your prompt...'**
  String get analyzeVideoEnterPrompt;

  /// No description provided for @analyzeVideoSeed.
  ///
  /// In en, this message translates to:
  /// **'Seed'**
  String get analyzeVideoSeed;

  /// No description provided for @analyzeVideoCopy.
  ///
  /// In en, this message translates to:
  /// **'Copy'**
  String get analyzeVideoCopy;

  /// No description provided for @analyzeVideoClear.
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get analyzeVideoClear;

  /// No description provided for @analyzeVideoError.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get analyzeVideoError;

  /// No description provided for @analyzeVideoFailedToSelect.
  ///
  /// In en, this message translates to:
  /// **'Failed to select video: {error}'**
  String analyzeVideoFailedToSelect(Object error);

  /// No description provided for @analyzeVideoFailedToLoad.
  ///
  /// In en, this message translates to:
  /// **'Failed to load video: {error}'**
  String analyzeVideoFailedToLoad(Object error);

  /// No description provided for @analyzeVideoNoVideo.
  ///
  /// In en, this message translates to:
  /// **'No Video'**
  String get analyzeVideoNoVideo;

  /// No description provided for @analyzeVideoNoVideoMessage.
  ///
  /// In en, this message translates to:
  /// **'Please select a video first'**
  String get analyzeVideoNoVideoMessage;

  /// No description provided for @analyzeVideoEmptyPrompt.
  ///
  /// In en, this message translates to:
  /// **'Empty Prompt'**
  String get analyzeVideoEmptyPrompt;

  /// No description provided for @analyzeVideoEmptyPromptMessage.
  ///
  /// In en, this message translates to:
  /// **'No prompt text to copy'**
  String get analyzeVideoEmptyPromptMessage;

  /// No description provided for @analyzeVideoCopied.
  ///
  /// In en, this message translates to:
  /// **'Copied'**
  String get analyzeVideoCopied;

  /// No description provided for @analyzeVideoCopiedMessage.
  ///
  /// In en, this message translates to:
  /// **'Prompt copied to clipboard'**
  String get analyzeVideoCopiedMessage;

  /// No description provided for @analyzeVideoSuccess.
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get analyzeVideoSuccess;

  /// No description provided for @analyzeVideoSuccessMessage.
  ///
  /// In en, this message translates to:
  /// **'Generated {count} prompt suggestions'**
  String analyzeVideoSuccessMessage(Object count);

  /// No description provided for @analyzeVideoAnalysisFailed.
  ///
  /// In en, this message translates to:
  /// **'Analysis Failed'**
  String get analyzeVideoAnalysisFailed;

  /// No description provided for @langEnglish.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get langEnglish;

  /// No description provided for @langChinese.
  ///
  /// In en, this message translates to:
  /// **'简体中文'**
  String get langChinese;

  /// No description provided for @langGerman.
  ///
  /// In en, this message translates to:
  /// **'Deutsch'**
  String get langGerman;

  /// No description provided for @langIcelandic.
  ///
  /// In en, this message translates to:
  /// **'Íslenska'**
  String get langIcelandic;

  /// No description provided for @navHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// No description provided for @navStudio.
  ///
  /// In en, this message translates to:
  /// **'Studio'**
  String get navStudio;

  /// No description provided for @navAnalyze.
  ///
  /// In en, this message translates to:
  /// **'Analyze'**
  String get navAnalyze;

  /// No description provided for @navProfile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get navProfile;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['de', 'en', 'is', 'zh'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'is':
      return AppLocalizationsIs();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
