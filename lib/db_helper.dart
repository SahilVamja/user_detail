import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';

//
// class DatabaseHelper {
//   static DatabaseHelper? _databaseHelper;
//   static Database? _database;
//
//   String userTable = 'note_table';
//   String colFirstName = 'firstName';
//   String colLastName = 'LastName';
//   String colPhoneNumber = 'PhoneNumber';
//   String colEmail = 'Email';
//   String colAddress = 'Address';
//
//   DatabaseHelper._createInstance();
//
//   factory DatabaseHelper() {
//     _databaseHelper ??= DatabaseHelper._createInstance();
//     return _databaseHelper!;
//   }
//
//   Future<Database> initializeDatabase() async {
//     Directory directory = await getApplicationDocumentsDirectory();
//     String path = '${directory.path}user.db';
//
//     var userDatabase = await openDatabase(path, version: 1, onCreate: _createDB);
//     return userDatabase;
//   }
//
//   Future<Database> get database async {
//
//     if (_database == null) {
//       _database = await initializeDatabase();
//     }
//     return _database!;
//   }
//
//   void _createDB(Database db, int newVersion) async{
//     await db.execute('CREATE TABLE $userTable($colFirstName TEXT, $colLastName TEXT, '
//         '$colPhoneNumber INTEGER, $colEmail TEXT, $colAddress TEXT)');
//   }
//
//
//   Future<List<Map<String, dynamic>>> getNoteMapList() async {
//     Database db = await database;
//
//     var result = await db.query(userTable, orderBy: '$colPhoneNumber ASC');
//     return result;
//   }
//
//   // Insert User Data
//   Future<int> insertNote(Users users) async {
//     Database db = await database;
//     var result = await db.insert(userTable, users.toMap());
//     return result;
//   }
//
//
// }

class DataBaseHelper {
  static const _databaseName = "userDetails";
  static const _databaseVersion = 1;

  static const table = "user_table";

  static const colFirstName = "firstName";
  static const colLastName = "lastName";
  static const colPhoneNumber = "phoneNumber";
  static const colEmail = "email";
  static const colAddress = "address";

  static Database? _database;

  DataBaseHelper._privateConstructor();

  static DataBaseHelper instance = DataBaseHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDataBase();
    return _database!;
  }

  _initDataBase() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(''' CREATE TABLE $table(
        $colFirstName TEXT NOT NULL,
        $colLastName TEXT NOT NULL,
        $colPhoneNumber INTEGER,
        $colEmail TEXT NOT NULL,
        $colAddress TEXT NOT NULL
      ) ''');
  }

  // INSERT USER DATA

  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(table, row);
  }

  // DELETE USER

  Future<int> delete(int id) async {
    Database db = await instance.database;
    var res = await db.delete(table, where: "id = ?", whereArgs: [id]);
    return res;
  }
}
