import 'package:flutter/material.dart';
import 'package:listacompras/model/Compra.dart';
import 'package:listacompras/helper/ListaComprasHelper.dart';
import 'dart:io';

import 'package:listacompras/ui/ItemPage.dart';



class ListaComprasPage extends StatefulWidget {

  @override
  _ListaComprasPageState createState() => _ListaComprasPageState();

}

class _ListaComprasPageState extends State<ListaComprasPage> {

  Compra _editedCompra;


  final _nameController = TextEditingController();

  final _nameFocus = FocusNode();

  var _sizeListaCompras;

  @override
  void initState() {



    _editedCompra = Compra();

    _getAllCompras();

    _getSize();


    super.initState();

  }


  CompraHelper helper = new CompraHelper();

  List<Compra> listaCompras = List();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Lista de Compras'), centerTitle: true,),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {

            _dialogNovaCompra(context);

          },
        ),
        body:


        _sizeListaCompras.toString() != '0' ?

        ListView.builder(
            padding: EdgeInsets.all(1.0),
            itemCount: listaCompras.length,
            itemBuilder: (context, index){

              return _cardCompra(context, index);

            })

          :

         Center(

          child: Column(

            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              Image.asset("images/bck_carrinho.png",  color: Color.fromRGBO(255, 255, 255, 0.5),
                  colorBlendMode: BlendMode.modulate),
              Text("Nenhuma lista criada!",style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey, fontSize: 20.0), )

            ],

          ),

        ),


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




  void _dialogRemoveCompra(int id) {


    showDialog(

      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {

        return AlertDialog(
          title: new Text("Remover"),
          content: Text(

              "Deseja remover a lista?"

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

              child: new Text("Sim", style: TextStyle(color: Colors.white),),
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0)),
              onPressed: () {



                  helper.deleteCompra(id);
                  Navigator.pop(context);


                  _getSize();
                  _getAllCompras();




              },
            ),


          ],
        );
      },
    );
  }







  void _dialogNovaCompra(BuildContext context) {



    showDialog(

      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {

        return AlertDialog(
          title: new Text("Lista de Compras"),
          content: TextField(
            controller: _nameController,
            focusNode: _nameFocus,
            decoration: InputDecoration(hintText: "Nome"),
            onChanged: (text){

              setState(() {
                _editedCompra.name = text;
                 String data = "Criada em: " + DateTime.now().day.toString() + "/" + DateTime.now().month.toString() + "/" +DateTime.now().year.toString();
                _editedCompra.date = data;

              });

            },


          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Cancelar",style: TextStyle(color: Colors.grey[400]),),
              onPressed: () {
                _editedCompra.name = "";
                Navigator.of(context).pop();
              },
            ),

            new RaisedButton(

              child: new Text("Criar", style: TextStyle(color: Colors.white),),
             shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(30.0)),
              onPressed: () {

                if (_editedCompra.name != null &&  _editedCompra.name.isNotEmpty) {

                  helper.saveCompra(_editedCompra);

                  Navigator.pop(context, _editedCompra);
                  _editedCompra = Compra();
                  _nameController.text = "";
                  _getSize();
                  _getAllCompras();


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

  void _getAllCompras() {

    helper.getAllCompra().then((list) {
      setState(() {
        listaCompras = list;
      });
    });
  }

  void _getSize(){


    helper.getSize().then((size) {
      setState(() {
        _sizeListaCompras =  size.toString();
      });
    });


  }



  Widget _cardCompra(BuildContext context, int index) {

    return  Card(
        child: Column(

          mainAxisSize: MainAxisSize.min,
          children:  <Widget>[
            ListTile(
              leading: Icon(Icons.playlist_add_check),
              title: Text(listaCompras[index].name ?? "", style: TextStyle( fontSize: 22.0, fontWeight: FontWeight.bold)),
              subtitle: Text(listaCompras[index].date ?? ""),
            ),



            ButtonTheme.bar( // make buttons use the appropriate styles for cards
              child: ButtonBar(
                children: <Widget>[

                  FlatButton(
                    child: const Text('Remover', style: TextStyle(color: Colors.black12),),
                    onPressed: () {



                      _dialogRemoveCompra(listaCompras[index].id);


                    },
                  ),
                  FlatButton(
                    child: const Text('Itens da lista', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
                    onPressed: () {

                      Navigator.push(
                          context, MaterialPageRoute(builder: (context) => ItemPage(listaCompras[index])));


                    },
                  ),

                ],
              ),
            ),




            ],


        )


      );

  }

}
