import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../providers/scenario_provider.dart';
import '../../widgets/scenario_card.dart';
import '../../core/constants/colors.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scenariosAsync = ref.watch(scenariosProvider);
    final completedCount = ref.watch(completedScenarioCountProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('AI 상담 트레이닝'),
      ),
      body: scenariosAsync.when(
        data: (scenarios) {
          final totalCount = scenarios.length;

          final completionMap = {
            for (final s in scenarios)
              s.id: ref.watch(isScenarioCompletedProvider(s.id)),
          };

          final incompleteScenarios =
              scenarios.where((s) => !(completionMap[s.id] ?? false)).toList();
          final completedScenarios =
              scenarios.where((s) => completionMap[s.id] ?? false).toList();

          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: _buildProgressSection(
                  context,
                  completedCount,
                  totalCount,
                ),
              ),
              if (incompleteScenarios.isNotEmpty) ...[
                SliverToBoxAdapter(
                  child: _SectionHeader(
                    title: '연습할 시나리오',
                    count: incompleteScenarios.length,
                    isCompleted: false,
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final scenario = incompleteScenarios[index];
                      return ScenarioCard(
                        scenario: scenario,
                        isCompleted: false,
                        onTap: () => context.push('/scenario/${scenario.id}'),
                      );
                    },
                    childCount: incompleteScenarios.length,
                  ),
                ),
              ],
              if (completedScenarios.isNotEmpty) ...[
                SliverToBoxAdapter(
                  child: _SectionHeader(
                    title: '완료한 시나리오',
                    count: completedScenarios.length,
                    isCompleted: true,
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final scenario = completedScenarios[index];
                      return ScenarioCard(
                        scenario: scenario,
                        isCompleted: true,
                        onTap: () => context.push('/scenario/${scenario.id}'),
                      );
                    },
                    childCount: completedScenarios.length,
                  ),
                ),
              ],
              if (scenarios.isEmpty)
                const SliverFillRemaining(
                  child: Center(child: Text('시나리오가 없습니다')),
                ),
              const SliverToBoxAdapter(child: SizedBox(height: 24)),
            ],
          );
        },
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error_outline,
                size: 48,
                color: AppColors.error,
              ),
              const SizedBox(height: 16),
              Text('오류가 발생했습니다\n$error'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProgressSection(
    BuildContext context,
    int completed,
    int total,
  ) {
    final progress = total > 0 ? completed / total : 0.0;

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.primaryLight.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.bar_chart,
                color: AppColors.primaryBlue,
              ),
              const SizedBox(width: 8),
              Text(
                '나의 진행도',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 8,
              backgroundColor: Colors.grey[300],
              valueColor: const AlwaysStoppedAnimation<Color>(
                AppColors.primaryBlue,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '완료: $completed/$total 시나리오 (${(progress * 100).toStringAsFixed(0)}%)',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final int count;
  final bool isCompleted;

  const _SectionHeader({
    required this.title,
    required this.count,
    required this.isCompleted,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 4),
      child: Row(
        children: [
          if (!isCompleted)
            Container(
              width: 3,
              height: 16,
              margin: const EdgeInsets.only(right: 8),
              decoration: BoxDecoration(
                color: AppColors.primaryBlue,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: isCompleted
                      ? AppColors.secondaryText
                      : AppColors.primaryText,
                  fontWeight:
                      isCompleted ? FontWeight.normal : FontWeight.bold,
                ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: isCompleted
                  ? Colors.grey[200]
                  : AppColors.primaryBlue.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              '$count개',
              style: TextStyle(
                fontSize: 12,
                color: isCompleted
                    ? AppColors.secondaryText
                    : AppColors.primaryBlue,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
