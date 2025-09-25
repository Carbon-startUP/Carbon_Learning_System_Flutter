import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:math';
import '../../data/models/chat_message_model.dart';
import '../../data/models/chat_file_model.dart';
import '../../data/models/chat_conversation_model.dart';
import '../../data/repositories/chat_repository.dart';
import 'ai_chat_state.dart';

class AiChatCubit extends Cubit<AiChatState> {
  final ChatRepository _chatRepository;

  AiChatCubit({ChatRepository? chatRepository})
    : _chatRepository = chatRepository ?? ChatRepository(),
      super(AiChatInitial()) {
    _loadConversationHistory();
  }

  List<ChatConversation> _conversationHistory = [];
  ChatConversation? _currentConversation;

  Future<void> _loadConversationHistory() async {
    try {
      emit(AiChatLoading());
      _conversationHistory = await _chatRepository.getAllConversations();
      emit(
        AiChatLoaded(
          conversationHistory: _conversationHistory,
          currentConversation: _currentConversation,
        ),
      );
    } catch (e) {
      emit(AiChatError(e.toString()));
    }
  }

  Future<void> startNewConversation() async {
    try {
      final welcomeMessage = ChatMessage(
        id: _generateId(),
        content: 'مرحباً! أنا مساعدك الذكي. كيف يمكنني مساعدتك اليوم؟',
        type: MessageType.text,
        sender: MessageSender.ai,
        timestamp: DateTime.now(),
      );

      final newConversation = ChatConversation(
        id: _generateId(),
        title: 'محادثة جديدة',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        messages: [welcomeMessage],
      );

      await _chatRepository.saveConversation(newConversation);

      _currentConversation = newConversation;

      _conversationHistory.insert(0, newConversation);

      emit(
        AiChatLoaded(
          currentConversation: _currentConversation,
          conversationHistory: _conversationHistory,
        ),
      );
    } catch (e) {
      emit(AiChatError(e.toString()));
    }
  }

  Future<void> loadConversation(String conversationId) async {
    try {
      final conversation = _conversationHistory.firstWhere(
        (conv) => conv.id == conversationId,
        orElse: () => throw Exception('المحادثة غير موجودة'),
      );

      _currentConversation = conversation;
      emit(
        AiChatLoaded(
          currentConversation: _currentConversation,
          conversationHistory: _conversationHistory,
        ),
      );
    } catch (e) {
      emit(AiChatError(e.toString()));
    }
  }

  Future<void> sendTextMessage(String content) async {
    if (content.trim().isEmpty || _currentConversation == null) return;

    try {
      final userMessage = ChatMessage(
        id: _generateId(),
        content: content,
        type: MessageType.text,
        sender: MessageSender.user,
        timestamp: DateTime.now(),
      );

      final updatedMessages = [..._currentConversation!.messages, userMessage];
      _currentConversation = _currentConversation!.copyWith(
        messages: updatedMessages,
        updatedAt: DateTime.now(),
      );

      await _chatRepository.addMessageToConversation(
        _currentConversation!.id,
        userMessage,
      );
      await _updateConversationInHistory();

      emit(
        AiChatLoaded(
          currentConversation: _currentConversation,
          conversationHistory: _conversationHistory,
          isTyping: true,
        ),
      );

      if (_shouldGenerateTitle()) {
        await _generateConversationTitle(content);
      }

      await _simulateAiResponse(content);
    } catch (e) {
      emit(AiChatError(e.toString()));
    }
  }

  Future<void> sendFileMessage(ChatFile file) async {
    if (_currentConversation == null) return;

    try {
      final userMessage = ChatMessage(
        id: _generateId(),
        content: 'تم إرسال ملف: ${file.name}',
        type: _getMessageTypeFromExtension(file.extension),
        sender: MessageSender.user,
        timestamp: DateTime.now(),
        fileName: file.name,
        fileSize: file.size,
        filePath: file.path,
      );

      final updatedMessages = [..._currentConversation!.messages, userMessage];
      _currentConversation = _currentConversation!.copyWith(
        messages: updatedMessages,
        updatedAt: DateTime.now(),
      );

      await _chatRepository.addMessageToConversation(
        _currentConversation!.id,
        userMessage,
      );
      await _updateConversationInHistory();

      emit(
        AiChatLoaded(
          currentConversation: _currentConversation,
          conversationHistory: _conversationHistory,
          isTyping: true,
        ),
      );

      if (_shouldGenerateTitle()) {
        await _generateConversationTitle('ملف: ${file.name}');
      }

      await _simulateAiFileResponse(file);
    } catch (e) {
      emit(AiChatError(e.toString()));
    }
  }

  Future<void> pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.any,
        allowMultiple: false,
      );

      if (result != null && result.files.isNotEmpty) {
        final file = result.files.first;
        final chatFile = ChatFile(
          name: file.name,
          path: file.path ?? '',
          size: _formatFileSize(file.size),
          extension: file.extension ?? '',
        );

        await sendFileMessage(chatFile);
      }
    } catch (e) {
      emit(AiChatError('خطأ في اختيار الملف: ${e.toString()}'));
    }
  }

  Future<void> deleteConversation(String conversationId) async {
    try {
      await _chatRepository.deleteConversation(conversationId);

      _conversationHistory.removeWhere((conv) => conv.id == conversationId);

      if (_currentConversation?.id == conversationId) {
        _currentConversation = null;
      }

      emit(
        AiChatLoaded(
          currentConversation: _currentConversation,
          conversationHistory: _conversationHistory,
        ),
      );
    } catch (e) {
      emit(AiChatError(e.toString()));
    }
  }

  Future<void> pinConversation(String conversationId) async {
    try {
      final index = _conversationHistory.indexWhere(
        (conv) => conv.id == conversationId,
      );
      if (index != -1) {
        final conversation = _conversationHistory[index];
        final updatedConversation = conversation.copyWith(
          isPinned: !conversation.isPinned,
        );

        await _chatRepository.updateConversation(updatedConversation);

        _conversationHistory[index] = updatedConversation;

        if (_currentConversation?.id == conversationId) {
          _currentConversation = updatedConversation;
        }

        _conversationHistory.sort((a, b) {
          if (a.isPinned && !b.isPinned) return -1;
          if (!a.isPinned && b.isPinned) return 1;
          return b.updatedAt.compareTo(a.updatedAt);
        });

        emit(
          AiChatLoaded(
            currentConversation: _currentConversation,
            conversationHistory: _conversationHistory,
          ),
        );
      }
    } catch (e) {
      emit(AiChatError(e.toString()));
    }
  }

  Future<void> clearCurrentChat() async {
    if (_currentConversation != null) {
      try {
        final welcomeMessage = ChatMessage(
          id: _generateId(),
          content: 'مرحباً! أنا مساعدك الذكي. كيف يمكنني مساعدتك اليوم؟',
          type: MessageType.text,
          sender: MessageSender.ai,
          timestamp: DateTime.now(),
        );

        _currentConversation = _currentConversation!.copyWith(
          messages: [welcomeMessage],
          title: 'محادثة جديدة',
          updatedAt: DateTime.now(),
        );

        await _chatRepository.saveConversation(_currentConversation!);
        await _updateConversationInHistory();

        emit(
          AiChatLoaded(
            currentConversation: _currentConversation,
            conversationHistory: _conversationHistory,
          ),
        );
      } catch (e) {
        emit(AiChatError(e.toString()));
      }
    }
  }

  Future<void> _simulateAiResponse(String userMessage) async {
    await Future.delayed(const Duration(seconds: 2));

    if (_currentConversation == null) return;

    try {
      final responses = [
        'شكراً لك على رسالتك. كيف يمكنني مساعدتك أكثر؟',
        'فهمت طلبك. هل تريد المزيد من المعلومات حول هذا الموضوع؟',
        'هذا سؤال رائع! دعني أفكر في أفضل إجابة لك.',
        'أقدر تواصلك معي. هل يمكنك توضيح المزيد من التفاصيل؟',
        'ممتاز! سأكون سعيداً لمساعدتك في هذا الأمر.',
      ];

      final aiMessage = ChatMessage(
        id: _generateId(),
        content: responses[Random().nextInt(responses.length)],
        type: MessageType.text,
        sender: MessageSender.ai,
        timestamp: DateTime.now(),
      );

      final updatedMessages = [..._currentConversation!.messages, aiMessage];
      _currentConversation = _currentConversation!.copyWith(
        messages: updatedMessages,
        updatedAt: DateTime.now(),
      );

      await _chatRepository.addMessageToConversation(
        _currentConversation!.id,
        aiMessage,
      );
      await _updateConversationInHistory();

      emit(
        AiChatLoaded(
          currentConversation: _currentConversation,
          conversationHistory: _conversationHistory,
        ),
      );
    } catch (e) {
      emit(AiChatError(e.toString()));
    }
  }

  Future<void> _simulateAiFileResponse(ChatFile file) async {
    await Future.delayed(const Duration(seconds: 3));

    if (_currentConversation == null) return;

    try {
      String response;

      switch (file.extension.toLowerCase()) {
        case 'pdf':
          response =
              'تم استلام ملف PDF بنجاح. يمكنني مساعدتك في تحليل محتواه أو الإجابة على أسئلتك حوله.';
          break;
        case 'jpg':
        case 'jpeg':
        case 'png':
        case 'gif':
          response =
              'تم استلام الصورة بنجاح. يمكنني وصف محتوى الصورة أو الإجابة على أسئلتك حولها.';
          break;
        case 'doc':
        case 'docx':
          response =
              'تم استلام مستند Word بنجاح. يمكنني مساعدتك في تحليل النص أو تلخيصه.';
          break;
        case 'txt':
          response =
              'تم استلام الملف النصي بنجاح. يمكنني قراءة المحتوى ومساعدتك في تحليله.';
          break;
        default:
          response =
              'تم استلام الملف بنجاح. حجم الملف: ${file.size}. كيف يمكنني مساعدتك بخصوص هذا الملف؟';
      }

      final aiMessage = ChatMessage(
        id: _generateId(),
        content: response,
        type: MessageType.text,
        sender: MessageSender.ai,
        timestamp: DateTime.now(),
      );

      final updatedMessages = [..._currentConversation!.messages, aiMessage];
      _currentConversation = _currentConversation!.copyWith(
        messages: updatedMessages,
        updatedAt: DateTime.now(),
      );

      await _chatRepository.addMessageToConversation(
        _currentConversation!.id,
        aiMessage,
      );
      await _updateConversationInHistory();

      emit(
        AiChatLoaded(
          currentConversation: _currentConversation,
          conversationHistory: _conversationHistory,
        ),
      );
    } catch (e) {
      emit(AiChatError(e.toString()));
    }
  }

  Future<void> _generateConversationTitle(String firstUserMessage) async {
    if (_currentConversation == null) return;

    try {
      emit(
        AiChatLoaded(
          currentConversation: _currentConversation,
          conversationHistory: _conversationHistory,
          isGeneratingTitle: true,
        ),
      );

      await Future.delayed(const Duration(seconds: 1));

      final title = _createTitleFromMessage(firstUserMessage);

      _currentConversation = _currentConversation!.copyWith(
        title: title,
        updatedAt: DateTime.now(),
      );

      await _chatRepository.updateConversation(_currentConversation!);
      await _updateConversationInHistory();

      emit(
        AiChatLoaded(
          currentConversation: _currentConversation,
          conversationHistory: _conversationHistory,
        ),
      );
    } catch (e) {
      emit(AiChatError(e.toString()));
    }
  }

  String _createTitleFromMessage(String message) {
    final words = message.split(' ');
    final meaningfulWords = words
        .where(
          (word) =>
              word.length > 2 &&
              ![
                'في',
                'من',
                'إلى',
                'على',
                'عن',
                'مع',
                'هل',
                'ما',
                'كيف',
                'أين',
                'متى',
                'لماذا',
              ].contains(word),
        )
        .take(3);

    if (meaningfulWords.isEmpty) {
      return 'محادثة ${DateTime.now().day}/${DateTime.now().month}';
    }

    String title = meaningfulWords.join(' ');
    if (title.length > 30) {
      title = '${title.substring(0, 27)}...';
    }

    return title;
  }

  bool _shouldGenerateTitle() {
    if (_currentConversation == null) return false;

    final userMessages = _currentConversation!.messages.where(
      (msg) => msg.sender == MessageSender.user,
    );

    return _currentConversation!.title == 'محادثة جديدة' &&
        userMessages.length == 1;
  }

  Future<void> _updateConversationInHistory() async {
    if (_currentConversation == null) return;

    try {
      await _chatRepository.saveConversation(_currentConversation!);

      final index = _conversationHistory.indexWhere(
        (conv) => conv.id == _currentConversation!.id,
      );

      if (index != -1) {
        _conversationHistory[index] = _currentConversation!;
      } else {
        _conversationHistory.insert(0, _currentConversation!);
      }

      _conversationHistory.sort((a, b) {
        if (a.isPinned && !b.isPinned) return -1;
        if (!a.isPinned && b.isPinned) return 1;
        return b.updatedAt.compareTo(a.updatedAt);
      });
    } catch (e) {
      emit(AiChatError(e.toString()));
    }
  }

  MessageType _getMessageTypeFromExtension(String extension) {
    final imageExtensions = ['jpg', 'jpeg', 'png', 'gif', 'bmp', 'webp'];

    if (imageExtensions.contains(extension.toLowerCase())) {
      return MessageType.image;
    }

    return MessageType.file;
  }

  String _formatFileSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    if (bytes < 1024 * 1024 * 1024) {
      return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    }
    return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
  }

  String _generateId() {
    return DateTime.now().millisecondsSinceEpoch.toString() +
        Random().nextInt(1000).toString();
  }

  Future<void> refreshConversationHistory() async {
    await _loadConversationHistory();
  }
}
