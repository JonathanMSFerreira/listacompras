import 'package:listacompras/ui/ListaComprasPage.dart';

import 'package:flutter/material.dart';



void main() => runApp(MaterialApp(
  title: 'Lista de Compras',
  theme: ThemeData(
    primarySwatch: Colors.red,
  ),
  debugShowCheckedModeBanner: false,
  home: ListaComprasPage(),
)
);