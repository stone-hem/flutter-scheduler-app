import 'package:scheduler/models/task.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  static Database? _db;
  static final int _version = 1;
  static final String _tableName = 'tasks';
  static Future<void> initDB() async {
    if (_db != null) {
      return;
    }
    try {
      String _path = await getDatabasesPath() + 'tasks.db';
      _db = await openDatabase(
        _path,
        version: _version,
        onCreate: (db, version) {
          print('creating a new db');
          return db.execute(
            "CREATE TABLE $_tableName("
            "id INTEGER PRIMARY KEY AUTOINCREMENT,"
            "title STRING , note TEXT, date STRING,"
            "startTime STRING ,endTime STRING,"
            "remind INTEGER ,repeat INTEGER,"
            "color INTEGER,"
            "isCompleted INTEGER)",
          );
        },
      );
    } catch (e) {
      print(e);
    }
  }

  static Future<int> insert(Task? task) async {
    print("insert method called");
    return await _db?.insert(_tableName, task!.toJson())??1;
  }
}
