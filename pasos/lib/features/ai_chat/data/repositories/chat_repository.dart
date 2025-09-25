import '../datasources/chat_database_helper.dart';
import '../models/chat_conversation_model.dart';
import '../models/chat_message_model.dart';

class ChatRepository {
  final ChatDatabaseHelper _databaseHelper;

  ChatRepository({ChatDatabaseHelper? databaseHelper})
    : _databaseHelper = databaseHelper ?? ChatDatabaseHelper();

  Future<List<ChatConversation>> getAllConversations() async {
    try {
      return await _databaseHelper.loadConversations();
    } catch (e) {
      throw Exception('فشل في تحميل المحادثات: ${e.toString()}');
    }
  }

  Future<void> saveConversation(ChatConversation conversation) async {
    try {
      await _databaseHelper.saveConversation(conversation);
    } catch (e) {
      throw Exception('فشل في حفظ المحادثة: ${e.toString()}');
    }
  }

  Future<void> updateConversation(ChatConversation conversation) async {
    try {
      await _databaseHelper.updateConversation(conversation);
    } catch (e) {
      throw Exception('فشل في تحديث المحادثة: ${e.toString()}');
    }
  }

  Future<void> deleteConversation(String conversationId) async {
    try {
      await _databaseHelper.deleteConversation(conversationId);
    } catch (e) {
      throw Exception('فشل في حذف المحادثة: ${e.toString()}');
    }
  }

  Future<void> addMessageToConversation(
    String conversationId,
    ChatMessage message,
  ) async {
    try {
      await _databaseHelper.addMessageToConversation(conversationId, message);
    } catch (e) {
      throw Exception('فشل في إضافة الرسالة: ${e.toString()}');
    }
  }

  Future<List<ChatConversation>> searchConversations(String query) async {
    try {
      return await _databaseHelper.searchConversations(query);
    } catch (e) {
      throw Exception('فشل في البحث: ${e.toString()}');
    }
  }

  Future<void> clearAllConversations() async {
    try {
      await _databaseHelper.clearAllData();
    } catch (e) {
      throw Exception('فشل في مسح البيانات: ${e.toString()}');
    }
  }
}
