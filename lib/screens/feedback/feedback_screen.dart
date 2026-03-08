import 'package:flutter/material.dart';
import 'package:psychiatry_training/l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../models/training_session.dart';
import '../../providers/session_provider.dart';
import '../../core/constants/colors.dart';


class FeedbackScreen extends ConsumerWidget {
  final TrainingSession session;

  const FeedbackScreen({
    super.key,
    required this.session,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final feedback = session.feedback;

    if (feedback == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text(l10n.feedbackTitle),
        ),
        body: Center(
          child: Text(l10n.feedbackNone),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.feedbackCompleteTitle),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            ref.read(currentSessionProvider.notifier).clearSession();
            context.go('/scenarios');
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(
          16,
          16,
          16,
          16 + MediaQuery.of(context).padding.bottom,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCongratulationsCard(context, l10n),
            const SizedBox(height: 24),
            Text(
              l10n.feedbackEvaluationResults,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),
            _buildScoresSection(context, l10n, feedback.scores),
            const SizedBox(height: 24),
            Text(
              l10n.feedbackGoodPoints,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            _buildFeedbackCard(
              context,
              feedback.goodPoints,
              AppColors.success,
            ),
            const SizedBox(height: 24),
            Text(
              l10n.feedbackImprovements,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            _buildFeedbackCard(
              context,
              feedback.improvements,
              AppColors.warning,
            ),
            if (session.messages.isNotEmpty) ...[
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () {
                    context.push('/conversation-history', extra: session.messages);
                  },
                  icon: const Icon(Icons.chat_outlined),
                  label: Text(l10n.feedbackViewHistory),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    side: const BorderSide(color: AppColors.primaryBlue),
                    foregroundColor: AppColors.primaryBlue,
                  ),
                ),
              ),
            ],
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildCongratulationsCard(BuildContext context, AppLocalizations l10n) {
    return Card(
      color: AppColors.primaryBlue.withOpacity(0.1),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            const Icon(
              Icons.celebration,
              size: 48,
              color: AppColors.primaryBlue,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.feedbackCongrats,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: AppColors.primaryBlue,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    l10n.feedbackWellDone,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScoresSection(
    BuildContext context,
    AppLocalizations l10n,
    Map<String, int> scores,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildScoreRow(context, l10n.categoryEmpathy, scores['empathy'] ?? 0),
            const Divider(),
            _buildScoreRow(context, l10n.categoryListening, scores['listening'] ?? 0),
            const Divider(),
            _buildScoreRow(context, l10n.categoryQuestioning, scores['questioning'] ?? 0),
            const Divider(),
            _buildScoreRow(context, l10n.categorySolution, scores['solution'] ?? 0),
          ],
        ),
      ),
    );
  }

  Widget _buildScoreRow(BuildContext context, String label, int score) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          Row(
            children: List.generate(5, (index) {
              return Icon(
                index < score ? Icons.star : Icons.star_border,
                color: AppColors.warning,
                size: 24,
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildFeedbackCard(BuildContext context, String content, Color accentColor) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border(
            left: BorderSide(
              color: accentColor,
              width: 4,
            ),
          ),
        ),
        child: Text(
          content,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
    );
  }
}
