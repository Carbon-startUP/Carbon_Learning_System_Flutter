import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/user_profile_model.dart';
import '../models/child_profile_model.dart';
import '../models/health_data_model.dart';

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
        cardIdNumber TEXT NOT NULL UNIQUE,
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
        cardId INTEGER,
        dateOfBirth TEXT NOT NULL,
        gender TEXT NOT NULL,
        religion TEXT,
        nationality TEXT,
        braceletId INTEGER,
        email TEXT,
        age INTEGER,
        phoneNumber INTEGER,
        healthData TEXT NOT NULL
      )
    ''');

    await _seedDatabase(db);
  }

  Future<void> _seedDatabase(Database db) async {
    final healthData = HealthDataModel(
      bloodType: 'A+',
      chronicConditions: ['Asthma'],
      currentMedications: ['Ventolin'],
    );

    final child1 = ChildProfileModel(
      id: 'child-001',
      parentId: 'user-123',
      fullName: 'علي أحمد',
      cardId: 123456789,
      dateOfBirth: DateTime(2015, 5, 10),
      gender: 'Male',
      religion: 'Islam',
      nationality: 'Saudi',
      email: 'ali.ahmed@example.com',
      age: 10,
      phoneNumber: 987654321,
      braceletId: 9876,
      healthData: healthData,
    );

    final user1 = UserProfileModel(
      id: 'user-123',
      cardIdNumber: '1098765432',
      fullName: 'أحمد عبدالله',
      dateOfBirth: DateTime(1985, 1, 15),
      gender: 'Male',
      phoneNumber: '0501234567',
      email: 'ahmed.abdullah@example.com',
      address: '123 Main St, Riyadh',
      childrenIds: ['child-001'],
    );

    await db.insert(tableUserProfile, user1.toJson());
    await db.insert(tableChildProfile, child1.toJson());

    print('✅ Database seeded with initial test data.');
  }

  Future<int> insertUserProfile(UserProfileModel profile) async {
    Database db = await database;
    return await db.insert(
      tableUserProfile,
      profile.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
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
      whereArgs: [cardIdNumber.trim()],
    );

    if (maps.isNotEmpty) {
      return UserProfileModel.fromJson(maps.first);
    }
    return null;
  }

  Future<int> insertChildProfile(ChildProfileModel profile) async {
    Database db = await database;
    return await db.insert(
      tableChildProfile,
      profile.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
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
