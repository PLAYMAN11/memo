import 'dart:io' as io;
import 'package:memo/db/user.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart' as iguana;
import 'package:path/path.dart';
class Sqlite {

  static Future<iguana.Database> db() async {
    final io.Directory appDocumentsDir = await getApplicationDocumentsDirectory();
    String ruta = join(appDocumentsDir.path, "databases", "Users.db");
    return iguana.openDatabase(
      ruta,
      version: 1,
      singleInstance: true,onCreate: (db, version)async {
      await createDb(db);
    },);
  }

  static Future<void> createDb(iguana.Database db) async {
    const String sql = """
        create table Users (
        id integer primary key not null,
        wins integer not null,
        loses integer not null,
        difficulty text not null,
        date text not null
        )
       """;
    await db.execute(sql);
  }
  static Future<List <User>?> consulta() async {
    final iguana.Database db = await Sqlite.db();
    final List<Map<String, dynamic>> query = await db.query(
      "Users",
      orderBy: "id DESC",

    );
      return  query.map(
            (e) {
          return User.deMap(e);
        },
      ).toList();
  }

  static Future<int> add(User user) async {
    final iguana.Database db = await Sqlite.db();

    return await db.insert(
      "Users",
      user.toMap(),
      conflictAlgorithm: iguana.ConflictAlgorithm.replace,
    );
  }
  static Future<void> del(int i) async{
    final iguana.Database db = await Sqlite.db();
    await db.delete("Users", where: "id =?", whereArgs: [i]);
  }
}