// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get commonCancel => 'Abbrechen';

  @override
  String get commonConfirm => 'Bestätigen';

  @override
  String get commonSave => 'Speichern';

  @override
  String get commonDelete => 'Löschen';

  @override
  String get commonRetry => 'Nochmal';

  @override
  String get commonLoading => 'Lädt...';

  @override
  String get commonError => 'Fehler';

  @override
  String get commonSuccess => 'Erfolg';

  @override
  String get commonClose => 'Schließen';

  @override
  String get settingsTitle => 'Einstellungen';

  @override
  String get settingsLanguage => 'Sprache';

  @override
  String get settingsTermsOfUse => 'Nutzungsbedingungen';

  @override
  String get settingsPrivacy => 'Datenschutz';

  @override
  String get settingsHelpSupport => 'Hilfe & Support';

  @override
  String get settingsSelectLanguage => 'Sprache wählen';

  @override
  String get profileTitle => 'Profil';

  @override
  String get profileHelloCreator => 'Hallo Creator';

  @override
  String get profileMyVideos => 'Meine Videos';

  @override
  String get profileNoVideos => 'Noch keine Videos';

  @override
  String get profileCreateFirst => 'Starte dein erstes Video über Home';

  @override
  String get homeCreate => 'Erstellen';

  @override
  String get homeTextToVideo => 'Text zu Video';

  @override
  String get homeImageToVideo => 'Bild zu Video';

  @override
  String homeGenerate(String credit) {
    return 'Generieren ($credit Credits)';
  }

  @override
  String get homeGenerateUnlimited => 'Generieren (unbegrenzt)';

  @override
  String get homeGetPro => 'Pro holen';

  @override
  String get homePro => 'Pro';

  @override
  String get homeStyles => 'Stile';

  @override
  String get homeInspireMe => 'Inspiration';

  @override
  String get homeUploadImage => 'Bild hochladen';

  @override
  String get homeImageReady => 'Bild bereit';

  @override
  String get homeUploading => 'Hochladen...';

  @override
  String get homeEnterPrompt => 'Prompt hier eingeben...';

  @override
  String get homeAnimateImage => 'Beschreibe die Animation...';

  @override
  String get homeTryPrompts => 'Prompts testen';

  @override
  String get homeStartingGeneration => 'Generierung startet...';

  @override
  String get homeGeneratingVideo => 'Video wird erstellt...';

  @override
  String get homeViewVideo => 'Video ansehen';

  @override
  String get msgNoCredits => 'Keine Credits';

  @override
  String get msgNoCreditsDesc =>
      'Keine Credits mehr. Hol dir Pro für unbegrenzte Videos!';

  @override
  String get msgEmptyPrompt => 'Leerer Prompt';

  @override
  String get msgEmptyPromptDesc =>
      'Bitte gib einen Prompt ein, um ein Video zu generieren.';

  @override
  String get msgImageUploading => 'Bild wird hochgeladen';

  @override
  String get msgImageUploadingDesc => 'Bitte warte, bis der Upload fertig ist.';

  @override
  String get msgNoImageUploaded => 'Kein Bild';

  @override
  String get msgNoImageUploadedDesc =>
      'Bitte lade ein Bild für Bild-zu-Video hoch.';

  @override
  String get msgUploadComplete => 'Upload fertig';

  @override
  String get msgUploadCompleteDesc => 'Bild geladen – bereit zum Generieren.';

  @override
  String get msgUploadFailed => 'Upload fehlgeschlagen';

  @override
  String msgUploadFailedDesc(String error) {
    return 'Fehler beim Bild-Upload: $error';
  }

  @override
  String get msgStyleApplied => 'Stil aktiv';

  @override
  String msgStyleAppliedDesc(String style) {
    return '$style Stil ausgewählt.';
  }

  @override
  String get msgInspirationReady => 'Inspiration fertig';

  @override
  String get msgInspirationReadyDesc =>
      'Die KI hat einen besseren Prompt erstellt.';

  @override
  String get msgInspirationFailed => 'Inspiration fehlgeschlagen';

  @override
  String msgInspirationFailedDesc(String error) {
    return 'Prompt konnte nicht geladen werden: $error';
  }

  @override
  String get msgCreditRefunded => 'Credit zurück';

  @override
  String get msgCreditRefundedDesc =>
      'Dein Credit wurde wegen des Fehlers gutgeschrieben.';

  @override
  String get msgLanguageChanged => 'Sprache geändert';

  @override
  String get msgLanguageChangedDesc => 'App-Sprache aktualisiert.';

  @override
  String get msgCouldNotOpenLink => 'Link konnte nicht geöffnet werden';

  @override
  String msgFailedToOpenLink(String error) {
    return 'Fehler beim Öffnen: $error';
  }

  @override
  String get msgVideoFailed => 'Video fehlgeschlagen';

  @override
  String get msgVideoFailedDesc => 'Dieses Video konnte nicht erstellt werden.';

  @override
  String get msgVideoProcessing => 'Video wird verarbeitet';

  @override
  String get msgVideoProcessingDesc => 'Video rendert noch.';

  @override
  String msgLoadVideosFailed(String error) {
    return 'Videos konnten nicht geladen werden: $error';
  }

  @override
  String get timeJustNow => 'Gerade eben';

  @override
  String get timeMinuteAgo => 'vor 1 Minute';

  @override
  String timeMinutesAgo(String count) {
    return 'vor $count Minuten';
  }

  @override
  String get timeHourAgo => 'vor 1 Stunde';

  @override
  String timeHoursAgo(String count) {
    return 'vor $count Stunden';
  }

  @override
  String get timeDayAgo => 'vor 1 Tag';

  @override
  String timeDaysAgo(String count) {
    return 'vor $count Tagen';
  }

  @override
  String get timeMonthAgo => 'vor 1 Monat';

  @override
  String timeMonthsAgo(String count) {
    return 'vor $count Monaten';
  }

  @override
  String get timeYearAgo => 'vor 1 Jahr';

  @override
  String timeYearsAgo(String count) {
    return 'vor $count Jahren';
  }

  @override
  String get videoResultTitle => 'Ergebnis';

  @override
  String get videoLoadingVideo => 'Video wird geladen...';

  @override
  String get videoFailedToLoad => 'Video konnte nicht geladen werden';

  @override
  String videoFailedToLoadDesc(String error) {
    return 'Fehler beim Laden: $error';
  }

  @override
  String get videoPlayerNotAvailable => 'Player nicht verfügbar';

  @override
  String get videoShare => 'Teilen';

  @override
  String get videoDownload => 'Download';

  @override
  String get videoRegenerate => 'Neu generieren';

  @override
  String get videoCopy => 'Kopieren';

  @override
  String get videoCopied => 'Kopiert';

  @override
  String get videoCopiedDesc => 'Titel in die Zwischenablage kopiert.';

  @override
  String videoShareMessage(String url) {
    return 'Schau dir dieses KI-Video an: $url';
  }

  @override
  String get videoShareSubject => 'KI-Video von Sova';

  @override
  String get videoShareFailed =>
      'Video konnte nicht geteilt werden. Bitte erneut versuchen.';

  @override
  String get videoDownloadFailed =>
      'Video konnte nicht heruntergeladen werden. Bitte erneut versuchen.';

  @override
  String get videoRegenerating => 'Neu generieren';

  @override
  String get videoRegeneratingDesc =>
      'Bitte gib einen neuen Prompt ein, um ein weiteres Video zu generieren.';

  @override
  String get pricingTitle => 'Mehr Möglichkeiten freischalten';

  @override
  String get pricingSubtitle => 'Erstelle beeindruckende KI-Videos';

  @override
  String get pricingUnlimitedGeneration => 'Unbegrenzte Videos';

  @override
  String get pricingNoWatermarks => 'Keine Wasserzeichen';

  @override
  String get pricingPriorityProcessing => 'Priorisierte Verarbeitung';

  @override
  String get pricingWeekly => 'Wöchentlich';

  @override
  String get pricingWeeklyPrice => '\$7.99/Woche';

  @override
  String get pricingMonthly => 'Monatlich';

  @override
  String get pricingMonthlyPrice => '\$39.99/Monat';

  @override
  String get pricingBestValue => 'BESTER DEAL';

  @override
  String get pricingSubscribe => 'Abonnieren';

  @override
  String get pricingRestorePurchases => 'Käufe wiederherstellen';

  @override
  String get pricingSubscriptionSuccess => 'Abo aktiviert!';

  @override
  String get pricingSubscriptionFailed =>
      'Abo konnte nicht verarbeitet werden.';

  @override
  String get pricingRestoreSuccess => 'Käufe wiederhergestellt!';

  @override
  String get pricingRestoreFailed =>
      'Käufe konnten nicht wiederhergestellt werden.';

  @override
  String get onboardingTitle1 => 'KI-Videozauber';

  @override
  String get onboardingDesc1 =>
      'Verwandle Text oder Bilder in Sekunden in Videos.';

  @override
  String get onboardingTitle2 => 'Ideen sofort umsetzen';

  @override
  String get onboardingDesc2 =>
      'Erstelle Videos mit einem Prompt – ganz ohne Schnittwissen.';

  @override
  String get onboardingTitle3 => 'Kreativität ohne Limits';

  @override
  String get onboardingDesc3 =>
      'Nutze moderne KI, um deine Ideen zum Leben zu erwecken.';

  @override
  String get onboardingNext => 'Weiter';

  @override
  String get promptPreviewPrompt => 'Prompt';

  @override
  String get promptPreviewTryUsecase => 'Use Case testen';

  @override
  String get promptPreviewFailedToLoad => 'Medien konnten nicht geladen werden';

  @override
  String get promptPreviewGif => 'GIF';

  @override
  String get analyzeVideoTitle => 'Video analysieren';

  @override
  String get analyzeVideoAnalyzeImages => 'Bilder analysieren';

  @override
  String get analyzeVideoHelp => 'Hilfe';

  @override
  String get analyzeVideoHelpMessage => 'Hilfe zur Analyse folgt bald.';

  @override
  String get analyzeVideoImportVideo => 'Video importieren';

  @override
  String get analyzeVideoUploadVideo => 'Video hochladen';

  @override
  String get analyzeVideoSupportedFormats =>
      'Formate: MP4, MOV, AVI | max. 5 Min';

  @override
  String get analyzeVideoVideoPreview => 'Vorschau';

  @override
  String get analyzeVideoAnalysisPanel => 'Analysepanel';

  @override
  String get analyzeVideoAnalyzeButton => 'Video analysieren';

  @override
  String get analyzeVideoAnalyzing => 'Analysiere...';

  @override
  String get analyzeVideoExtractingThumbnail => 'Vorschaubild wird erstellt...';

  @override
  String get analyzeVideoUploadingThumbnail =>
      'Vorschaubild wird hochgeladen...';

  @override
  String get analyzeVideoAiAnalyzing => 'KI analysiert...';

  @override
  String analyzeVideoUploadProgress(Object progress) {
    return 'Upload: $progress%';
  }

  @override
  String get analyzeVideoGeneratedPrompts => 'KI-Prompts';

  @override
  String get analyzeVideoSelectPrompt => 'Prompt wählen oder unten anpassen';

  @override
  String analyzeVideoOption(Object number) {
    return 'Option $number';
  }

  @override
  String get analyzeVideoPromptPanel => 'Prompt-Panel';

  @override
  String get analyzeVideoEnterPrompt => 'Prompt eintippen...';

  @override
  String get analyzeVideoSeed => 'Seed';

  @override
  String get analyzeVideoCopy => 'Kopieren';

  @override
  String get analyzeVideoClear => 'Leeren';

  @override
  String get analyzeVideoError => 'Fehler';

  @override
  String analyzeVideoFailedToSelect(Object error) {
    return 'Video konnte nicht ausgewählt werden: $error';
  }

  @override
  String analyzeVideoFailedToLoad(Object error) {
    return 'Video konnte nicht geladen werden: $error';
  }

  @override
  String get analyzeVideoNoVideo => 'Kein Video';

  @override
  String get analyzeVideoNoVideoMessage => 'Bitte wähle zuerst ein Video aus.';

  @override
  String get analyzeVideoEmptyPrompt => 'Leerer Prompt';

  @override
  String get analyzeVideoEmptyPromptMessage => 'Kein Prompt zum Kopieren.';

  @override
  String get analyzeVideoCopied => 'Kopiert';

  @override
  String get analyzeVideoCopiedMessage =>
      'Prompt in die Zwischenablage kopiert.';

  @override
  String get analyzeVideoSuccess => 'Erfolg';

  @override
  String analyzeVideoSuccessMessage(Object count) {
    return '$count Prompt-Vorschläge erstellt.';
  }

  @override
  String get analyzeVideoAnalysisFailed => 'Analyse fehlgeschlagen';

  @override
  String get langEnglish => 'English';

  @override
  String get langChinese => '简体中文';

  @override
  String get langGerman => 'Deutsch';

  @override
  String get langIcelandic => 'Íslenska';

  @override
  String get navHome => 'Start';

  @override
  String get navStudio => 'Studio';

  @override
  String get navAnalyze => 'Analyse';

  @override
  String get navProfile => 'Profil';
}
