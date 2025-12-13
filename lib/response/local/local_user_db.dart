import 'package:easy_localization/easy_localization.dart';
import 'package:saiyan_official/model/local/User/user_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class LocalUserDb {
  static final LocalUserDb _instance = LocalUserDb._internal();
  factory LocalUserDb() => _instance;

  static Database? _database;

  LocalUserDb._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'users.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
      onUpgrade: updateDatabase,
    );
  }

  Future<void> updateDatabase(
    Database db,
    int oldVersion,
    int newVersion,
  ) async {}

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE Users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        username TEXT UNIQUE,
        nickname TEXT,
        email TEXT,
        password TEXT,
        profile_picture TEXT,
        virtualized INTEGER DEFAULT 0
      )
    ''');
  }

  // User ekleme
  Future<bool> insertUser(LocalUserModel user) async {
    final db = await database;
    try {
      int result = await db.insert(
        'Users',
        user.toMap(),
        conflictAlgorithm: ConflictAlgorithm.ignore,
      );
      return result > 0;
    } catch (e) {
      return false;
    }
  }

  // User silme
  Future<int> deleteUser(String username) async {
    final db = await database;
    return await db.delete(
      'Users',
      where: 'username = ?',
      whereArgs: [username],
    );
  }

  // User güncelleme
  Future<int> updateUser(String username, String arg, String newData) async {
    final db = await database;
    return await db.update(
      'Users',
      {arg: newData},
      where: 'username = ?',
      whereArgs: [username],
    );
  }

  // Tüm Users çekme
  Future<List<LocalUserModel>> getAllUsers() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('Users');
    return maps.map((map) => LocalUserModel.fromMap(map)).toList();
  }

  // Kullanıcı arama
  Future<List<LocalUserModel>> searchUsers(String keyword) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'Users',
      where: 'username LIKE ?',
      whereArgs: ['%$keyword%'],
    );
    return maps.map((map) => LocalUserModel.fromMap(map)).toList();
  }

  // Kullanıcı arama
  Future<String> loginControl(String username, String password) async {
    final db = await database;
    final List<Map<String, dynamic>> result = await db.query(
      'Users',
      where: 'username = ?',
      whereArgs: [username],
    );

    if (result.isEmpty) {
      return tr("dbUserNotFound");
    } else {
      if (password == result[0]["password"]) {
        return "success";
      } else {
        return tr("dbPasswordIsIncorrect");
      }
    }
  }

  Future<void> updateProfilePicture(int username, String imagePath) async {
    final db = await database;

    await db.update(
      'Users',
      {'profile_picture': imagePath},
      where: 'username = ?',
      whereArgs: [username],
    );
  }
}
