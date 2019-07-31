import 'package:listacompras/ui/InitListaComprasPage.dart';

import 'package:flutter/material.dart';



void main() => runApp(MaterialApp(
  title: 'Lista de Compras',
  theme: ThemeData(
    primarySwatch: Colors.red,
  ),
  debugShowCheckedModeBanner: false,
  home: InitListaComprasPage(),
)
);