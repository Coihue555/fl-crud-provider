// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:fl_crud_provider/providers/providers.dart';



class ActividadScreen extends StatefulWidget {
  @override
  State<ActividadScreen> createState() => _ActividadScreenState();
}

class _ActividadScreenState extends State<ActividadScreen> {
  @override
  Widget build(BuildContext context) {
    final elementoSeleccionado = Provider.of<ActividadListProvider>(context);

    return Scaffold(
        appBar: AppBar(
          title: const Text('Nueva Actividad'),
        ),
        body: SingleChildScrollView(
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Form(
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Nombre',
                        ),
                        initialValue:'',
                        onChanged: (value) {
                          elementoSeleccionado.datoSeleccionado.nombre = value;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Descripcion',
                        ),
                        initialValue:'',
                        onChanged: (value) {
                          elementoSeleccionado.datoSeleccionado.descripcion = value;
                        },
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Edad minima recomendada',
                        ),
                        initialValue:'',
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}'))
                        ],
                        onChanged: (value) {
                          elementoSeleccionado.datoSeleccionado.edadMin =  int.tryParse(value) ?? 0;
                        },
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Edad maxima recomendada',
                        ),
                        initialValue:'',
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}'))
                        ],
                        onChanged: (value) {
                          elementoSeleccionado.datoSeleccionado.edadMax = int.tryParse(value) ?? 0;
                        },
                      ),
                      ElevatedButton(
                          child: const SizedBox(
                              width: double.infinity,
                              child: Center(child: Text('Guardar'))),
                          onPressed: () {
                            elementoSeleccionado.nuevaActividad(
                                elementoSeleccionado.datoSeleccionado.nombre,
                                elementoSeleccionado.datoSeleccionado.descripcion,
                                elementoSeleccionado.datoSeleccionado.edadMin,
                                elementoSeleccionado.datoSeleccionado.edadMax);
                            setState(() {});
                            Navigator.pushReplacementNamed(context, 'Home');
                            
                          }),
                    ],
                  ),
                ))));
  }
}

