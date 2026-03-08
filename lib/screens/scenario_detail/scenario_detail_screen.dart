import 'package:flutter/material.dart';
import 'package:psychiatry_training/l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../models/scenario.dart';
import '../../providers/scenario_provider.dart';
import '../../providers/session_provider.dart';
import '../../core/constants/colors.dart';

class ScenarioDetailScreen extends ConsumerWidget {
  final String scenarioId;

  const ScenarioDetailScreen({
    super.key,
    required this.scenarioId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final scenarioAsync = ref.watch(scenarioByIdProvider(scenarioId));

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.scenarioDetailTitle),
      ),
      body: scenarioAsync.when(
        data: (scenario) {
          if (scenario == null) {
            return Center(
              child: Text(l10n.scenarioNotFound),
            );
          }

          return _buildContent(context, ref, scenario, l10n);
        },
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error, stack) => Center(
          child: Text(l10n.errorWithMessage(error.toString())),
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    WidgetRef ref,
    Scenario scenario,
    AppLocalizations l10n,
  ) {
    final activeSessions = ref.watch(activeSessionsProvider);
    final activeSession = activeSessions
        .where((s) => s.scenarioId == scenario.id)
        .toList();
    final hasActiveSession = activeSession.isNotEmpty;

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  scenario.title,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                const SizedBox(height: 8),
                _buildMetaInfo(context, scenario, l10n),
                const Divider(height: 32),
                Text(
                  l10n.scenarioBackground,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  scenario.background,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 24),
                Text(
                  l10n.scenarioLearningGoals,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 8),
                ...scenario.learningGoals.map(
                  (goal) => Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '• ',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        Expanded(
                          child: Text(
                            goal,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (hasActiveSession)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: OutlinedButton(
                      onPressed: () {
                        ref
                            .read(currentSessionProvider.notifier)
                            .resumeSession(activeSession.first);
                        context.push('/chat');
                      },
                      child: Text(l10n.scenarioResume),
                    ),
                  ),
                ElevatedButton(
                  onPressed: () {
                    ref
                        .read(currentSessionProvider.notifier)
                        .startSession(scenario.id, greeting: scenario.getRandomGreeting());
                    context.push('/chat');
                  },
                  child: Text(l10n.scenarioStart),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMetaInfo(
    BuildContext context,
    Scenario scenario,
    AppLocalizations l10n,
  ) {
    return Wrap(
      spacing: 16,
      runSpacing: 8,
      children: [
        _buildInfoChip(
          context,
          icon: Icons.category,
          label: scenario.category,
        ),
        _buildInfoChip(
          context,
          icon: Icons.access_time,
          label: l10n.estimatedTimeMinutes(scenario.estimatedTime),
        ),
        _buildInfoChip(
          context,
          icon: Icons.signal_cellular_alt,
          label: _getDifficultyText(l10n, scenario.difficulty),
          color: _getDifficultyColor(scenario.difficulty),
        ),
        if (scenario.riskLevel != null)
          _buildInfoChip(
            context,
            icon: Icons.warning_amber_rounded,
            label: _getRiskLevelText(l10n, scenario.riskLevel!),
            color: _getRiskLevelColor(scenario.riskLevel!),
          ),
      ],
    );
  }

  String _getRiskLevelText(AppLocalizations l10n, String riskLevel) {
    switch (riskLevel) {
      case 'low':
        return l10n.riskLow;
      case 'medium':
        return l10n.riskMedium;
      case 'high':
        return l10n.riskHigh;
      default:
        return riskLevel;
    }
  }

  Color _getRiskLevelColor(String riskLevel) {
    switch (riskLevel) {
      case 'low':
        return AppColors.success;
      case 'medium':
        return AppColors.warning;
      case 'high':
        return AppColors.error;
      default:
        return AppColors.info;
    }
  }

  Widget _buildInfoChip(
    BuildContext context, {
    required IconData icon,
    required String label,
    Color? color,
  }) {
    return Chip(
      avatar: Icon(
        icon,
        size: 16,
        color: color ?? AppColors.primaryBlue,
      ),
      label: Text(label),
      backgroundColor: (color ?? AppColors.primaryBlue).withOpacity(0.1),
    );
  }

  String _getDifficultyText(AppLocalizations l10n, String difficulty) {
    switch (difficulty) {
      case 'beginner':
        return l10n.difficultyBeginner;
      case 'intermediate':
        return l10n.difficultyIntermediate;
      case 'advanced':
        return l10n.difficultyAdvanced;
      default:
        return difficulty;
    }
  }

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty) {
      case 'beginner':
        return AppColors.success;
      case 'intermediate':
        return AppColors.warning;
      case 'advanced':
        return AppColors.error;
      default:
        return AppColors.info;
    }
  }
}
