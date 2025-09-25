import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../data/models/chat_conversation_model.dart';
import '../../data/repositories/chat_repository.dart';

abstract class ChatHistoryState extends Equatable {
  const ChatHistoryState();

  @override
  List<Object> get props => [];
}

class ChatHistoryInitial extends ChatHistoryState {}

class ChatHistoryLoading extends ChatHistoryState {}

class ChatHistoryLoaded extends ChatHistoryState {
  final List<ChatConversation> conversations;
  final String searchQuery;

  const ChatHistoryLoaded({required this.conversations, this.searchQuery = ''});

  ChatHistoryLoaded copyWith({
    List<ChatConversation>? conversations,
    String? searchQuery,
  }) {
    return ChatHistoryLoaded(
      conversations: conversations ?? this.conversations,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }

  List<ChatConversation> get filteredConversations {
    if (searchQuery.isEmpty) return conversations;
    return conversations
        .where(
          (conversation) =>
              conversation.title.toLowerCase().contains(
                searchQuery.toLowerCase(),
              ) ||
              conversation.lastMessagePreview.toLowerCase().contains(
                searchQuery.toLowerCase(),
              ),
        )
        .toList();
  }

  @override
  List<Object> get props => [conversations, searchQuery];
}

class ChatHistoryError extends ChatHistoryState {
  final String message;

  const ChatHistoryError(this.message);

  @override
  List<Object> get props => [message];
}

class ChatHistoryCubit extends Cubit<ChatHistoryState> {
  final ChatRepository _chatRepository;

  ChatHistoryCubit({ChatRepository? chatRepository})
    : _chatRepository = chatRepository ?? ChatRepository(),
      super(ChatHistoryInitial());

  List<ChatConversation> _conversations = [];

  Future<void> loadConversations([
    List<ChatConversation>? conversations,
  ]) async {
    try {
      emit(ChatHistoryLoading());

      if (conversations != null) {
        _conversations = List.from(conversations);
      } else {
        _conversations = await _chatRepository.getAllConversations();
      }

      _conversations.sort((a, b) {
        if (a.isPinned && !b.isPinned) return -1;
        if (!a.isPinned && b.isPinned) return 1;
        return b.updatedAt.compareTo(a.updatedAt);
      });

      emit(ChatHistoryLoaded(conversations: _conversations));
    } catch (e) {
      emit(ChatHistoryError(e.toString()));
    }
  }

  Future<void> searchConversations(String query) async {
    try {
      if (state is ChatHistoryLoaded) {
        final currentState = state as ChatHistoryLoaded;

        if (query.trim().isEmpty) {
          emit(currentState.copyWith(searchQuery: query));
        } else {
          final searchResults = await _chatRepository.searchConversations(
            query,
          );
          emit(
            ChatHistoryLoaded(conversations: searchResults, searchQuery: query),
          );
        }
      }
    } catch (e) {
      emit(ChatHistoryError(e.toString()));
    }
  }

  Future<void> deleteConversation(String conversationId) async {
    try {
      await _chatRepository.deleteConversation(conversationId);
      _conversations.removeWhere((conv) => conv.id == conversationId);

      if (state is ChatHistoryLoaded) {
        final currentState = state as ChatHistoryLoaded;
        emit(currentState.copyWith(conversations: _conversations));
      }
    } catch (e) {
      emit(ChatHistoryError(e.toString()));
    }
  }

  Future<void> pinConversation(String conversationId) async {
    try {
      final index = _conversations.indexWhere(
        (conv) => conv.id == conversationId,
      );
      if (index != -1) {
        final conversation = _conversations[index];
        final updatedConversation = conversation.copyWith(
          isPinned: !conversation.isPinned,
        );

        await _chatRepository.updateConversation(updatedConversation);

        _conversations[index] = updatedConversation;
        _conversations.sort((a, b) {
          if (a.isPinned && !b.isPinned) return -1;
          if (!a.isPinned && b.isPinned) return 1;
          return b.updatedAt.compareTo(a.updatedAt);
        });

        if (state is ChatHistoryLoaded) {
          final currentState = state as ChatHistoryLoaded;
          emit(currentState.copyWith(conversations: _conversations));
        }
      }
    } catch (e) {
      emit(ChatHistoryError(e.toString()));
    }
  }

  Future<void> refreshConversations() async {
    await loadConversations();
  }
}
