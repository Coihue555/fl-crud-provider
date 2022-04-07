import 'package:flutter/material.dart';
import 'package:fl_crud_provider/providers/db_provider.dart';

class ActividadListProvider extends ChangeNotifier {
  List<ActividadModel> datos = [];
  ActividadModel datoSeleccionado = ActividadModel(nombre: '', descripcion: '');

  Future<ActividadModel> nuevaActividad(
      String nombre, String descripcion, int edadMin, int edadMax) async {
    final nuevoDato = ActividadModel(
        nombre: nombre,
        descripcion: descripcion,
        edadMin: edadMin,
        edadMax: edadMax);
    final id = await DBProvider.db.nuevoDato(nuevoDato);
    //asignar el ID de la base de datos al modelo
    nuevoDato.id = id;

    datos.add(nuevoDato);
    notifyListeners();

    return nuevoDato;
  }

  Future<List<ActividadModel>> cargarTodos() async {
    //final datos = await DBProvider.db.getTodos();
    datos = await DBProvider.db.getTodos();
    notifyListeners();
    return datos;
  }

  cargarDatosByNombre(String nombre) async {
    datoSeleccionado = await DBProvider.db.getDatosByNombre(nombre);

    notifyListeners();
  }

  borrarLista() async {
    await DBProvider.db.deleteAllActividades();
    datos = [];
    notifyListeners();
  }

  borrarDatoById(int? id) async {
    await DBProvider.db.deleteDato(id!);
    cargarTodos();
  }

  void getDatosById(int id) async {
    datoSeleccionado = await DBProvider.db.getDatosById(id);

    notifyListeners();
  }
}
