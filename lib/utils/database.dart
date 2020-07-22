import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static Database _db;

  Future<Database> get db async {
    if(_db != null){
      return _db;
    }
    _db = await initDatabase();
    return _db;
  }

  Future<Database> initDatabase() async{
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'customer.db');

    Database db = await openDatabase(path, version: 1,
    onCreate: (Database db, int version) async {
    // When creating the db, create the table
    await db.execute( 'CREATE TABLE customers (id INTEGER PRIMARY KEY, name TEXT)');
    });
    return db;
  }
}