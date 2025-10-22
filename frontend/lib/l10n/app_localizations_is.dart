// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Icelandic (`is`).
class AppLocalizationsIs extends AppLocalizations {
  AppLocalizationsIs([String locale = 'is']) : super(locale);

  @override
  String get commonCancel => 'Hætta við';

  @override
  String get commonConfirm => 'Staðfesta';

  @override
  String get commonSave => 'Vista';

  @override
  String get commonDelete => 'Eyða';

  @override
  String get commonRetry => 'Reyna aftur';

  @override
  String get commonLoading => 'Hleður...';

  @override
  String get commonError => 'Villa';

  @override
  String get commonSuccess => 'Tókst';

  @override
  String get commonClose => 'Loka';

  @override
  String get settingsTitle => 'Stillingar';

  @override
  String get settingsLanguage => 'Tungumál';

  @override
  String get settingsTermsOfUse => 'Notkunarskilmálar';

  @override
  String get settingsPrivacy => 'Persónuvernd';

  @override
  String get settingsHelpSupport => 'Hjálp og stuðningur';

  @override
  String get settingsSelectLanguage => 'Veldu tungumál';

  @override
  String get profileTitle => 'Prófíll';

  @override
  String get profileHelloCreator => 'Hæ, skapari';

  @override
  String get profileMyVideos => 'Myndbönd mín';

  @override
  String get profileNoVideos => 'Engin myndbönd enn';

  @override
  String get profileCreateFirst => 'Byrjaðu fyrsta myndbandið á heimasíðunni';

  @override
  String get homeCreate => 'Búa til';

  @override
  String get homeTextToVideo => 'Texti í myndband';

  @override
  String get homeImageToVideo => 'Mynd í myndband';

  @override
  String homeGenerate(String credit) {
    return 'Búa til ($credit inneign)';
  }

  @override
  String get homeGenerateUnlimited => 'Búa til (ótakmarkað)';

  @override
  String get homeGetPro => 'Fá Pro';

  @override
  String get homePro => 'Pro';

  @override
  String get homeStyles => 'Stílar';

  @override
  String get homeInspireMe => 'Innblástur';

  @override
  String get homeUploadImage => 'Hlaða upp mynd';

  @override
  String get homeImageReady => 'Mynd tilbúin';

  @override
  String get homeUploading => 'Hleð upp...';

  @override
  String get homeEnterPrompt => 'Sláðu inn kvaðningu...';

  @override
  String get homeAnimateImage => 'Lýstu hvernig myndin á að hreyfast...';

  @override
  String get homeTryPrompts => 'Prófa kvaðningar';

  @override
  String get homeStartingGeneration => 'Byrja myndgerð...';

  @override
  String get homeGeneratingVideo => 'Bý til myndband...';

  @override
  String get homeViewVideo => 'Skoða myndband';

  @override
  String get msgNoCredits => 'Engin inneign';

  @override
  String get msgNoCreditsDesc =>
      'Inneign búin. Uppfærðu í Pro fyrir ótakmörkuð myndbönd.';

  @override
  String get msgEmptyPrompt => 'Tóm kvaðning';

  @override
  String get msgEmptyPromptDesc =>
      'Sláðu inn kvaðningu til að búa til myndband.';

  @override
  String get msgImageUploading => 'Mynd hleðst upp';

  @override
  String get msgImageUploadingDesc => 'Bíddu þar til upphleðslu lýkur.';

  @override
  String get msgNoImageUploaded => 'Engin mynd';

  @override
  String get msgNoImageUploadedDesc => 'Hladdu upp mynd fyrir mynd-í-myndband.';

  @override
  String get msgUploadComplete => 'Upphleðslu lokið';

  @override
  String get msgUploadCompleteDesc => 'Mynd tilbúin fyrir myndbandagerð.';

  @override
  String get msgUploadFailed => 'Upphleðsla mistókst';

  @override
  String msgUploadFailedDesc(String error) {
    return 'Mynd-upphleðsla mistókst: $error';
  }

  @override
  String get msgStyleApplied => 'Stíll virkur';

  @override
  String msgStyleAppliedDesc(String style) {
    return '$style stíll valinn.';
  }

  @override
  String get msgInspirationReady => 'Hugmynd tilbúin';

  @override
  String get msgInspirationReadyDesc => 'Gervigreind bjó til betri kvaðningu.';

  @override
  String get msgInspirationFailed => 'Hugmynd mistókst';

  @override
  String msgInspirationFailedDesc(String error) {
    return 'Ekki tókst að ná kvaðningu: $error';
  }

  @override
  String get msgCreditRefunded => 'Inneign endurgreidd';

  @override
  String get msgCreditRefundedDesc => 'Inneign skilað vegna villu.';

  @override
  String get msgLanguageChanged => 'Tungumáli breytt';

  @override
  String get msgLanguageChangedDesc => 'Tungumál forritsins uppfært.';

  @override
  String get msgCouldNotOpenLink => 'Gat ekki opnað tengil';

  @override
  String msgFailedToOpenLink(String error) {
    return 'Mistókst að opna: $error';
  }

  @override
  String get msgVideoFailed => 'Myndband mistókst';

  @override
  String get msgVideoFailedDesc => 'Ekki tókst að búa til myndbandið.';

  @override
  String get msgVideoProcessing => 'Myndband í vinnslu';

  @override
  String get msgVideoProcessingDesc => 'Myndbandið er enn að vinnast.';

  @override
  String msgLoadVideosFailed(String error) {
    return 'Mistókst að hlaða myndböndum: $error';
  }

  @override
  String get timeJustNow => 'Rétt í þessu';

  @override
  String get timeMinuteAgo => 'fyrir 1 mínútu';

  @override
  String timeMinutesAgo(String count) {
    return 'fyrir $count mínútum';
  }

  @override
  String get timeHourAgo => 'fyrir 1 klukkustund';

  @override
  String timeHoursAgo(String count) {
    return 'fyrir $count klukkustundum';
  }

  @override
  String get timeDayAgo => 'fyrir 1 degi';

  @override
  String timeDaysAgo(String count) {
    return 'fyrir $count dögum';
  }

  @override
  String get timeMonthAgo => 'fyrir 1 mánuði';

  @override
  String timeMonthsAgo(String count) {
    return 'fyrir $count mánuðum';
  }

  @override
  String get timeYearAgo => 'fyrir 1 ári';

  @override
  String timeYearsAgo(String count) {
    return 'fyrir $count árum';
  }

  @override
  String get videoResultTitle => 'Niðurstaða';

  @override
  String get videoLoadingVideo => 'Hleð myndbandi...';

  @override
  String get videoFailedToLoad => 'Mistókst að hlaða myndbandi';

  @override
  String videoFailedToLoadDesc(String error) {
    return 'Villa við upphleðslu: $error';
  }

  @override
  String get videoPlayerNotAvailable => 'Spilari ekki tiltækur';

  @override
  String get videoShare => 'Deila';

  @override
  String get videoDownload => 'Hlaða niður';

  @override
  String get videoRegenerate => 'Endurgera';

  @override
  String get videoCopy => 'Afrita';

  @override
  String get videoCopied => 'Afritað';

  @override
  String get videoCopiedDesc => 'Titill afritaður á klemmuspjald.';

  @override
  String videoShareMessage(String url) {
    return 'Skoðaðu þetta KI-myndband: $url';
  }

  @override
  String get videoShareSubject => 'KI-myndband frá Sova';

  @override
  String get videoShareFailed => 'Mistókst að deila. Reyndu aftur.';

  @override
  String get videoDownloadFailed => 'Mistókst að sækja. Reyndu aftur.';

  @override
  String get videoRegenerating => 'Endurgera';

  @override
  String get videoRegeneratingDesc =>
      'Sláðu inn nýja kvaðningu fyrir annað myndband.';

  @override
  String get pricingTitle => 'Opnaðu meiri möguleika';

  @override
  String get pricingSubtitle => 'Búðu til glæsileg KI-myndbönd';

  @override
  String get pricingUnlimitedGeneration => 'Ótakmörkuð myndbönd';

  @override
  String get pricingNoWatermarks => 'Engin vatnsmerki';

  @override
  String get pricingPriorityProcessing => 'Forgangur í vinnslu';

  @override
  String get pricingWeekly => 'Vikulegt';

  @override
  String get pricingWeeklyPrice => '\$7.99/viku';

  @override
  String get pricingMonthly => 'Mánaðarlegt';

  @override
  String get pricingMonthlyPrice => '\$39.99/mánuði';

  @override
  String get pricingBestValue => 'BESTA GILD';

  @override
  String get pricingSubscribe => 'Gerast áskrifandi';

  @override
  String get pricingRestorePurchases => 'Endurheimta kaup';

  @override
  String get pricingSubscriptionSuccess => 'Áskrift virkjuð!';

  @override
  String get pricingSubscriptionFailed => 'Mistókst að vinna áskrift.';

  @override
  String get pricingRestoreSuccess => 'Kaup endurheimt!';

  @override
  String get pricingRestoreFailed => 'Mistókst að endurheimta kaup.';

  @override
  String get onboardingTitle1 => 'KI-myndbönd á augabragði';

  @override
  String get onboardingDesc1 =>
      'Breyttu texta eða myndum í myndbönd á sekúndum.';

  @override
  String get onboardingTitle2 => 'Hugmyndir í myndband strax';

  @override
  String get onboardingDesc2 => 'Búðu til fagmyndbönd með einni kvaðningu.';

  @override
  String get onboardingTitle3 => 'Sköpun án takmarkana';

  @override
  String get onboardingDesc3 => 'Nýttu háþróaða KI til að lifga hugmyndirnar.';

  @override
  String get onboardingNext => 'Áfram';

  @override
  String get promptPreviewPrompt => 'Kvaðning';

  @override
  String get promptPreviewTryUsecase => 'Prófa þetta dæmi';

  @override
  String get promptPreviewFailedToLoad => 'Mistókst að hlaða miðli';

  @override
  String get promptPreviewGif => 'GIF';

  @override
  String get analyzeVideoTitle => 'Greina myndband';

  @override
  String get analyzeVideoAnalyzeImages => 'Greina myndir';

  @override
  String get analyzeVideoHelp => 'Hjálp';

  @override
  String get analyzeVideoHelpMessage => 'Leiðbeiningar eru á leiðinni.';

  @override
  String get analyzeVideoImportVideo => 'Flytja inn myndband';

  @override
  String get analyzeVideoUploadVideo => 'Hlaða upp myndbandi';

  @override
  String get analyzeVideoSupportedFormats => 'MP4, MOV, AVI | hámark 5 mín';

  @override
  String get analyzeVideoVideoPreview => 'Forskoðun';

  @override
  String get analyzeVideoAnalysisPanel => 'Greiningarspjald';

  @override
  String get analyzeVideoAnalyzeButton => 'Greina myndband';

  @override
  String get analyzeVideoAnalyzing => 'Greini...';

  @override
  String get analyzeVideoExtractingThumbnail => 'Bý til smámynd...';

  @override
  String get analyzeVideoUploadingThumbnail => 'Hleð upp smámynd...';

  @override
  String get analyzeVideoAiAnalyzing => 'KI greinir...';

  @override
  String analyzeVideoUploadProgress(Object progress) {
    return 'Upphleðsla: $progress%';
  }

  @override
  String get analyzeVideoGeneratedPrompts => 'KI-kvaðningar';

  @override
  String get analyzeVideoSelectPrompt => 'Veldu eða breyttu kvaðningu hér.';

  @override
  String analyzeVideoOption(Object number) {
    return 'Valkostur $number';
  }

  @override
  String get analyzeVideoPromptPanel => 'Kvaðningaspjald';

  @override
  String get analyzeVideoEnterPrompt => 'Sláðu inn kvaðningu...';

  @override
  String get analyzeVideoSeed => 'Fræ';

  @override
  String get analyzeVideoCopy => 'Afrita';

  @override
  String get analyzeVideoClear => 'Hreinsa';

  @override
  String get analyzeVideoError => 'Villa';

  @override
  String analyzeVideoFailedToSelect(Object error) {
    return 'Mistókst að velja myndband: $error';
  }

  @override
  String analyzeVideoFailedToLoad(Object error) {
    return 'Mistókst að hlaða myndbandi: $error';
  }

  @override
  String get analyzeVideoNoVideo => 'Ekkert myndband';

  @override
  String get analyzeVideoNoVideoMessage =>
      'Veldu myndband áður en þú heldur áfram.';

  @override
  String get analyzeVideoEmptyPrompt => 'Tóm kvaðning';

  @override
  String get analyzeVideoEmptyPromptMessage => 'Enginn texti til að afrita.';

  @override
  String get analyzeVideoCopied => 'Afritað';

  @override
  String get analyzeVideoCopiedMessage => 'Kvaðning afrituð á klemmuspjald.';

  @override
  String get analyzeVideoSuccess => 'Tókst';

  @override
  String analyzeVideoSuccessMessage(Object count) {
    return 'Bjó til $count kvaðningar.';
  }

  @override
  String get analyzeVideoAnalysisFailed => 'Greining mistókst';

  @override
  String get langEnglish => 'English';

  @override
  String get langChinese => '简体中文';

  @override
  String get langGerman => 'Deutsch';

  @override
  String get langIcelandic => 'Íslenska';

  @override
  String get navHome => 'Heim';

  @override
  String get navStudio => 'Stúdíó';

  @override
  String get navAnalyze => 'Greina';

  @override
  String get navProfile => 'Prófíll';
}
