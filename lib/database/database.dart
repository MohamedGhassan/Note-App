import 'dart:core';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../models/notes.dart';

 late Database database;
List<Map> tasks = [];

class DataBase {
  static const tableName = 'notes';
  static Future _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }

  // NoteController._();

  // static NoteController? get instance {
  //   if (_instance != null) return _instance;
  //
  //   _instance = NoteController._();
  //   return _instance;
  // }

   initDB() async {
    await openDatabase(
        "note.db",
        version: 1,
        onConfigure: _onConfigure,
        onCreate: (db, version) async {
          print("Database is Created");
          try{
            await db.execute("""
            create table $tableName(
             id  INTEGER PRIMARY KEY AUTOINCREMENT,
             title STRING,note TEXT,date STRING,
             startTime STRING,endTime STRING,
             repeat STRING,remind int,
             color int,isCompleted int
            );
            """);
          }catch(e)
          {
            print("error is " + e.toString());
          }
          },
      onOpen: (db){},
    ).then((value)
    {
      database = value;
      print("database is open");
    });
  }

  // @override
  // Future<bool> create(Note object) async {
  //   _database = await _database.instance;
  //   int insertedId =
  //       await _database!.insert('${tableName}', object.toMap(withId: false));
  //   return insertedId != 0 ? true : false;
  // }

  Future<int> insertPersonDataToDB(Note t) async {
    return await database.insert(tableName, t.toMap());
  }

  Future<List<Map>> getTableDataFromDb() async {
    print("table is $tableName");
    String sql = "select * from $tableName";
    return await database.rawQuery(sql);
  }

  Future<List<Map>> getItemDataFromDB(int  id) async{
    print("table is $tableName");
    String sql = "select from ${tableName} where id=$id";
    return await database.rawQuery(sql);
  }

  // @override
  Future<void> update(Note t) async {
    await database.rawUpdate(
        "UPDATE $tableName set isCompleted= 1 WHERE id = ${t.id}");
  }

  void deleteAll() async {
    await database.delete(tableName);
  }

  @override
  void deleteItemFromDB(
      int id,
      ) async {
    await database.transaction((txn) async {
      database.rawDelete('DELETE FROM $tableName WHERE id = $id').then((value) {
        print("item $id in table $tableName deleted successfully");
      }).catchError((error) {
        print("deleting item $id in table $tableName error: $error");
      });
    });
  }

  // DateTime selectedData = DateTime.now();
}

// import 'dart:core';
// import 'package:sqflite/sqflite.dart';
// import 'package:sqflite_app/database/db_provider.dart';
// import '../interfaces/database_operations.dart';
// import '../models/notes.dart';
//
// class NoteController extends DataBaseOperations<Note> {
//   Database? _database;
//
//   static NoteController? _instance;
//
//   NoteController._();
//
//   static NoteController? get instance {
//     if (_instance != null) return _instance;
//
//     _instance = NoteController._();
//     return _instance;
//   }
//
//   @override
//   Future<bool> create(Note object) async {
//     _database = await BDProvider.instance;
//     int insertedId =
//     await _database!.insert('notes', object.toMap(withId: false));
//     return insertedId != 0 ? true : false;
//   }
//
//   @override
//   Future<bool> delete(int id) async {
//     _database = await BDProvider.instance;
//     int deletedRowsCount =
//     await _database!.delete('notes', where: "id = ?", whereArgs: [id]);
//     return deletedRowsCount > 0;
//   }
//
//   @override
//   Future<List<Note>> read() async {
//     _database = await BDProvider.instance;
//     var data = await _database!.query('notes');
//     List<Note> notes = data.map((rowMap) => Note.fromMap(rowMap)).toList();
//     return notes.isNotEmpty ? notes : [];
//   }
//
//   @override
//   Future update(Note object) async {
//     _database = await BDProvider.instance;
//     int updatedRowsCount = await _database!.update(
//         'notes', object.toMap(withId: false),
//         where: "id = ?", whereArgs: [object.id]);
//     return updatedRowsCount > 0;
//   }
//
//   DateTime selectedData = DateTime.now();
//
// }
