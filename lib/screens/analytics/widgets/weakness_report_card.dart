import 'package:flutter/material.dart';
import 'package:psychiatry_training/l10n/app_localizations.dart';
import '../../../core/constants/colors.dart';
import '../../../providers/analytics_provider.dart';

class WeaknessReportCard extends StatelessWidget {
  final List<WeaknessItem> weaknesses;

  const WeaknessReportCard({super.key, required this.weaknesses});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    if (weaknesses.isEmpty) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.weaknessTitle,
                style:
                    Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Icon(
                    Icons.check_circle,
                    color: AppColors.success,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      l10n.weaknessAllGood,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: AppColors.success),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.weaknessTitle,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 4),
            Text(
              l10n.weaknessHint,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.secondaryText,
                  ),
            ),
            const SizedBox(height: 16),
            ...weaknesses.map(
              (w) => _WeaknessRow(item: w),
            ),
          ],
        ),
      ),
    );
  }
}

class _WeaknessRow extends StatelessWidget {
  final WeaknessItem item;

  const _WeaknessRow({required this.item});

  String _label(AppLocalizations l10n) => switch (item.key) {
        'empathy' => l10n.categoryEmpathy,
        'listening' => l10n.categoryListening,
        'questioning' => l10n.categoryQuestioning,
        'solution' => l10n.categorySolution,
        _ => item.label,
      };

  String _recommendation(AppLocalizations l10n) => switch (item.key) {
        'empathy' => l10n.weaknessEmpathy,
        'listening' => l10n.weaknessListening,
        'questioning' => l10n.weaknessQuestioning,
        'solution' => l10n.weaknessSolution,
        _ => item.recommendation,
      };

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 2),
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: AppColors.warning.withOpacity(0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.lightbulb_outline,
              size: 18,
              color: AppColors.accent,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      _label(l10n),
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      item.average.toStringAsFixed(1),
                      style:
                          Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: AppColors.error,
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  _recommendation(l10n),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.secondaryText,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
