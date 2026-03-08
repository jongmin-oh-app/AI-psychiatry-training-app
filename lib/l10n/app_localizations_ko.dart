// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get navScenarios => '시나리오';

  @override
  String get navCounseling => '상담';

  @override
  String get navHistory => '훈련기록';

  @override
  String get navAnalytics => '분석';

  @override
  String get homeAppBarTitle => 'AI 상담 트레이닝';

  @override
  String get homeMyProgress => '나의 진행도';

  @override
  String homeProgressLabel(int completed, int total, String percent) {
    return '완료: $completed/$total 시나리오 ($percent%)';
  }

  @override
  String get homeSectionIncomplete => '연습할 시나리오';

  @override
  String get homeSectionCompleted => '완료한 시나리오';

  @override
  String get homeNoScenarios => '시나리오가 없습니다';

  @override
  String homeCount(int count) {
    return '$count개';
  }

  @override
  String homeError(String error) {
    return '오류가 발생했습니다\n$error';
  }

  @override
  String get languageToggleLabel => 'EN';

  @override
  String get settingsLanguage => '언어 설정';

  @override
  String get settingsKorean => '한국어';

  @override
  String get settingsEnglish => 'English';

  @override
  String get loading => '로딩 중...';

  @override
  String errorWithMessage(String error) {
    return '오류: $error';
  }

  @override
  String get confirm => '확인';

  @override
  String get cancel => '취소';

  @override
  String get continueLabel => '계속하기';

  @override
  String get exitLabel => '나가기';

  @override
  String get scenarioDetailTitle => '시나리오 정보';

  @override
  String get scenarioNotFound => '시나리오를 찾을 수 없습니다';

  @override
  String get scenarioBackground => '배경';

  @override
  String get scenarioLearningGoals => '학습 목표';

  @override
  String estimatedTimeMinutes(int minutes) {
    return '$minutes분';
  }

  @override
  String get riskLow => '위험도 낮음';

  @override
  String get riskMedium => '위험도 중간';

  @override
  String get riskHigh => '위험도 높음';

  @override
  String get difficultyBeginner => '초급';

  @override
  String get difficultyIntermediate => '중급';

  @override
  String get difficultyAdvanced => '고급';

  @override
  String get scenarioResume => '이어하기';

  @override
  String get scenarioStart => '훈련 시작';

  @override
  String get scenarioLabel => '시나리오';

  @override
  String get chatTitle => '채팅';

  @override
  String get chatNoSession => '세션이 없습니다';

  @override
  String get chatExitTooltip => '나가기';

  @override
  String get chatEndTooltip => '상담 종료하기';

  @override
  String get chatEmptyStateTitle => '첫 메시지를 보내보세요';

  @override
  String get chatEmptyStateSubtitle =>
      '학생과의 대화를 시작하세요.\n공감하며 이야기를 들어주는 것이 중요합니다.';

  @override
  String get chatInputHint => '메시지를 입력하세요...';

  @override
  String get chatExitDialogTitle => '상담 나가기';

  @override
  String get chatExitDialogContent => '상담에서 나가시겠습니까?\n나중에 상담 탭에서 이어할 수 있습니다.';

  @override
  String get chatEndBlockedTitle => '상담 종료 불가';

  @override
  String chatMinExchangeContent(int minimum, int current) {
    return '학생과 $minimum번 이상 대화를 나눈 후 상담을 종료할 수 있습니다. (현재 $current/$minimum회)';
  }

  @override
  String get chatEndDialogTitle => '대화 종료';

  @override
  String get chatEndDialogContent => '대화를 종료하시겠습니까?\n피드백을 받으실 수 있습니다.';

  @override
  String get chatEndConfirm => '종료하기';

  @override
  String chatErrorPrefix(String error) {
    return '오류: $error';
  }

  @override
  String get loadingOverlayMessage => 'AI가 상담 내용을 분석하고 있습니다...';

  @override
  String get loadingOverlaySubtitle => '피드백을 생성하는 중입니다';

  @override
  String get pleaseWait => '잠시만 기다려주세요';

  @override
  String get feedbackTitle => '피드백';

  @override
  String get feedbackNone => '피드백이 없습니다';

  @override
  String get feedbackCompleteTitle => '훈련 완료';

  @override
  String get feedbackEvaluationResults => '평가 결과';

  @override
  String get feedbackGoodPoints => '잘한 점';

  @override
  String get feedbackImprovements => '개선할 점';

  @override
  String get feedbackCongrats => '훈련 완료!';

  @override
  String get feedbackWellDone => '수고하셨습니다';

  @override
  String get feedbackViewHistory => '대화 내역 보기';

  @override
  String get historyTitle => '훈련 기록';

  @override
  String get historyEmpty => '훈련 기록이 없습니다';

  @override
  String get historyEmptyHint => '첫 훈련을 시작해보세요!';

  @override
  String messageCount(int count) {
    return '$count개 메시지';
  }

  @override
  String get counselingTitle => '진행 중 상담';

  @override
  String get counselingEmpty => '진행 중인 상담이 없습니다';

  @override
  String get counselingEmptyHint => '시나리오에서 새 상담을 시작해보세요!';

  @override
  String get counselingInProgress => '진행 중';

  @override
  String get counselingExitDialogTitle => '채팅방 나가기';

  @override
  String get counselingDeleteContent => '이 상담을 삭제하시겠습니까?\n대화 내용이 모두 사라집니다.';

  @override
  String get analyticsTitle => '분석 대시보드';

  @override
  String get analyticsEmpty => '완료된 훈련이 없습니다';

  @override
  String get analyticsEmptyHint => '훈련을 완료하면 분석 결과를 확인할 수 있습니다.';

  @override
  String get summaryTitle => '훈련 요약';

  @override
  String get summaryTotalSessions => '총 훈련';

  @override
  String get summaryAverageScore => '평균 점수';

  @override
  String get summaryImprovementRate => '개선율';

  @override
  String sessionCount(int count) {
    return '$count회';
  }

  @override
  String get categoryEmpathy => '공감 표현';

  @override
  String get categoryListening => '경청 능력';

  @override
  String get categoryQuestioning => '질문 기술';

  @override
  String get categorySolution => '해결 방안';

  @override
  String get chartTitle => '점수 추이';

  @override
  String get chartTabEmpathy => '공감 표현';

  @override
  String get chartTabListening => '경청 능력';

  @override
  String get chartTabQuestioning => '질문 기술';

  @override
  String get chartTabSolution => '해결 방안';

  @override
  String get chartNotEnoughData => '2회 이상 훈련을 완료하면 추이 그래프가 표시됩니다.';

  @override
  String chartSessionNumber(int number) {
    return '$number회';
  }

  @override
  String get weaknessTitle => '취약점 분석';

  @override
  String get weaknessAllGood => '모든 항목에서 우수한 성과를 보이고 있습니다!';

  @override
  String get weaknessHint => '4.0 미만인 항목을 개선해보세요';

  @override
  String get weaknessEmpathy => '내담자의 감정을 반영하는 표현을 더 자주 사용해보세요.';

  @override
  String get weaknessListening => '내담자의 말을 요약하고 확인하는 연습을 해보세요.';

  @override
  String get weaknessQuestioning => '개방형 질문을 활용하여 내담자의 이야기를 이끌어보세요.';

  @override
  String get weaknessSolution => '내담자 스스로 해결책을 찾도록 안내하는 연습을 해보세요.';

  @override
  String get startLabel => '시작하기';

  @override
  String get completedLabel => '완료';

  @override
  String get retryLabel => '다시 연습';

  @override
  String get conversationHistoryTitle => '대화 내역';
}
