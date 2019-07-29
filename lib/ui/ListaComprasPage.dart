import 'dart:io';

import 'package:listacompras/model/ListaCompras.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ListaComprasPage extends StatefulWidget {
  final ListaCompras listaCompras;

  //Construtor
  //@param contact (contato que a ser editado)
  ListaComprasPage({this.listaCompras});

  @override
  _ListaComprasPageState createState() => _ListaComprasPageState();
}

class _ListaComprasPageState extends State<ListaComprasPage> {

  ListaCompras _editedListaCompras;

  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();

  final _nameFocus = FocusNode();

  bool _userEdited = false;

  @override
  void initState() {
    //Se não foi passado um contato instancia um novo contato
    if (widget.listaCompras == null) {
      _editedListaCompras = ListaCompras();
      //
    } else {
      _editedListaCompras = ListaCompras.fromMap(widget.listaCompras.toMap());

      _nameController.text = _editedListaCompras.name;
      _phoneController.text = _editedListaCompras.phone;
      _emailController.text = _editedListaCompras.email;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _requestPop,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text(_editedListaCompras.name ?? "Nova Lista"),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.save),
            backgroundColor: Colors.blue,
            onPressed: () {
              if (_editedListaCompras.name != null &&
                  _editedListaCompras.name.isNotEmpty) {
                Navigator.pop(context, _editedListaCompras);
              } else {
                FocusScope.of(context).requestFocus(_nameFocus);
              }
            }),
        body: SingleChildScrollView(
          //Widget para não quebrar a tela quando chamar o teclado
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              GestureDetector(
                child: Container(
                  width: 120.0,
                  height: 120.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: _editedListaCompras.img != null
                            ? FileImage(File(_editedListaCompras.img))
                            : AssetImage("images/user.png")),
                  ),
                ),
                onTap: () {
                  ImagePicker.pickImage(source: ImageSource.camera)
                      .then((file) {
                    if (file == null) return;

                    _userEdited = true;
                    setState(() {
                      _editedListaCompras.img = file.path;
                    });
                  });
                },
              ),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(labelText: "Nome"),
                focusNode: _nameFocus,
                onChanged: (text) {
                  _userEdited = true;

                  setState(() {
                    _editedListaCompras.name = text;
                  });
                },
              ),
              TextField(
                controller: _phoneController,
                decoration: InputDecoration(labelText: "Telefone"),
                onChanged: (text) {
                  _userEdited = true;
                  _editedListaCompras.phone = text;
                },
                keyboardType: TextInputType.phone,
              ),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(labelText: "Email"),
                onChanged: (text) {
                  _userEdited = true;
                  _editedListaCompras.email = text;
                },
                keyboardType: TextInputType.emailAddress,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> _requestPop() {
    if (_userEdited) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Descartar alterações?"),
              content: Text("Se sair todas as alterações serão perdidas!"),
              actions: <Widget>[
                FlatButton(
                  child: Text("Cancelar"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                FlatButton(
                  child: Text("Sim"),
                  onPressed: () {
                    Navigator.pop(context); //sai da caixa de dialogo
                    Navigator.pop(context); //retorna à HomePage
                  },
                ),
              ],
            );
          });

      return Future.value(false);
    } else {
      //Retorna para HomePage sem chamar a caixa de dialogo pois não houve modificações nos dados
      return Future.value(true);
    }
  }
}
