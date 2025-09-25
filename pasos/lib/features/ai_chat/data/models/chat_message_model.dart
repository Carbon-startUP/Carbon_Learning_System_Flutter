import 'package:equatable/equatable.dart';

enum MessageType { text, file, image }

enum MessageSender { user, ai }

class ChatMessage extends Equatable {
  final String id;
  final String content;
  final MessageType type;
  final MessageSender sender;
  final DateTime timestamp;
  final String? fileName;
  final String? fileSize;
  final String? filePath;
  final bool isLoading;

  const ChatMessage({
    required this.id,
    required this.content,
    required this.type,
    required this.sender,
    required this.timestamp,
    this.fileName,
    this.fileSize,
    this.filePath,
    this.isLoading = false,
  });

  ChatMessage copyWith({
    String? id,
    String? content,
    MessageType? type,
    MessageSender? sender,
    DateTime? timestamp,
    String? fileName,
    String? fileSize,
    String? filePath,
    bool? isLoading,
  }) {
    return ChatMessage(
      id: id ?? this.id,
      content: content ?? this.content,
      type: type ?? this.type,
      sender: sender ?? this.sender,
      timestamp: timestamp ?? this.timestamp,
      fileName: fileName ?? this.fileName,
      fileSize: fileSize ?? this.fileSize,
      filePath: filePath ?? this.filePath,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [
    id,
    content,
    type,
    sender,
    timestamp,
    fileName,
    fileSize,
    filePath,
    isLoading,
  ];
}
