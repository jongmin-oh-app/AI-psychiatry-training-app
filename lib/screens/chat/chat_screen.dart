import 'package:flutter/material.dart';
import 'package:psychiatry_training/l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../models/training_session.dart';
import '../../providers/session_provider.dart';
import '../../providers/chat_provider.dart';
import '../../providers/scenario_provider.dart';
import '../../widgets/chat_bubble.dart';
import '../../widgets/typing_indicator.dart';
import '../../widgets/full_page_loading_overlay.dart';
import '../../core/constants/colors.dart';

class ChatScreen extends ConsumerStatefulWidget {
  const ChatScreen({super.key});

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final FocusNode _messageFocusNode = FocusNode();
  bool _isComposing = false;

  @override
  void initState() {
    super.initState();
    // Request focus after first frame → show virtual keyboard (iOS/Android)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 300), () {
        if (mounted) {
          _messageFocusNode.requestFocus();
        }
      });
    });
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    _messageFocusNode.dispose();
    super.dispose();
  }

  /// reverse: true so minScrollExtent(0) is the new message side (bottom)
  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      Future.delayed(const Duration(milliseconds: 300), () {
        if (_scrollController.hasClients) {
          _scrollController.animateTo(
            _scrollController.position.minScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final currentSession = ref.watch(currentSessionProvider);
    final chatState = ref.watch(chatProvider);
    final isAITyping = ref.watch(isAITypingProvider);
    final isFeedbackGenerating = ref.watch(isFeedbackGeneratingProvider);

    if (currentSession == null) {
      return Scaffold(
        appBar: AppBar(title: Text(l10n.chatTitle)),
        body: Center(child: Text(l10n.chatNoSession)),
      );
    }

    // Auto-scroll when messages change or typing state changes
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());

    final scenarioAsync = ref.watch(
      scenarioByIdProvider(currentSession.scenarioId),
    );

    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              tooltip: l10n.chatExitTooltip,
              onPressed: () => _showExitDialog(context, l10n),
            ),
            title: scenarioAsync.when(
              data: (scenario) => Text(scenario?.title ?? l10n.chatTitle),
              loading: () => Text(l10n.loading),
              error: (_, __) => Text(l10n.chatTitle),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.check_circle_outline),
                tooltip: l10n.chatEndTooltip,
                onPressed: () => _showEndDialog(context, currentSession, l10n),
              ),
            ],
          ),
          body: Stack(
            children: [
              Positioned.fill(
                child: Column(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () => FocusScope.of(context).unfocus(),
                        child: currentSession.messages.isEmpty && !isAITyping
                            ? _buildEmptyState(context, l10n)
                            : ListView.builder(
                                controller: _scrollController,
                                reverse: true,
                                padding: EdgeInsets.only(
                                  top: 16,
                                  bottom: 88 + MediaQuery.of(context).padding.bottom,
                                ),
                                itemCount: currentSession.messages.length + (isAITyping ? 1 : 0),
                                itemBuilder: (context, index) {
                                  if (isAITyping && index == 0) {
                                    return const TypingIndicator();
                                  }

                                  final messageIndex = isAITyping ? index - 1 : index;
                                  final message =
                                      currentSession.messages[currentSession
                                              .messages
                                              .length -
                                          1 -
                                          messageIndex];
                                  return ChatBubble(message: message);
                                },
                              ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (chatState.hasError)
                      Container(
                        padding: const EdgeInsets.all(8),
                        color: AppColors.error.withOpacity(0.1),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.error,
                              color: AppColors.error,
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                l10n.chatErrorPrefix(chatState.error.toString()),
                                style: const TextStyle(color: AppColors.error),
                              ),
                            ),
                          ],
                        ),
                      ),
                    _buildInputArea(context, l10n),
                  ],
                ),
              ),
            ],
          ),
        ),
        if (isFeedbackGenerating)
          FullPageLoadingOverlay(
            message: l10n.loadingOverlayMessage,
            subtitle: l10n.loadingOverlaySubtitle,
          ),
      ],
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
            l10n.chatEmptyStateTitle,
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(color: AppColors.secondaryText),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Text(
              l10n.chatEmptyStateSubtitle,
              textAlign: TextAlign.center,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: AppColors.hintText),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputArea(BuildContext context, AppLocalizations l10n) {
    final chatState = ref.watch(chatProvider);
    final isLoading = chatState.isLoading;

    return Container(
      padding: const EdgeInsets.all(8),
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
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _messageController,
                focusNode: _messageFocusNode,
                autofocus: false,
                readOnly: false,
                decoration: InputDecoration(
                  hintText: l10n.chatInputHint,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
                maxLines: null,
                textCapitalization: TextCapitalization.sentences,
                onChanged: (text) {
                  setState(() {
                    _isComposing = text.trim().isNotEmpty;
                  });
                },
                onSubmitted: (_) => _handleSubmit(),
              ),
            ),
            const SizedBox(width: 8),
            Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(24),
                onTap: _isComposing && !isLoading ? _handleSubmit : null,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Icon(
                    Icons.send,
                    color: _isComposing && !isLoading
                        ? AppColors.primaryBlue
                        : AppColors.hintText,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleSubmit() {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;

    ref.read(chatProvider.notifier).sendMessage(text);

    _messageController.clear();
    setState(() => _isComposing = false);

    _scrollToBottom();

    _messageFocusNode.requestFocus();
    Future.delayed(const Duration(milliseconds: 50), () {
      if (mounted) _messageFocusNode.requestFocus();
    });
  }

  void _showExitDialog(BuildContext context, AppLocalizations l10n) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n.chatExitDialogTitle),
        content: Text(l10n.chatExitDialogContent),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(l10n.continueLabel),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              ref.read(currentSessionProvider.notifier).clearSession();
              context.go('/counseling');
            },
            child: Text(l10n.exitLabel),
          ),
        ],
      ),
    );
  }

  /// Minimum number of exchanges required before ending the session
  static const int _minimumExchangeCount = 5;

  void _showEndDialog(
    BuildContext context,
    TrainingSession currentSession,
    AppLocalizations l10n,
  ) {
    final userMessageCount = currentSession.messages
        .where((m) => m.isUser)
        .length;

    if (userMessageCount < _minimumExchangeCount) {
      showDialog(
        context: context,
        builder: (dialogContext) => AlertDialog(
          title: Text(l10n.chatEndBlockedTitle),
          content: Text(
            l10n.chatMinExchangeContent(
              _minimumExchangeCount,
              userMessageCount,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: Text(l10n.confirm),
            ),
          ],
        ),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n.chatEndDialogTitle),
        content: Text(l10n.chatEndDialogContent),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(l10n.continueLabel),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(dialogContext);
              _messageFocusNode.unfocus();

              final feedback = await ref
                  .read(chatProvider.notifier)
                  .generateFeedback();

              if (feedback != null && mounted) {
                ref.read(currentSessionProvider.notifier).endSession(feedback);

                final session = ref.read(currentSessionProvider);
                if (session != null) {
                  context.go('/feedback', extra: session);
                }
              }
            },
            child: Text(l10n.chatEndConfirm),
          ),
        ],
      ),
    );
  }
}
