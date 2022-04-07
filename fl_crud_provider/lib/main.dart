// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_crud_provider/screens/screens.dart';
import 'package:fl_crud_provider/providers/providers.dart';


void main() async {
  
  runApp(MyApp())

  ;}

class MyApp extends StatefulWidget {
  
  
  
  @override
  State<MyApp> createState() => _MyAppState();
  
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
      return ChangeNotifierProvider(
        create: ( _ ) => ActividadListProvider(),
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Actividades Fisicas',
            initialRoute: 'Home',
            routes: {
              'Home'  : ( _ ) => const HomeScreen(),
              'Ficha' : ( _ ) => ActividadScreen(),
            },
          
        ),
    );
  }
}