import 'package:equatable/equatable.dart';
import '../../data/models/chat_conversation_model.dart';

abstract class AiChatState extends Equatable {
  const AiChatState();

  @override
  List<Object> get props => [];
}

class AiChatInitial extends AiChatState {}

class AiChatLoading extends AiChatState {}

class AiChatLoaded extends AiChatState {
  final ChatConversation? currentConversation;
  final List<ChatConversation> conversationHistory;
  final bool isTyping;
  final bool isGeneratingTitle;

  const AiChatLoaded({
    this.currentConversation,
    this.conversationHistory = const [],
    this.isTyping = false,
    this.isGeneratingTitle = false,
  });

  AiChatLoaded copyWith({
    ChatConversation? currentConversation,
    List<ChatConversation>? conversationHistory,
    bool? isTyping,
    bool? isGeneratingTitle,
  }) {
    return AiChatLoaded(
      currentConversation: currentConversation ?? this.currentConversation,
      conversationHistory: conversationHistory ?? this.conversationHistory,
      isTyping: isTyping ?? this.isTyping,
      isGeneratingTitle: isGeneratingTitle ?? this.isGeneratingTitle,
    );
  }

  @override
  List<Object> get props => [
    currentConversation ?? '',
    conversationHistory,
    isTyping,
    isGeneratingTitle,
  ];
}

class AiChatError extends AiChatState {
  final String message;

  const AiChatError(this.message);

  @override
  List<Object> get props => [message];
}

class AiChatHistoryLoaded extends AiChatState {
  final List<ChatConversation> conversations;

  const AiChatHistoryLoaded(this.conversations);

  @override
  List<Object> get props => [conversations];
}
