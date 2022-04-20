import "dart:io" as io;
import "package:path/path.dart";
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class SqliteDB {
  static final SqliteDB _instance = new SqliteDB.internal();
  var age, id;

  factory SqliteDB() => _instance;
  static Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  SqliteDB.internal();

  /// Initialize DB
  initDb() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "myDatabase.db");
    var taskDb = await openDatabase(path, version: 1);

    return taskDb;
  }

  /// Creates user Table
  Future createUserTable() async {
    var dbClient = await SqliteDB().db;
    var res = await dbClient.execute("""
      CREATE TABLE User(
        id TEXT PRIMARY KEY,
        name TEXT,
        email TEXT,
        age INTEGER
      )""");
    return res;
  }

  /// Add user to the table
  Future putUser() async {
    /// User data
    dynamic user = {
      "id": "johndoe94",
      "name": "John Doe",
      "email": "abcd@example.com",
      "age": 26
    };

    /// Adds user to table
    final dbClient = await SqliteDB().db;
    int res = await dbClient.insert("User", user);
    return res;
  }

  Future getAll() async {
    var dbClient = await SqliteDB().db;
    final res = await dbClient.rawQuery("SELECT * FROM User");
    return res;
  }

  /// Simple query with WHERE raw query
  Future getAdults() async {
    var dbClient = await SqliteDB().db;
    final res =
        await dbClient.rawQuery("SELECT id, name FROM User WHERE age > 18");
    return res;
  }

  /// Get all using sqflite helper
  Future getAllUsingHelper() async {
    var dbClient = await SqliteDB().db;
    final res = await dbClient.query('User');
    return res;
  }

  /// Simple query with sqflite helper
  Future getAdultsUsingHelper() async {
    var dbClient = await SqliteDB().db;
    final res = await dbClient.query('User',
        columns: ['id', 'name'], where: '$age > ?', whereArgs: [18]);
    return res;
  }

  /// Update using raw query
  /// example :-
  /// var newAge = 28
  /// var id = "johndoe"
  Future update(newAge, id) async {
    var dbClient = await SqliteDB().db;
    var res = await dbClient.rawQuery(""" UPDATE User 
        SET age = newAge WHERE id = '$id'; """);
    return res;
  }

  /// Update using sqflite helper
  /// newData example :-
  /// var newData = {"id": "johndoe92", "name": "John Doe", "email":"abc@example.com", "age": 28}
  Future updateUsingHelper(newData) async {
    var dbClient = await SqliteDB().db;
    var res = await dbClient.update('User', newData,
        where: '$id = ?', whereArgs: newData['id']);
    return res;
  }

  /// Delete data using raw query
  Future delete(id) async {
    var dbClient = await SqliteDB().db;
    var res = await dbClient.rawQuery("""DELETE FROM User 
                    WHERE id = '$id'; """);
    return res;
  }

  /// Delete data using sqflite helper
  Future deleteUsingHelper(id) async {
    var dbClient = await SqliteDB().db;
    var res = await dbClient.delete('User', where: 'id = ?', whereArgs: [id]);
    return res;
  }

  /// Count number of tables in DB
  Future countTable() async {
    var dbClient = await db;
    var res =
        await dbClient.rawQuery("""SELECT count(*) as count FROM sqlite_master
         WHERE type = 'table' 
         AND name != 'android_metadata' 
         AND name != 'sqlite_sequence';""");
    return res[0]['count'];
  }
}
