import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/user_profile_model.dart';
import '../models/child_profile_model.dart';

class ProfileDatabaseHelper {
  static const _databaseName = 'profile_database.db';
  static const _databaseVersion = 1;

  static const tableUserProfile = 'user_profiles';
  static const tableChildProfile = 'child_profiles';

  ProfileDatabaseHelper._privateConstructor();
  static final ProfileDatabaseHelper instance =
      ProfileDatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $tableUserProfile(
        id TEXT PRIMARY KEY,
        cardIdNumber TEXT NOT NULL,
        fullName TEXT NOT NULL,
        dateOfBirth TEXT NOT NULL,
        gender TEXT NOT NULL,
        phoneNumber TEXT NOT NULL,
        email TEXT NOT NULL,
        address TEXT NOT NULL,
        lastUpdated TEXT,
        childrenIds TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE $tableChildProfile(
        id TEXT PRIMARY KEY,
        parentId TEXT NOT NULL,
        fullName TEXT NOT NULL,
        dateOfBirth TEXT NOT NULL,
        gender TEXT NOT NULL,
        schoolName TEXT,
        grade TEXT,
        healthData TEXT NOT NULL
      )
    ''');
  }

  Future<int> insertUserProfile(UserProfileModel profile) async {
    Database db = await database;
    return await db.insert(tableUserProfile, profile.toJson());
  }

  Future<int> updateUserProfile(UserProfileModel profile) async {
    Database db = await database;
    return await db.update(
      tableUserProfile,
      profile.toJson(),
      where: 'id = ?',
      whereArgs: [profile.id],
    );
  }

  Future<UserProfileModel?> getUserProfile(String id) async {
    Database db = await database;
    List<Map<String, dynamic>> maps = await db.query(
      tableUserProfile,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return UserProfileModel.fromJson(maps.first);
    }
    return null;
  }

  Future<UserProfileModel?> getUserProfileByCardId(String cardIdNumber) async {
    Database db = await database;
    List<Map<String, dynamic>> maps = await db.query(
      tableUserProfile,
      where: 'cardIdNumber = ?',
      whereArgs: [cardIdNumber],
    );

    if (maps.isNotEmpty) {
      return UserProfileModel.fromJson(maps.first);
    }
    return null;
  }

  Future<int> insertChildProfile(ChildProfileModel profile) async {
    Database db = await database;
    return await db.insert(tableChildProfile, profile.toJson());
  }

  Future<int> updateChildProfile(ChildProfileModel profile) async {
    Database db = await database;
    return await db.update(
      tableChildProfile,
      profile.toJson(),
      where: 'id = ?',
      whereArgs: [profile.id],
    );
  }

  Future<List<ChildProfileModel>> getChildrenProfiles(String parentId) async {
    Database db = await database;
    List<Map<String, dynamic>> maps = await db.query(
      tableChildProfile,
      where: 'parentId = ?',
      whereArgs: [parentId],
    );

    return List.generate(maps.length, (i) {
      return ChildProfileModel.fromJson(maps[i]);
    });
  }

  Future<int> deleteChildProfile(String id) async {
    Database db = await database;
    return await db.delete(tableChildProfile, where: 'id = ?', whereArgs: [id]);
  }
}
