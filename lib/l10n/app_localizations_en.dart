// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get navScenarios => 'Scenarios';

  @override
  String get navCounseling => 'Counseling';

  @override
  String get navHistory => 'History';

  @override
  String get navAnalytics => 'Analytics';

  @override
  String get homeAppBarTitle => 'AI Counseling Training';

  @override
  String get homeMyProgress => 'My Progress';

  @override
  String homeProgressLabel(int completed, int total, String percent) {
    return 'Completed: $completed/$total scenarios ($percent%)';
  }

  @override
  String get homeSectionIncomplete => 'Scenarios to Practice';

  @override
  String get homeSectionCompleted => 'Completed Scenarios';

  @override
  String get homeNoScenarios => 'No scenarios available';

  @override
  String homeCount(int count) {
    return '$count';
  }

  @override
  String homeError(String error) {
    return 'An error occurred\n$error';
  }

  @override
  String get languageToggleLabel => 'KO';

  @override
  String get loading => 'Loading...';

  @override
  String errorWithMessage(String error) {
    return 'Error: $error';
  }

  @override
  String get confirm => 'OK';

  @override
  String get cancel => 'Cancel';

  @override
  String get continueLabel => 'Continue';

  @override
  String get exitLabel => 'Exit';

  @override
  String get scenarioDetailTitle => 'Scenario Info';

  @override
  String get scenarioNotFound => 'Scenario not found';

  @override
  String get scenarioBackground => 'Background';

  @override
  String get scenarioLearningGoals => 'Learning Goals';

  @override
  String estimatedTimeMinutes(int minutes) {
    return '$minutes min';
  }

  @override
  String get riskLow => 'Low Risk';

  @override
  String get riskMedium => 'Medium Risk';

  @override
  String get riskHigh => 'High Risk';

  @override
  String get difficultyBeginner => 'Beginner';

  @override
  String get difficultyIntermediate => 'Intermediate';

  @override
  String get difficultyAdvanced => 'Advanced';

  @override
  String get scenarioResume => 'Resume';

  @override
  String get scenarioStart => 'Start Training';

  @override
  String get scenarioLabel => 'Scenario';

  @override
  String get chatTitle => 'Chat';

  @override
  String get chatNoSession => 'No session';

  @override
  String get chatExitTooltip => 'Exit';

  @override
  String get chatEndTooltip => 'End Session';

  @override
  String get chatEmptyStateTitle => 'Send your first message';

  @override
  String get chatEmptyStateSubtitle =>
      'Start a conversation with the student.\nListening with empathy is key.';

  @override
  String get chatInputHint => 'Type a message...';

  @override
  String get chatExitDialogTitle => 'Exit Session';

  @override
  String get chatExitDialogContent =>
      'Are you sure you want to exit?\nYou can resume later from the Counseling tab.';

  @override
  String get chatEndBlockedTitle => 'Cannot End Session';

  @override
  String chatMinExchangeContent(int minimum, int current) {
    return 'You need at least $minimum exchanges before ending. (Current: $current/$minimum)';
  }

  @override
  String get chatEndDialogTitle => 'End Session';

  @override
  String get chatEndDialogContent =>
      'Are you sure you want to end the session?\nYou will receive feedback.';

  @override
  String get chatEndConfirm => 'End';

  @override
  String chatErrorPrefix(String error) {
    return 'Error: $error';
  }

  @override
  String get loadingOverlayMessage => 'AI is analyzing the session...';

  @override
  String get loadingOverlaySubtitle => 'Generating feedback';

  @override
  String get pleaseWait => 'Please wait';

  @override
  String get feedbackTitle => 'Feedback';

  @override
  String get feedbackNone => 'No feedback available';

  @override
  String get feedbackCompleteTitle => 'Training Complete';

  @override
  String get feedbackEvaluationResults => 'Evaluation Results';

  @override
  String get feedbackGoodPoints => 'Strengths';

  @override
  String get feedbackImprovements => 'Areas for Improvement';

  @override
  String get feedbackCongrats => 'Training Complete!';

  @override
  String get feedbackWellDone => 'Well done!';

  @override
  String get feedbackViewHistory => 'View Conversation';

  @override
  String get historyTitle => 'Training History';

  @override
  String get historyEmpty => 'No training history';

  @override
  String get historyEmptyHint => 'Start your first training session!';

  @override
  String messageCount(int count) {
    return '$count messages';
  }

  @override
  String get counselingTitle => 'Active Sessions';

  @override
  String get counselingEmpty => 'No active sessions';

  @override
  String get counselingEmptyHint =>
      'Start a new session from the Scenarios tab!';

  @override
  String get counselingInProgress => 'In Progress';

  @override
  String get counselingExitDialogTitle => 'Leave Session';

  @override
  String get counselingDeleteContent =>
      'Delete this session?\nAll conversation data will be lost.';

  @override
  String get analyticsTitle => 'Analytics Dashboard';

  @override
  String get analyticsEmpty => 'No completed training yet';

  @override
  String get analyticsEmptyHint =>
      'Complete a training session to see analytics.';

  @override
  String get summaryTitle => 'Training Summary';

  @override
  String get summaryTotalSessions => 'Total Sessions';

  @override
  String get summaryAverageScore => 'Avg Score';

  @override
  String get summaryImprovementRate => 'Improvement';

  @override
  String sessionCount(int count) {
    return '$count';
  }

  @override
  String get categoryEmpathy => 'Empathy';

  @override
  String get categoryListening => 'Listening';

  @override
  String get categoryQuestioning => 'Questioning';

  @override
  String get categorySolution => 'Solution';

  @override
  String get chartTitle => 'Score Trends';

  @override
  String get chartTabEmpathy => 'Empathy';

  @override
  String get chartTabListening => 'Listening';

  @override
  String get chartTabQuestioning => 'Questioning';

  @override
  String get chartTabSolution => 'Solution';

  @override
  String get chartNotEnoughData =>
      'Complete 2+ sessions to see the trend chart.';

  @override
  String chartSessionNumber(int number) {
    return '#$number';
  }

  @override
  String get weaknessTitle => 'Weakness Analysis';

  @override
  String get weaknessAllGood => 'You\'re performing well in all areas!';

  @override
  String get weaknessHint => 'Work on areas scoring below 4.0';

  @override
  String get weaknessEmpathy =>
      'Try using more empathetic reflections when responding to the client.';

  @override
  String get weaknessListening =>
      'Practice summarizing and confirming what the client says.';

  @override
  String get weaknessQuestioning =>
      'Use open-ended questions to draw out the client\'s story.';

  @override
  String get weaknessSolution =>
      'Guide the client to discover solutions on their own.';

  @override
  String get startLabel => 'Start';

  @override
  String get completedLabel => 'Done';

  @override
  String get retryLabel => 'Practice Again';

  @override
  String get conversationHistoryTitle => 'Conversation History';
}
