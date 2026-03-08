import 'package:flutter/material.dart';
import 'package:psychiatry_training/l10n/app_localizations.dart';
import '../models/scenario.dart';
import '../core/constants/colors.dart';

class ScenarioCard extends StatelessWidget {
  final Scenario scenario;
  final bool isCompleted;
  final VoidCallback onTap;

  const ScenarioCard({
    super.key,
    required this.scenario,
    required this.isCompleted,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      color: isCompleted ? const Color(0xFFF5F5F5) : Colors.white,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      scenario.title,
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            color: isCompleted
                                ? AppColors.secondaryText
                                : AppColors.primaryText,
                          ),
                    ),
                  ),
                  _buildDifficultyBadge(context, l10n),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                scenario.description,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: isCompleted
                          ? AppColors.hintText
                          : AppColors.secondaryText,
                    ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Icon(
                    Icons.access_time,
                    size: 16,
                    color: isCompleted
                        ? AppColors.hintText
                        : AppColors.secondaryText,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    l10n.estimatedTimeMinutes(scenario.estimatedTime),
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: isCompleted
                              ? AppColors.hintText
                              : AppColors.secondaryText,
                        ),
                  ),
                  const Spacer(),
                  if (isCompleted) _CompletedCta(l10n: l10n) else _IncompleteCta(l10n: l10n),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDifficultyBadge(BuildContext context, AppLocalizations l10n) {
    Color color;
    String text;

    switch (scenario.difficulty) {
      case 'beginner':
        color = AppColors.success;
        text = l10n.difficultyBeginner;
        break;
      case 'intermediate':
        color = AppColors.warning;
        text = l10n.difficultyIntermediate;
        break;
      case 'advanced':
        color = AppColors.error;
        text = l10n.difficultyAdvanced;
        break;
      default:
        color = AppColors.info;
        text = scenario.difficulty;
    }

    if (isCompleted) color = AppColors.hintText;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: color,
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }
}

class _IncompleteCta extends StatelessWidget {
  final AppLocalizations l10n;

  const _IncompleteCta({required this.l10n});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          l10n.startLabel,
          style: const TextStyle(
            color: AppColors.primaryBlue,
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(width: 2),
        const Icon(
          Icons.arrow_forward_ios,
          size: 11,
          color: AppColors.primaryBlue,
        ),
      ],
    );
  }
}

class _CompletedCta extends StatelessWidget {
  final AppLocalizations l10n;

  const _CompletedCta({required this.l10n});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.check_circle, size: 15, color: AppColors.success),
        const SizedBox(width: 4),
        Text(
          l10n.completedLabel,
          style: const TextStyle(
            color: AppColors.success,
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(width: 10),
        const Icon(Icons.refresh, size: 14, color: AppColors.hintText),
        const SizedBox(width: 3),
        Text(
          l10n.retryLabel,
          style: const TextStyle(color: AppColors.hintText, fontSize: 12),
        ),
      ],
    );
  }
}
