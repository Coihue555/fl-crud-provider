import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

export 'package:fl_crud_provider/models/actividad_model.dart';
import 'package:fl_crud_provider/models/actividad_model.dart';

class DBProvider {
  static Database? _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database?> get database async {
    if (_database != null) return _database;

    _database = await initDB();

    return _database;
  }

  Future<dynamic> initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'ActividadesDB.db');

    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute('''
          CREATE TABLE Actividades(
            id INTEGER PRIMARY KEY,
            nombre TEXT,
            descripcion TEXT,
            edadMin INTEGER,
            edadMax INTEGER
          )

        ''');
    });
  }

  Future<int> nuevoDato(ActividadModel nuevoDato) async {
    final id = nuevoDato.id;
    final nombre = nuevoDato.nombre;
    final descripcion = nuevoDato.descripcion;
    final edadMin = nuevoDato.edadMin;
    final edadMax = nuevoDato.edadMax;

    //verificar la db
    final db = await database;

    final res = await db!.rawInsert('''
      INSERT INTO Actividades(id, nombre, descripcion, edadMin, edadMax)
        VALUES( $id, '$nombre', '$descripcion', '$edadMin', '$edadMax' )
      ''');

    return res;
  }

  Future<int> nuevoDatoRaw(ActividadModel nuevoDato) async {
    final db = await database;
    final res = await db!.insert('Actividades', nuevoDato.toJson());
    //id del ultimo registro
    return res;
  }

  Future<ActividadModel> getDatosById(int id) async {
    final db = await database;
    final res = await db!.query('Actividades', where: 'id = ?', whereArgs: [id]);

    return res.isNotEmpty ? ActividadModel.fromJson(res.first) : ActividadModel(nombre: '', descripcion: '');
  }

  Future<List<ActividadModel>> getTodos() async {
    final db = await database;
    final res = await db!.query('Actividades', orderBy: 'id DESC');

    return res.isNotEmpty ? res.map((s) => ActividadModel.fromJson(s)).toList() : [];
  }

    Future<ActividadModel> getDatosByNombre(String nombre) async {
      final db = await database;
      final res = await db!.rawQuery('''
        SELECT * FROM Actividades WHERE nombre = '$nombre'
      ''');

      return res.isNotEmpty
        ? res.map((s) => ActividadModel.fromJson(s)).toList().first
        : ActividadModel(nombre: '', descripcion: '');
    }

  Future<int> updateDato(ActividadModel nuevoDato) async {
    final db = await database;
    final res = await db!.update('Actividades', nuevoDato.toJson(),
        where: 'id = ?', whereArgs: [nuevoDato.id]);

    return res;
  }

  Future<int> updateItem(int id, String nombre, String? descripcion, int edadMin, int edadMax) async {
    final db = await database;

    final data = {
      'nombre': nombre,
      'descripcion': descripcion,
      'edadMin': edadMin,
      'edadMax': edadMax
    };

    final result =
        await db!.update('Actividades', data, where: "id = ?", whereArgs: [id]);
    return result;
  }

  Future<ActividadModel?> getScansById(int id) async {
    final db = await database;
    final res = await db!.query('Actividades', where: 'id = ?', whereArgs: [id]);

    return res.isNotEmpty ? ActividadModel.fromJson(res.first) : null;
  }

  Future<int> updateScan(ActividadModel nuevoScan) async {
    final db = await database;
    final res = await db!.update('Actividades', nuevoScan.toJson(),
        where: 'id = ?', whereArgs: [nuevoScan.id]);

    return res;
  }

  Future<int> deleteDato(int id) async {
    final db = await database;
    final res = await db!.delete('Actividades', where: 'id = ?', whereArgs: [id]);
    return res;
  }

  Future<int> deleteAllActividades() async {
    final db = await database;
    final res = await db!.delete('Actividades');
    return res;
  }
}
