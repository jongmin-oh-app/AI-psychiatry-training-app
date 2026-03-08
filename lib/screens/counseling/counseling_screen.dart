import 'package:flutter/material.dart';
import 'package:psychiatry_training/l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../providers/session_provider.dart';
import '../../providers/scenario_provider.dart';
import '../../models/training_session.dart';
import '../../core/constants/colors.dart';

class CounselingScreen extends ConsumerWidget {
  const CounselingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final sessions = ref.watch(activeSessionsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.counselingTitle),
      ),
      body: sessions.isEmpty
          ? _buildEmptyState(context, l10n)
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: sessions.length,
              itemBuilder: (context, index) {
                final session = sessions[index];
                return _buildSessionCard(context, ref, session, l10n);
              },
            ),
    );
  }

  Widget _buildEmptyState(BuildContext context, AppLocalizations l10n) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.chat_bubble_outline,
            size: 64,
            color: AppColors.secondaryText.withOpacity(0.5),
          ),
          const SizedBox(height: 16),
          Text(
            l10n.counselingEmpty,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppColors.secondaryText,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            l10n.counselingEmptyHint,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.hintText,
                ),
          ),
        ],
      ),
    );
  }

  void _showDeleteDialog(
    BuildContext context,
    WidgetRef ref,
    TrainingSession session,
    AppLocalizations l10n,
  ) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n.counselingExitDialogTitle),
        content: Text(l10n.counselingDeleteContent),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(l10n.cancel),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(dialogContext);
              final storage = ref.read(storageServiceProvider);
              storage.deleteSession(session.id);
              ref.invalidate(activeSessionsProvider);
            },
            child: Text(l10n.exitLabel),
          ),
        ],
      ),
    );
  }

  Widget _buildSessionCard(
    BuildContext context,
    WidgetRef ref,
    TrainingSession session,
    AppLocalizations l10n,
  ) {
    final scenarioAsync = ref.watch(scenarioByIdProvider(session.scenarioId));

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () {
          ref.read(currentSessionProvider.notifier).resumeSession(session);
          context.push('/chat');
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: scenarioAsync.when(
                      data: (scenario) => Text(
                        scenario?.title ?? l10n.scenarioLabel,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      loading: () => Text(l10n.loading),
                      error: (_, __) => Text(l10n.scenarioLabel),
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.primaryBlue.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      l10n.counselingInProgress,
                      style: const TextStyle(
                        color: AppColors.primaryBlue,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  const SizedBox(width: 4),
                  IconButton(
                    icon: const Icon(Icons.exit_to_app, size: 20),
                    color: AppColors.error,
                    tooltip: l10n.counselingExitDialogTitle,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    onPressed: () =>
                        _showDeleteDialog(context, ref, session, l10n),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(
                    Icons.calendar_today,
                    size: 14,
                    color: AppColors.secondaryText,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    DateFormat('yyyy-MM-dd HH:mm').format(session.startTime),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(width: 16),
                  const Icon(
                    Icons.chat,
                    size: 14,
                    color: AppColors.secondaryText,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    l10n.messageCount(session.messages.length),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
