import 'package:listacompras/ui/InitListaComprasPage.dart';

import 'package:listacompras/ui/HomePage.dart';
import 'package:flutter/material.dart';



void main() => runApp(MaterialApp(
  title: 'Agenda de contatos',
  theme: ThemeData(
    primarySwatch: Colors.red,
  ),
  debugShowCheckedModeBanner: false,
  home: InitListaComprasPage(),
)
);