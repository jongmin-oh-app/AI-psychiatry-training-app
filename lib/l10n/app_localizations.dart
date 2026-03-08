import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ko.dart';

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
    Locale('en'),
    Locale('ko'),
  ];

  /// No description provided for @navScenarios.
  ///
  /// In ko, this message translates to:
  /// **'시나리오'**
  String get navScenarios;

  /// No description provided for @navCounseling.
  ///
  /// In ko, this message translates to:
  /// **'상담'**
  String get navCounseling;

  /// No description provided for @navHistory.
  ///
  /// In ko, this message translates to:
  /// **'훈련기록'**
  String get navHistory;

  /// No description provided for @navAnalytics.
  ///
  /// In ko, this message translates to:
  /// **'분석'**
  String get navAnalytics;

  /// No description provided for @homeAppBarTitle.
  ///
  /// In ko, this message translates to:
  /// **'AI 상담 트레이닝'**
  String get homeAppBarTitle;

  /// No description provided for @homeMyProgress.
  ///
  /// In ko, this message translates to:
  /// **'나의 진행도'**
  String get homeMyProgress;

  /// No description provided for @homeProgressLabel.
  ///
  /// In ko, this message translates to:
  /// **'완료: {completed}/{total} 시나리오 ({percent}%)'**
  String homeProgressLabel(int completed, int total, String percent);

  /// No description provided for @homeSectionIncomplete.
  ///
  /// In ko, this message translates to:
  /// **'연습할 시나리오'**
  String get homeSectionIncomplete;

  /// No description provided for @homeSectionCompleted.
  ///
  /// In ko, this message translates to:
  /// **'완료한 시나리오'**
  String get homeSectionCompleted;

  /// No description provided for @homeNoScenarios.
  ///
  /// In ko, this message translates to:
  /// **'시나리오가 없습니다'**
  String get homeNoScenarios;

  /// No description provided for @homeCount.
  ///
  /// In ko, this message translates to:
  /// **'{count}개'**
  String homeCount(int count);

  /// No description provided for @homeError.
  ///
  /// In ko, this message translates to:
  /// **'오류가 발생했습니다\n{error}'**
  String homeError(String error);

  /// No description provided for @languageToggleLabel.
  ///
  /// In ko, this message translates to:
  /// **'EN'**
  String get languageToggleLabel;

  /// No description provided for @loading.
  ///
  /// In ko, this message translates to:
  /// **'로딩 중...'**
  String get loading;

  /// No description provided for @errorWithMessage.
  ///
  /// In ko, this message translates to:
  /// **'오류: {error}'**
  String errorWithMessage(String error);

  /// No description provided for @confirm.
  ///
  /// In ko, this message translates to:
  /// **'확인'**
  String get confirm;

  /// No description provided for @cancel.
  ///
  /// In ko, this message translates to:
  /// **'취소'**
  String get cancel;

  /// No description provided for @continueLabel.
  ///
  /// In ko, this message translates to:
  /// **'계속하기'**
  String get continueLabel;

  /// No description provided for @exitLabel.
  ///
  /// In ko, this message translates to:
  /// **'나가기'**
  String get exitLabel;

  /// No description provided for @scenarioDetailTitle.
  ///
  /// In ko, this message translates to:
  /// **'시나리오 정보'**
  String get scenarioDetailTitle;

  /// No description provided for @scenarioNotFound.
  ///
  /// In ko, this message translates to:
  /// **'시나리오를 찾을 수 없습니다'**
  String get scenarioNotFound;

  /// No description provided for @scenarioBackground.
  ///
  /// In ko, this message translates to:
  /// **'배경'**
  String get scenarioBackground;

  /// No description provided for @scenarioLearningGoals.
  ///
  /// In ko, this message translates to:
  /// **'학습 목표'**
  String get scenarioLearningGoals;

  /// No description provided for @estimatedTimeMinutes.
  ///
  /// In ko, this message translates to:
  /// **'{minutes}분'**
  String estimatedTimeMinutes(int minutes);

  /// No description provided for @riskLow.
  ///
  /// In ko, this message translates to:
  /// **'위험도 낮음'**
  String get riskLow;

  /// No description provided for @riskMedium.
  ///
  /// In ko, this message translates to:
  /// **'위험도 중간'**
  String get riskMedium;

  /// No description provided for @riskHigh.
  ///
  /// In ko, this message translates to:
  /// **'위험도 높음'**
  String get riskHigh;

  /// No description provided for @difficultyBeginner.
  ///
  /// In ko, this message translates to:
  /// **'초급'**
  String get difficultyBeginner;

  /// No description provided for @difficultyIntermediate.
  ///
  /// In ko, this message translates to:
  /// **'중급'**
  String get difficultyIntermediate;

  /// No description provided for @difficultyAdvanced.
  ///
  /// In ko, this message translates to:
  /// **'고급'**
  String get difficultyAdvanced;

  /// No description provided for @scenarioResume.
  ///
  /// In ko, this message translates to:
  /// **'이어하기'**
  String get scenarioResume;

  /// No description provided for @scenarioStart.
  ///
  /// In ko, this message translates to:
  /// **'훈련 시작'**
  String get scenarioStart;

  /// No description provided for @scenarioLabel.
  ///
  /// In ko, this message translates to:
  /// **'시나리오'**
  String get scenarioLabel;

  /// No description provided for @chatTitle.
  ///
  /// In ko, this message translates to:
  /// **'채팅'**
  String get chatTitle;

  /// No description provided for @chatNoSession.
  ///
  /// In ko, this message translates to:
  /// **'세션이 없습니다'**
  String get chatNoSession;

  /// No description provided for @chatExitTooltip.
  ///
  /// In ko, this message translates to:
  /// **'나가기'**
  String get chatExitTooltip;

  /// No description provided for @chatEndTooltip.
  ///
  /// In ko, this message translates to:
  /// **'상담 종료하기'**
  String get chatEndTooltip;

  /// No description provided for @chatEmptyStateTitle.
  ///
  /// In ko, this message translates to:
  /// **'첫 메시지를 보내보세요'**
  String get chatEmptyStateTitle;

  /// No description provided for @chatEmptyStateSubtitle.
  ///
  /// In ko, this message translates to:
  /// **'학생과의 대화를 시작하세요.\n공감하며 이야기를 들어주는 것이 중요합니다.'**
  String get chatEmptyStateSubtitle;

  /// No description provided for @chatInputHint.
  ///
  /// In ko, this message translates to:
  /// **'메시지를 입력하세요...'**
  String get chatInputHint;

  /// No description provided for @chatExitDialogTitle.
  ///
  /// In ko, this message translates to:
  /// **'상담 나가기'**
  String get chatExitDialogTitle;

  /// No description provided for @chatExitDialogContent.
  ///
  /// In ko, this message translates to:
  /// **'상담에서 나가시겠습니까?\n나중에 상담 탭에서 이어할 수 있습니다.'**
  String get chatExitDialogContent;

  /// No description provided for @chatEndBlockedTitle.
  ///
  /// In ko, this message translates to:
  /// **'상담 종료 불가'**
  String get chatEndBlockedTitle;

  /// No description provided for @chatMinExchangeContent.
  ///
  /// In ko, this message translates to:
  /// **'학생과 {minimum}번 이상 대화를 나눈 후 상담을 종료할 수 있습니다. (현재 {current}/{minimum}회)'**
  String chatMinExchangeContent(int minimum, int current);

  /// No description provided for @chatEndDialogTitle.
  ///
  /// In ko, this message translates to:
  /// **'대화 종료'**
  String get chatEndDialogTitle;

  /// No description provided for @chatEndDialogContent.
  ///
  /// In ko, this message translates to:
  /// **'대화를 종료하시겠습니까?\n피드백을 받으실 수 있습니다.'**
  String get chatEndDialogContent;

  /// No description provided for @chatEndConfirm.
  ///
  /// In ko, this message translates to:
  /// **'종료하기'**
  String get chatEndConfirm;

  /// No description provided for @chatErrorPrefix.
  ///
  /// In ko, this message translates to:
  /// **'오류: {error}'**
  String chatErrorPrefix(String error);

  /// No description provided for @loadingOverlayMessage.
  ///
  /// In ko, this message translates to:
  /// **'AI가 상담 내용을 분석하고 있습니다...'**
  String get loadingOverlayMessage;

  /// No description provided for @loadingOverlaySubtitle.
  ///
  /// In ko, this message translates to:
  /// **'피드백을 생성하는 중입니다'**
  String get loadingOverlaySubtitle;

  /// No description provided for @pleaseWait.
  ///
  /// In ko, this message translates to:
  /// **'잠시만 기다려주세요'**
  String get pleaseWait;

  /// No description provided for @feedbackTitle.
  ///
  /// In ko, this message translates to:
  /// **'피드백'**
  String get feedbackTitle;

  /// No description provided for @feedbackNone.
  ///
  /// In ko, this message translates to:
  /// **'피드백이 없습니다'**
  String get feedbackNone;

  /// No description provided for @feedbackCompleteTitle.
  ///
  /// In ko, this message translates to:
  /// **'훈련 완료'**
  String get feedbackCompleteTitle;

  /// No description provided for @feedbackEvaluationResults.
  ///
  /// In ko, this message translates to:
  /// **'평가 결과'**
  String get feedbackEvaluationResults;

  /// No description provided for @feedbackGoodPoints.
  ///
  /// In ko, this message translates to:
  /// **'잘한 점'**
  String get feedbackGoodPoints;

  /// No description provided for @feedbackImprovements.
  ///
  /// In ko, this message translates to:
  /// **'개선할 점'**
  String get feedbackImprovements;

  /// No description provided for @feedbackCongrats.
  ///
  /// In ko, this message translates to:
  /// **'훈련 완료!'**
  String get feedbackCongrats;

  /// No description provided for @feedbackWellDone.
  ///
  /// In ko, this message translates to:
  /// **'수고하셨습니다'**
  String get feedbackWellDone;

  /// No description provided for @feedbackViewHistory.
  ///
  /// In ko, this message translates to:
  /// **'대화 내역 보기'**
  String get feedbackViewHistory;

  /// No description provided for @historyTitle.
  ///
  /// In ko, this message translates to:
  /// **'훈련 기록'**
  String get historyTitle;

  /// No description provided for @historyEmpty.
  ///
  /// In ko, this message translates to:
  /// **'훈련 기록이 없습니다'**
  String get historyEmpty;

  /// No description provided for @historyEmptyHint.
  ///
  /// In ko, this message translates to:
  /// **'첫 훈련을 시작해보세요!'**
  String get historyEmptyHint;

  /// No description provided for @messageCount.
  ///
  /// In ko, this message translates to:
  /// **'{count}개 메시지'**
  String messageCount(int count);

  /// No description provided for @counselingTitle.
  ///
  /// In ko, this message translates to:
  /// **'진행 중 상담'**
  String get counselingTitle;

  /// No description provided for @counselingEmpty.
  ///
  /// In ko, this message translates to:
  /// **'진행 중인 상담이 없습니다'**
  String get counselingEmpty;

  /// No description provided for @counselingEmptyHint.
  ///
  /// In ko, this message translates to:
  /// **'시나리오에서 새 상담을 시작해보세요!'**
  String get counselingEmptyHint;

  /// No description provided for @counselingInProgress.
  ///
  /// In ko, this message translates to:
  /// **'진행 중'**
  String get counselingInProgress;

  /// No description provided for @counselingExitDialogTitle.
  ///
  /// In ko, this message translates to:
  /// **'채팅방 나가기'**
  String get counselingExitDialogTitle;

  /// No description provided for @counselingDeleteContent.
  ///
  /// In ko, this message translates to:
  /// **'이 상담을 삭제하시겠습니까?\n대화 내용이 모두 사라집니다.'**
  String get counselingDeleteContent;

  /// No description provided for @analyticsTitle.
  ///
  /// In ko, this message translates to:
  /// **'분석 대시보드'**
  String get analyticsTitle;

  /// No description provided for @analyticsEmpty.
  ///
  /// In ko, this message translates to:
  /// **'완료된 훈련이 없습니다'**
  String get analyticsEmpty;

  /// No description provided for @analyticsEmptyHint.
  ///
  /// In ko, this message translates to:
  /// **'훈련을 완료하면 분석 결과를 확인할 수 있습니다.'**
  String get analyticsEmptyHint;

  /// No description provided for @summaryTitle.
  ///
  /// In ko, this message translates to:
  /// **'훈련 요약'**
  String get summaryTitle;

  /// No description provided for @summaryTotalSessions.
  ///
  /// In ko, this message translates to:
  /// **'총 훈련'**
  String get summaryTotalSessions;

  /// No description provided for @summaryAverageScore.
  ///
  /// In ko, this message translates to:
  /// **'평균 점수'**
  String get summaryAverageScore;

  /// No description provided for @summaryImprovementRate.
  ///
  /// In ko, this message translates to:
  /// **'개선율'**
  String get summaryImprovementRate;

  /// No description provided for @sessionCount.
  ///
  /// In ko, this message translates to:
  /// **'{count}회'**
  String sessionCount(int count);

  /// No description provided for @categoryEmpathy.
  ///
  /// In ko, this message translates to:
  /// **'공감 표현'**
  String get categoryEmpathy;

  /// No description provided for @categoryListening.
  ///
  /// In ko, this message translates to:
  /// **'경청 능력'**
  String get categoryListening;

  /// No description provided for @categoryQuestioning.
  ///
  /// In ko, this message translates to:
  /// **'질문 기술'**
  String get categoryQuestioning;

  /// No description provided for @categorySolution.
  ///
  /// In ko, this message translates to:
  /// **'해결 방안'**
  String get categorySolution;

  /// No description provided for @chartTitle.
  ///
  /// In ko, this message translates to:
  /// **'점수 추이'**
  String get chartTitle;

  /// No description provided for @chartTabEmpathy.
  ///
  /// In ko, this message translates to:
  /// **'공감 표현'**
  String get chartTabEmpathy;

  /// No description provided for @chartTabListening.
  ///
  /// In ko, this message translates to:
  /// **'경청 능력'**
  String get chartTabListening;

  /// No description provided for @chartTabQuestioning.
  ///
  /// In ko, this message translates to:
  /// **'질문 기술'**
  String get chartTabQuestioning;

  /// No description provided for @chartTabSolution.
  ///
  /// In ko, this message translates to:
  /// **'해결 방안'**
  String get chartTabSolution;

  /// No description provided for @chartNotEnoughData.
  ///
  /// In ko, this message translates to:
  /// **'2회 이상 훈련을 완료하면 추이 그래프가 표시됩니다.'**
  String get chartNotEnoughData;

  /// No description provided for @chartSessionNumber.
  ///
  /// In ko, this message translates to:
  /// **'{number}회'**
  String chartSessionNumber(int number);

  /// No description provided for @weaknessTitle.
  ///
  /// In ko, this message translates to:
  /// **'취약점 분석'**
  String get weaknessTitle;

  /// No description provided for @weaknessAllGood.
  ///
  /// In ko, this message translates to:
  /// **'모든 항목에서 우수한 성과를 보이고 있습니다!'**
  String get weaknessAllGood;

  /// No description provided for @weaknessHint.
  ///
  /// In ko, this message translates to:
  /// **'4.0 미만인 항목을 개선해보세요'**
  String get weaknessHint;

  /// No description provided for @weaknessEmpathy.
  ///
  /// In ko, this message translates to:
  /// **'내담자의 감정을 반영하는 표현을 더 자주 사용해보세요.'**
  String get weaknessEmpathy;

  /// No description provided for @weaknessListening.
  ///
  /// In ko, this message translates to:
  /// **'내담자의 말을 요약하고 확인하는 연습을 해보세요.'**
  String get weaknessListening;

  /// No description provided for @weaknessQuestioning.
  ///
  /// In ko, this message translates to:
  /// **'개방형 질문을 활용하여 내담자의 이야기를 이끌어보세요.'**
  String get weaknessQuestioning;

  /// No description provided for @weaknessSolution.
  ///
  /// In ko, this message translates to:
  /// **'내담자 스스로 해결책을 찾도록 안내하는 연습을 해보세요.'**
  String get weaknessSolution;

  /// No description provided for @startLabel.
  ///
  /// In ko, this message translates to:
  /// **'시작하기'**
  String get startLabel;

  /// No description provided for @completedLabel.
  ///
  /// In ko, this message translates to:
  /// **'완료'**
  String get completedLabel;

  /// No description provided for @retryLabel.
  ///
  /// In ko, this message translates to:
  /// **'다시 연습'**
  String get retryLabel;

  /// No description provided for @conversationHistoryTitle.
  ///
  /// In ko, this message translates to:
  /// **'대화 내역'**
  String get conversationHistoryTitle;
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
      <String>['en', 'ko'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'ko':
      return AppLocalizationsKo();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
