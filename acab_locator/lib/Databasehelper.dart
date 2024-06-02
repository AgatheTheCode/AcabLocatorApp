import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  late Database _database;

  Future<void> initDatabase() async {
    _database = await openDatabase(
      join(await getDatabasesPath(), 'example_database.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE example_table(id INTEGER PRIMARY KEY, name TEXT, age INTEGER)',
        );
      },
      version: 1,
    );
  }

  Future<void> insertData(String name, int age) async {
    await _database.insert(
      'example_table',
      {'name': name, 'age': age},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>> getData() async {
    return await _database.query('example_table');
  }

  Future<void> closeDatabase() async {
    await _database.close();
  }
}