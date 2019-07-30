import 'package:flutter/material.dart';
import 'package:listacompras/model/ListaCompras.dart';
import 'package:listacompras/helper/ListaComprasHelper.dart';
import 'dart:io';



class InitListaComprasPage extends StatefulWidget {
  @override
  _InitListaComprasPageState createState() => _InitListaComprasPageState();

}

class _InitListaComprasPageState extends State<InitListaComprasPage> {

  ListaCompras _editedListaCompras;

  final _dateController = TextEditingController();
  final _descListaComprasController = TextEditingController();

  final _nameFocus = FocusNode();


  @override
  void initState() {

    _editedListaCompras = ListaCompras();

    _getAllListaCompras();

    super.initState();

  }


  ListaComprasHelper helper = new ListaComprasHelper();

  List<ListaCompras> todasListaCompras = List();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Lista de Compras'), centerTitle: true,),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {

     //       _showListaComprasPage();
            _dialogNovaListaCompras();


          },
        ),
        body:



        ListView.builder(
            padding: EdgeInsets.all(10.0),
            itemCount: todasListaCompras.length,
            itemBuilder: (context, index){

              return _listaComprasCard(context, index);

            })

/*
        Center(

          child: Column(
            
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              Image.asset("images/bck_carrinho.png",  color: Color.fromRGBO(255, 255, 255, 0.5),
                  colorBlendMode: BlendMode.modulate),
              Text("Nenhuma lista criada!",style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey, fontSize: 20.0), )
              
            ],

          ),

        )*/,


        bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          notchMargin: 4.0,
          child: new Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.menu, color: Colors.red,),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.search, color: Colors.red,),
                onPressed: () {},
              ),

              IconButton(
                icon: Icon(Icons.help_outline, color: Colors.red,),
                onPressed: () {},
              ),

              IconButton(
                icon: Icon(Icons.info_outline, color: Colors.red,),
                onPressed: () {},
              )

            ],
          ),
        ));
  }



  void _dialogNovaListaCompras() {
    // flutter defined function
    showDialog(

      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Lista de Compras"),
          content: TextField(
            controller: _descListaComprasController,
            focusNode: _nameFocus,
            decoration: InputDecoration(hintText: "Descrição"),
            onChanged: (text){

              setState(() {
                _editedListaCompras.name = text;
              });

            },


          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Cancelar",style: TextStyle(color: Colors.grey[400]),),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),

            new RaisedButton(

              child: new Text("Criar", style: TextStyle(color: Colors.white),),
             shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(30.0)),
              onPressed: () {

                if (_editedListaCompras.name != null &&
                    _editedListaCompras.name.isNotEmpty) {

                  helper.saveListaCompras(_editedListaCompras);
                  Navigator.pop(context, _editedListaCompras);


                    _getAllListaCompras();


                } else {
                  FocusScope.of(context).requestFocus(_nameFocus);
                }

              },
            ),


          ],
        );
      },
    );
  }

  void _getAllListaCompras() {
    helper.getAllListaCompras().then((list) {
      setState(() {
        todasListaCompras = list;
      });
    });
  }


  Widget _listaComprasCard(BuildContext context, int index) {

    return  Card(
        child: Column(

          mainAxisSize: MainAxisSize.min,
          children:  <Widget>[
            ListTile(
              leading: Icon(Icons.playlist_add_check),
              title: Text(todasListaCompras[index].name ?? "", style: TextStyle( fontSize: 22.0, fontWeight: FontWeight.bold)),
              subtitle: Text("Você tem 18 itens nessa lista"),
            ),



            ButtonTheme.bar( // make buttons use the appropriate styles for cards
              child: ButtonBar(
                children: <Widget>[
                  FlatButton(
                    child: const Text('Adicionar itens', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green)),
                    onPressed: () { /* ... */ },
                  ),
                  FlatButton(
                    child: const Text('Remover'),
                    onPressed: () { /* ... */ },
                  ),
                ],
              ),
            ),




    /*        Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Column(

                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(todasListaCompras[index].name ?? "",
                        style: TextStyle(
                            fontSize: 22.0, fontWeight: FontWeight.bold)),

          *//*          Text(todasListaCompras[index].phone ?? "",
                        style: TextStyle(fontSize: 18.0)),
                    Text(todasListaCompras[index].email ?? "",
                        style: TextStyle(fontSize: 18.0)),*//*

                  ],


                ),


              )*/


            ],


        )


      );



  }



}
