import 'package:calendarioprova/models/Evento.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  static Database? _db;
  static final int _version = 1;
  static final String _tableName = "evento";

  static Future<void> initDb() async {
    if (_db != null) {
      return;
    }
    try {
      String _path = await getDatabasesPath() + 'evento.db';
      _db = await openDatabase(
        _path,
        version: _version,
        onCreate: ((db, version) {
          print('Criar um novo');
          return db.execute(
            "CREATE TABLE  $_tableName("
            "id integer PRIMARY KEY AUTOINCREMENT,"
            "titulo STRING, data STRING, "
            "horaInicial STRING, horaFinal STRING, "
            "local String, cor INTEGER,"
            "coordenador String, curso STRING,"
            "estaconcluido INTEGER"
            ")",
          );
        }),
      );
    } catch (e) {
      print(e);
    }
  }

  static Future<int> insert(Evento? evento) async {
    print('função de inserir cancelada');
    return await _db?.insert(_tableName, evento!.toJson()) ?? 1;
  }

  static Future<List<Map<String, dynamic>>> query() async {
    return await _db!.query(_tableName);
  }

  static delete(Evento evento)async {
   return await _db!.delete(_tableName, where: 'id=?', whereArgs: [evento.id]);
  }
}
