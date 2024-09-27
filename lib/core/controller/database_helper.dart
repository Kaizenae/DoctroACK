import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';

import '../general_models/notify_model.dart';

class DatabaseHelper {
  static late Database database;

  static Future<void> initializeDatabase() async {
    database = await openDatabase(
      join(await getDatabasesPath(), 'notification.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE notification(id INTEGER PRIMARY KEY, title TEXT, body TEXT, time TEXT)',
        );
      },
      version: 1,
    );
  }

  static Future<void> insertNotification(NotifyModel notification) async {
    try {
      await database.insert(
        'notification',
        notification.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      // ignore: empty_catches
    } catch (e) {}
  }
}
