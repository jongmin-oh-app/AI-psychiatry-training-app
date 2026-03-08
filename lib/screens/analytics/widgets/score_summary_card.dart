import 'package:flutter/material.dart';
import 'package:psychiatry_training/l10n/app_localizations.dart';
import '../../../core/constants/colors.dart';
import '../../../providers/analytics_provider.dart';

class ScoreSummaryCard extends StatelessWidget {
  final AnalyticsData data;

  const ScoreSummaryCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.summaryTitle,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _SummaryItem(
                    icon: Icons.school,
                    label: l10n.summaryTotalSessions,
                    value: l10n.sessionCount(data.totalSessions),
                    color: AppColors.primaryBlue,
                  ),
                ),
                Expanded(
                  child: _SummaryItem(
                    icon: Icons.star,
                    label: l10n.summaryAverageScore,
                    value: data.overallAverage.toStringAsFixed(1),
                    color: AppColors.accent,
                  ),
                ),
                Expanded(
                  child: _SummaryItem(
                    icon: Icons.trending_up,
                    label: l10n.summaryImprovementRate,
                    value: data.improvementRate != null
                        ? '${data.improvementRate! >= 0 ? '+' : ''}'
                            '${data.improvementRate!.toStringAsFixed(1)}%'
                        : '-',
                    color: data.improvementRate != null &&
                            data.improvementRate! >= 0
                        ? AppColors.success
                        : AppColors.error,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _SummaryItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _SummaryItem({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: color,
              ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.secondaryText,
              ),
        ),
      ],
    );
  }
}
