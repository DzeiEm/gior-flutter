import 'package:sqflite/sqflite.dart' as db;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqlite_api.dart';

class Mobdb {
  static Future<db.Database> database() async {
    final dbPath = await db.getDatabasesPath(); // kur bus saugoma
    return db.openDatabase(path.join(dbPath, 'galleryImages.db'), onCreate: (
      db,
      version,
    ) {
      return db.execute(
          'CREATE TABLE gallery_images(id TEXT PRIMARY KEY, title TEXT, image TEXT)');
    }, version: 1);
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await Mobdb.database();
    db.insert(table, data, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, dynamic>>> fetchData(String table) async {
    final db = await Mobdb.database();
    return db.query(table);
  }
}
