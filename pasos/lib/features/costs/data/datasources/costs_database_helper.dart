import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/installment_model.dart';
import '../models/expense_model.dart';

class CostsDatabaseHelper {
  static final CostsDatabaseHelper _instance = CostsDatabaseHelper._internal();
  factory CostsDatabaseHelper() => _instance;
  CostsDatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'costs.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE installments(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            totalFees REAL NOT NULL,
            paidAmount REAL NOT NULL,
            paymentDate TEXT NOT NULL,
            paymentMethod TEXT NOT NULL,
            remainingAmount REAL NOT NULL,
            dueDate TEXT NOT NULL,
            isPaid INTEGER NOT NULL,
            createdAt TEXT NOT NULL
          )
        ''');

        await db.execute('''
          CREATE TABLE expenses(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            reason TEXT NOT NULL,
            amount REAL NOT NULL,
            dueDate TEXT NOT NULL,
            category TEXT NOT NULL,
            isPaid INTEGER NOT NULL,
            createdAt TEXT NOT NULL
          )
        ''');
      },
    );
  }

  // Installments operations
  Future<int> insertInstallment(InstallmentModel installment) async {
    final db = await database;
    return await db.insert('installments', installment.toMap());
  }

  Future<List<InstallmentModel>> getAllInstallments() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('installments');
    return List.generate(maps.length, (i) => InstallmentModel.fromMap(maps[i]));
  }

  Future<int> updateInstallment(InstallmentModel installment) async {
    final db = await database;
    return await db.update(
      'installments',
      installment.toMap(),
      where: 'id = ?',
      whereArgs: [installment.id],
    );
  }

  Future<int> deleteInstallment(int id) async {
    final db = await database;
    return await db.delete('installments', where: 'id = ?', whereArgs: [id]);
  }

  // Expenses operations
  Future<int> insertExpense(ExpenseModel expense) async {
    final db = await database;
    return await db.insert('expenses', expense.toMap());
  }

  Future<List<ExpenseModel>> getAllExpenses() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('expenses');
    return List.generate(maps.length, (i) => ExpenseModel.fromMap(maps[i]));
  }

  Future<int> updateExpense(ExpenseModel expense) async {
    final db = await database;
    return await db.update(
      'expenses',
      expense.toMap(),
      where: 'id = ?',
      whereArgs: [expense.id],
    );
  }

  Future<int> deleteExpense(int id) async {
    final db = await database;
    return await db.delete('expenses', where: 'id = ?', whereArgs: [id]);
  }
}
