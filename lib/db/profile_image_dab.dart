import 'package:sqflite/sqflite.dart' as db;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqlite_api.dart';

class ProfileImageDb {
  static Future<Database> database() async {
    final dbPath = await db.getDatabasesPath();
    return db.openDatabase(path.join(dbPath, 'profileImage.db'),
        onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE profile_image (id TEXT PRIMARY KEY, image TEXT');
    }, version: 1);
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await ProfileImageDb.database();
    db.insert(table, data, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, dynamic>>> fetchUserProfileImage(
      String table) async {
    final db = await ProfileImageDb.database();
    return db.query(table);
  }
}
