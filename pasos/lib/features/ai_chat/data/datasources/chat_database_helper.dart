import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/chat_conversation_model.dart';
import '../models/chat_message_model.dart';

class ChatDatabaseHelper {
  static final ChatDatabaseHelper _instance = ChatDatabaseHelper._internal();
  static Database? _database;

  ChatDatabaseHelper._internal();

  factory ChatDatabaseHelper() => _instance;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'chat_database.db');

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE conversations (
        id TEXT PRIMARY KEY,
        title TEXT NOT NULL,
        created_at INTEGER NOT NULL,
        updated_at INTEGER NOT NULL,
        is_pinned INTEGER NOT NULL DEFAULT 0
      )
    ''');

    await db.execute('''
      CREATE TABLE messages (
        id TEXT PRIMARY KEY,
        conversation_id TEXT NOT NULL,
        content TEXT NOT NULL,
        type INTEGER NOT NULL,
        sender INTEGER NOT NULL,
        timestamp INTEGER NOT NULL,
        file_name TEXT,
        file_size TEXT,
        file_path TEXT,
        is_loading INTEGER NOT NULL DEFAULT 0,
        FOREIGN KEY (conversation_id) REFERENCES conversations (id) ON DELETE CASCADE
      )
    ''');

    await db.execute('''
      CREATE INDEX idx_messages_conversation_id ON messages (conversation_id)
    ''');

    await db.execute('''
      CREATE INDEX idx_conversations_updated_at ON conversations (updated_at)
    ''');
  }

  Future<void> saveConversation(ChatConversation conversation) async {
    final db = await database;

    await db.transaction((txn) async {
      await txn.insert('conversations', {
        'id': conversation.id,
        'title': conversation.title,
        'created_at': conversation.createdAt.millisecondsSinceEpoch,
        'updated_at': conversation.updatedAt.millisecondsSinceEpoch,
        'is_pinned': conversation.isPinned ? 1 : 0,
      }, conflictAlgorithm: ConflictAlgorithm.replace);

      await txn.delete(
        'messages',
        where: 'conversation_id = ?',
        whereArgs: [conversation.id],
      );

      for (final message in conversation.messages) {
        await txn.insert('messages', {
          'id': message.id,
          'conversation_id': conversation.id,
          'content': message.content,
          'type': message.type.index,
          'sender': message.sender.index,
          'timestamp': message.timestamp.millisecondsSinceEpoch,
          'file_name': message.fileName,
          'file_size': message.fileSize,
          'file_path': message.filePath,
          'is_loading': message.isLoading ? 1 : 0,
        });
      }
    });
  }

  Future<List<ChatConversation>> loadConversations() async {
    final db = await database;

    final conversationMaps = await db.query(
      'conversations',
      orderBy: 'is_pinned DESC, updated_at DESC',
    );

    final conversations = <ChatConversation>[];

    for (final conversationMap in conversationMaps) {
      final messages = await _loadMessagesForConversation(
        conversationMap['id'] as String,
      );

      conversations.add(
        ChatConversation(
          id: conversationMap['id'] as String,
          title: conversationMap['title'] as String,
          createdAt: DateTime.fromMillisecondsSinceEpoch(
            conversationMap['created_at'] as int,
          ),
          updatedAt: DateTime.fromMillisecondsSinceEpoch(
            conversationMap['updated_at'] as int,
          ),
          isPinned: (conversationMap['is_pinned'] as int) == 1,
          messages: messages,
        ),
      );
    }

    return conversations;
  }

  Future<List<ChatMessage>> _loadMessagesForConversation(
    String conversationId,
  ) async {
    final db = await database;

    final messageMaps = await db.query(
      'messages',
      where: 'conversation_id = ?',
      whereArgs: [conversationId],
      orderBy: 'timestamp ASC',
    );

    return messageMaps
        .map(
          (messageMap) => ChatMessage(
            id: messageMap['id'] as String,
            content: messageMap['content'] as String,
            type: MessageType.values[messageMap['type'] as int],
            sender: MessageSender.values[messageMap['sender'] as int],
            timestamp: DateTime.fromMillisecondsSinceEpoch(
              messageMap['timestamp'] as int,
            ),
            fileName: messageMap['file_name'] as String?,
            fileSize: messageMap['file_size'] as String?,
            filePath: messageMap['file_path'] as String?,
            isLoading: (messageMap['is_loading'] as int) == 1,
          ),
        )
        .toList();
  }

  Future<void> deleteConversation(String conversationId) async {
    final db = await database;

    await db.transaction((txn) async {
      await txn.delete(
        'messages',
        where: 'conversation_id = ?',
        whereArgs: [conversationId],
      );

      await txn.delete(
        'conversations',
        where: 'id = ?',
        whereArgs: [conversationId],
      );
    });
  }

  Future<void> updateConversation(ChatConversation conversation) async {
    final db = await database;

    await db.update(
      'conversations',
      {
        'title': conversation.title,
        'updated_at': conversation.updatedAt.millisecondsSinceEpoch,
        'is_pinned': conversation.isPinned ? 1 : 0,
      },
      where: 'id = ?',
      whereArgs: [conversation.id],
    );
  }

  Future<void> addMessageToConversation(
    String conversationId,
    ChatMessage message,
  ) async {
    final db = await database;

    await db.transaction((txn) async {
      await txn.insert('messages', {
        'id': message.id,
        'conversation_id': conversationId,
        'content': message.content,
        'type': message.type.index,
        'sender': message.sender.index,
        'timestamp': message.timestamp.millisecondsSinceEpoch,
        'file_name': message.fileName,
        'file_size': message.fileSize,
        'file_path': message.filePath,
        'is_loading': message.isLoading ? 1 : 0,
      });

      await txn.update(
        'conversations',
        {'updated_at': DateTime.now().millisecondsSinceEpoch},
        where: 'id = ?',
        whereArgs: [conversationId],
      );
    });
  }

  Future<List<ChatConversation>> searchConversations(String query) async {
    if (query.trim().isEmpty) {
      return await loadConversations();
    }

    final db = await database;

    final conversationMaps = await db.rawQuery(
      '''
      SELECT DISTINCT c.* FROM conversations c
      LEFT JOIN messages m ON c.id = m.conversation_id
      WHERE c.title LIKE ? OR m.content LIKE ?
      ORDER BY c.is_pinned DESC, c.updated_at DESC
    ''',
      ['%$query%', '%$query%'],
    );

    final conversations = <ChatConversation>[];

    for (final conversationMap in conversationMaps) {
      final messages = await _loadMessagesForConversation(
        conversationMap['id'] as String,
      );

      conversations.add(
        ChatConversation(
          id: conversationMap['id'] as String,
          title: conversationMap['title'] as String,
          createdAt: DateTime.fromMillisecondsSinceEpoch(
            conversationMap['created_at'] as int,
          ),
          updatedAt: DateTime.fromMillisecondsSinceEpoch(
            conversationMap['updated_at'] as int,
          ),
          isPinned: (conversationMap['is_pinned'] as int) == 1,
          messages: messages,
        ),
      );
    }

    return conversations;
  }

  Future<void> closeDatabase() async {
    final db = await database;
    await db.close();
    _database = null;
  }

  Future<void> clearAllData() async {
    final db = await database;

    await db.transaction((txn) async {
      await txn.delete('messages');
      await txn.delete('conversations');
    });
  }
}
