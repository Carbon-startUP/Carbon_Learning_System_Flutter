import 'package:equatable/equatable.dart';
import 'chat_message_model.dart';

class ChatConversation extends Equatable {
  final String id;
  final String title;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<ChatMessage> messages;
  final bool isPinned;

  const ChatConversation({
    required this.id,
    required this.title,
    required this.createdAt,
    required this.updatedAt,
    required this.messages,
    this.isPinned = false,
  });

  ChatConversation copyWith({
    String? id,
    String? title,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<ChatMessage>? messages,
    bool? isPinned,
  }) {
    return ChatConversation(
      id: id ?? this.id,
      title: title ?? this.title,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      messages: messages ?? this.messages,
      isPinned: isPinned ?? this.isPinned,
    );
  }

  String get lastMessagePreview {
    if (messages.isEmpty) return 'لا توجد رسائل';
    final lastMessage = messages.last;
    if (lastMessage.type == MessageType.text) {
      return lastMessage.content.length > 50
          ? '${lastMessage.content.substring(0, 50)}...'
          : lastMessage.content;
    } else if (lastMessage.type == MessageType.file) {
      return '📎 ${lastMessage.fileName ?? "ملف"}';
    } else if (lastMessage.type == MessageType.image) {
      return '🖼️ ${lastMessage.fileName ?? "صورة"}';
    }
    return 'رسالة';
  }

  @override
  List<Object> get props => [
    id,
    title,
    createdAt,
    updatedAt,
    messages,
    isPinned,
  ];
}
