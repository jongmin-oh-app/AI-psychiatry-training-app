import 'dart:math';

import 'package:json_annotation/json_annotation.dart';

part 'scenario.g.dart';

/// learningGoals가 문자열(레거시)이면 줄바꿈 기준으로 분리, 리스트면 그대로 사용
List<String> _learningGoalsFromJson(dynamic value) {
  if (value is List) {
    return value.map((e) => e.toString()).toList();
  }
  if (value is String) {
    return value
        .split(RegExp(r'\n'))
        .map((s) => s.replaceFirst(RegExp(r'^[\s•\-]*'), '').trim())
        .where((s) => s.isNotEmpty)
        .toList();
  }
  return [];
}

@JsonSerializable()
class Scenario {
  final String id;
  final String title;
  final String description;
  final String difficulty; // 'beginner', 'intermediate', 'advanced'
  final int estimatedTime; // minutes
  final String category;
  final String background;
  @JsonKey(fromJson: _learningGoalsFromJson)
  final List<String> learningGoals; // 학습 목표 리스트 (UI/평가에서 안정적 파싱)
  final List<String> greetings; // AI 학생의 첫인사 후보 (랜덤 선택)
  final List<Map<String, dynamic>> exampleDialogue; // 이상적 흐름(Good path) 대화 예시
  final String systemPrompt;
  final Map<String, dynamic> characterProfile;
  // 평가/안전/점진성 필드
  final String? riskLevel; // 'low'|'medium'|'high' - 위험도(교육자용)
  final List<String>? safetyChecks; // 필수 확인 항목
  final List<String>? redFlags; // 고위험 시 연계 필요 신호
  final String? handoffGuidance; // 전문 기관 연계 시 사용할 문장 예시
  final List<String>? emotionTransitionRules; // 감정 변화 가이드라인(시나리오별)
  final List<Map<String, dynamic>>? exampleDialogueBadPath; // 흔한 실수 → 학생 방어/회피 예시
  final List<String>? successCriteria; // 상담사 최소 달성 행동
  final List<Map<String, dynamic>>? commonMistakes; // { mistake, studentReaction }
  final List<Map<String, dynamic>>? studentReactivityRules; // 특정 발화 → 학생 반응 템플릿

  Scenario({
    required this.id,
    required this.title,
    required this.description,
    required this.difficulty,
    required this.estimatedTime,
    required this.category,
    required this.background,
    required this.learningGoals,
    required this.greetings,
    this.exampleDialogue = const [],
    required this.systemPrompt,
    required this.characterProfile,
    this.riskLevel,
    this.safetyChecks,
    this.redFlags,
    this.handoffGuidance,
    this.emotionTransitionRules,
    this.exampleDialogueBadPath,
    this.successCriteria,
    this.commonMistakes,
    this.studentReactivityRules,
  });

  /// greetings 리스트에서 랜덤으로 하나 선택
  String getRandomGreeting() {
    if (greetings.isEmpty) return '';
    return greetings[Random().nextInt(greetings.length)];
  }

  factory Scenario.fromJson(Map<String, dynamic> json) =>
      _$ScenarioFromJson(json);
  Map<String, dynamic> toJson() => _$ScenarioToJson(this);
}
