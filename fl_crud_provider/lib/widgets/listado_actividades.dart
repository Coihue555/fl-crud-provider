import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:fl_crud_provider/providers/providers.dart';

class ActividadesListTiles extends StatefulWidget {
  const ActividadesListTiles({Key? key}) : super(key: key);

  @override
  State<ActividadesListTiles> createState() => _ActividadesListTilesState();
}

class _ActividadesListTilesState extends State<ActividadesListTiles> {
  @override
  Widget build(BuildContext context) {
    final actividadListProvider =
        Provider.of<ActividadListProvider>(context, listen: false);

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(top: 20),
              width: double.infinity,
              child: FutureBuilder<List<ActividadModel>>(
                future: actividadListProvider.cargarTodos(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (_, i) => Dismissible(
                              key: UniqueKey(),
                              background: Container(
                                color: Colors.red,
                              ),
                              onDismissed: (DismissDirection direction) {
                                Provider.of<ActividadListProvider>(context,
                                        listen: false)
                                    .borrarDatoById(snapshot.data![i].id);
                              },
                              child: ListTile(
                                  leading: Icon(Icons.sports_baseball_outlined,
                                      color: Theme.of(context).primaryColor),
                                  title:
                                      Text(snapshot.data![i].nombre.toString()),
                                  subtitle: Text(
                                    snapshot.data![i].descripcion.toString(),
                                  ),
                                  trailing: Text('Edades:' +
                                      snapshot.data![i].edadMin.toString() +
                                      ' - ' +
                                      snapshot.data![i].edadMax.toString()),
                                  onTap: () {}),
                            ));
                  }
                  return const CircularProgressIndicator();
                },
              ),
            ),
          ),
          FloatingActionButton(
            elevation: 12,
            child: const Icon(
              Icons.add_circle_outline,
              size: 30,
            ),
            onPressed: () {
              Navigator.pushReplacementNamed(context, 'Ficha');
            },
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
