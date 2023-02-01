// import 'dart:io';
//
// import 'package:path/path.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:sqflite/sqflite.dart';
//
// class BDProvider {
//   // BDProvider._();
//
//   static BDProvider? _instance;
//   static Database? _db;
//
//   static Future<Database?> get instance async{
//     if (_db != null) return _db;
//     _instance = BDProvider._();
//     _db = await _instance!.initDB();
//     return _db;
//   }
//
//   ///getApplicationDocumentsDirectory يعني هاتلي المسار تع حفظ الملفات حسب بيئة العمل الي انا شغال عليها
//   /// join اعمل ربط على الباث الي حبتو من المسار مع اسم الداتا بيز تعتنا
//   /// واعمل عليها open
//   Future<Database> initDB() async {
//     Directory directory = await getApplicationDocumentsDirectory();
//     String path = join(directory.path, 'app_db.sql');
//     return await openDatabase(path,
//         version: 1,
//         onCreate: (Database db,
//             int version,) async {
//           db.execute("CREATE TABLE notes ("
//               "id INTEGER PRIMARY KEY AUTOINCREMENT,"
//               "title TEXT,"
//                   "details TEXT"
//                   ")");
//         },
//         onOpen: (Database db) {},
//         onUpgrade: (Database db, int oldVersion, int newVersion) {},
//         onDowngrade: (Database db, int oldVersion, int newVersion) {});
//   }
// }
