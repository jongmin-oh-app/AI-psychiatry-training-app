import 'dart:convert';
import 'dart:developer' as developer;

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class GeminiService {
  static const String _baseUrl =
      'https://generativelanguage.googleapis.com/v1beta';
  static const String _model = 'gemini-flash-latest';

  late final Dio _dio;
  late final String _apiKey;

  GeminiService() {
    _apiKey = dotenv.env['GEMINI_API_KEY'] ?? '';
    _dio = Dio(
      BaseOptions(
        baseUrl: _baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 60),
      ),
    );
  }

  /// 단일 텍스트 요청용 (피드백 등)
  Map<String, dynamic> _buildRequestBody(
    String text, {
    Map<String, dynamic>? generationConfig,
  }) {
    final config = <String, dynamic>{
      'temperature': 0.6,
      'topK': 40,
      'topP': 0.95,
      'maxOutputTokens': 1024,
      'thinkingConfig': <String, dynamic>{'thinkingBudget': 0},
    };
    if (generationConfig != null) {
      config.addAll(generationConfig);
    }
    return {
      'contents': [
        {
          'role': 'user',
          'parts': [
            {'text': text},
          ],
        },
      ],
      'generationConfig': config,
    };
  }

  /// 멀티턴 대화 형식: contents를 user/model 교대로 구성
  Future<String> generateAIResponse({
    required String systemPrompt,
    required List<Map<String, String>> conversationHistory,
    required String userMessage,
  }) async {
    // sender 'user' -> role 'user', sender 'ai' -> role 'model'
    final contents = <Map<String, dynamic>>[];
    for (var message in conversationHistory) {
      final role = message['sender'] == 'user' ? 'user' : 'model';
      contents.add({
        'role': role,
        'parts': [
          {'text': message['content'] ?? ''},
        ],
      });
    }
    // 현재 상담원(유저) 메시지 추가
    contents.add({
      'role': 'user',
      'parts': [
        {'text': userMessage},
      ],
    });

    final body = {
      'system_instruction': {
        'parts': [
          {'text': systemPrompt},
        ],
      },
      'contents': contents,
      'generationConfig': {
        'temperature': 0.6,
        'topK': 40,
        'topP': 0.95,
        'maxOutputTokens': 200,
        'thinkingConfig': <String, dynamic>{'thinkingBudget': 0},
      },
    };

    developer.log(
      '=== [Chat] System Prompt ===\n$systemPrompt',
      name: 'GeminiService',
    );
    developer.log(
      '=== [Chat] Contents (${contents.length} messages) ===\n'
      '${const JsonEncoder.withIndent('  ').convert(contents)}',
      name: 'GeminiService',
    );

    final response = await _dio.post<Map<String, dynamic>>(
      '/models/$_model:generateContent',
      queryParameters: {'key': _apiKey},
      data: body,
    );

    final responseData = response.data;
    if (responseData == null) {
      throw Exception('No response from Gemini API');
    }

    final candidates = responseData['candidates'] as List?;
    if (candidates == null || candidates.isEmpty) {
      throw Exception('No response from Gemini API');
    }

    final content = candidates[0]['content'] as Map<String, dynamic>?;
    if (content == null) {
      throw Exception('No response from Gemini API');
    }

    final parts = content['parts'] as List?;
    if (parts == null || parts.isEmpty) {
      throw Exception('No response from Gemini API');
    }

    var text = parts[0]['text'] as String? ?? '';
    text = text.trim().replaceAll('\n', ' ');

    if (text.length > 200) {
      final truncated = text.substring(0, 200);
      final lastDot = truncated.lastIndexOf('.');
      if (lastDot > 0) {
        text = truncated.substring(0, lastDot + 1);
      } else {
        text = truncated;
      }
    }

    return text;
  }

  /// 피드백은 전체 JSON이 필요하므로 generateContent 유지, 요청 형식만 통일
  Future<Map<String, dynamic>> generateFeedback({
    required List<Map<String, String>> conversationHistory,
    String languageCode = 'ko',
  }) async {
    final conversationText = StringBuffer('=== Counseling Conversation ===\n');
    for (var message in conversationHistory) {
      final speaker = message['sender'] == 'user' ? 'Counselor' : 'AI Student';
      conversationText.writeln('$speaker: ${message['content']}');
    }

    final languageInstruction = languageCode == 'en'
        ? 'Write all feedback text fields (goodPoints, improvements) in English.'
        : '모든 피드백 텍스트 필드(goodPoints, improvements)를 한국어로 작성해주세요.';

    final feedbackPrompt =
        '''
Analyze the following counseling conversation and provide feedback.

${conversationText.toString()}

Evaluation criteria:
1. Empathy (1-5): How well did the counselor understand and empathize with the student's emotions?
2. Active Listening (1-5): Did the counselor listen attentively and ask appropriate questions?
3. Question Quality (1-5): Did the questions help advance the conversation constructively?
4. Solution Offering (1-5): Did the counselor provide practical and appropriate support?

Output ONLY the following JSON format, with no additional explanation:
{
  "scores": {
    "empathy": <number 1-5>,
    "listening": <number 1-5>,
    "questioning": <number 1-5>,
    "solution": <number 1-5>
  },
  "goodPoints": "<2-3 sentences describing strengths>",
  "improvements": "<2-3 sentences describing areas for improvement>",
  "recommendedScenarios": ["<scenario id>"]
}

$languageInstruction
''';

    final body = _buildRequestBody(
      feedbackPrompt,
      generationConfig: {'temperature': 0.7, 'maxOutputTokens': 2048},
    );
    // 피드백은 스트리밍 불필요, generateContent 사용
    final response = await _dio.post<Map<String, dynamic>>(
      '/models/$_model:generateContent',
      queryParameters: {'key': _apiKey},
      data: body,
    );

    final responseData = response.data;
    if (responseData == null) {
      throw Exception('No response from Gemini API');
    }

    final candidates = responseData['candidates'] as List?;
    if (candidates == null || candidates.isEmpty) {
      throw Exception('No response from Gemini API');
    }

    final content = candidates[0]['content'] as Map<String, dynamic>?;
    if (content == null) {
      throw Exception('No response from Gemini API');
    }

    final parts = content['parts'] as List?;
    if (parts == null || parts.isEmpty) {
      throw Exception('No response from Gemini API');
    }

    var text = parts[0]['text'] as String? ?? '';
    text = text.trim();
    if (text.startsWith('```json')) {
      text = text.substring(7);
    }
    if (text.startsWith('```')) {
      text = text.substring(3);
    }
    if (text.endsWith('```')) {
      text = text.substring(0, text.length - 3);
    }
    text = text.trim();

    final feedbackJson = jsonDecode(text) as Map<String, dynamic>;
    return feedbackJson;
  }
}
