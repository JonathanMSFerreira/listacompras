
import 'dart:io';

import 'package:listacompras/helper/ListaComprasHelper.dart';
import 'package:listacompras/model/ListaCompras.dart';
import 'package:listacompras/ui/ListaComprasPage.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';



class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  ListaComprasHelper helper = new ListaComprasHelper();

  List<ListaCompras> todaslistaCompras = List();


  @override
  void initState() {

    super.initState();





    ListaCompras  listaCompras = ListaCompras();
//    c.name = "Jonathan";
//    c.phone = "(98) 99898-9898";
//    c.email = "jonathan.msf@gmail.com";
//    c.img = "asjfdtese";
//
//    helper.saveContact(c);

    
    _getAllListaCompras();
    
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de Compras"),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
          onPressed: (){

            _showListaComprasPage();

          },
          child: Icon(Icons.add),
          backgroundColor: Colors.blue,
          ),

      body: ListView.builder(
          padding: EdgeInsets.all(10.0),
          itemCount: todaslistaCompras.length,
          itemBuilder: (context, index){

              return _listaComprasCard(context, index);

          }),


      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[],
        ),
   //     notchedShape: CircularNotchedRectangle(),
        color: Colors.blueGrey,
      ),


    );
  }

  Widget _listaComprasCard(BuildContext context, int index) {
    return GestureDetector(
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Row(
            children: <Widget>[

              Container(
                width: 80.0,
                height: 80.0,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: todaslistaCompras[index].img != null ?
                        FileImage(File(todaslistaCompras[index].img)) :
                        AssetImage("images/user.png")

                    )),


              ),
              Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Column(

                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(todaslistaCompras[index].name ?? "",
                        style: TextStyle(
                            fontSize: 22.0, fontWeight: FontWeight.bold)),

                    Text(todaslistaCompras[index].phone ?? "",
                        style: TextStyle(fontSize: 18.0)),
                    Text(todaslistaCompras[index].email ?? "",
                        style: TextStyle(fontSize: 18.0)),

                  ],


                ),


              )


            ],


          ),),


      ),
     onTap: (){

        _showOptionsListaCompras(context, index);

     },

    );
  }



  void _showOptionsListaCompras(BuildContext context, int index){


    showModalBottomSheet(
        context: context,
        builder: (context){


          return BottomSheet(
            onClosing: (){},
            builder: (context){

              return Container(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[

                        FlatButton(

                          child: Text("Ligar",style:  TextStyle(color: Colors.blue, fontSize: 20.0),

                          ),
                          onPressed: (){

                            launch("tel:${todaslistaCompras[index].phone}");
                            Navigator.pop(context);

                          },


                        ),


                        FlatButton(
                          child: Text("Editar",style:  TextStyle(color: Colors.blue, fontSize: 20.0),),
                          onPressed: (){

                            Navigator.pop(context);
                            _showListaComprasPage(listaCompras: todaslistaCompras[index]);
                          },

                        ),


                        FlatButton(
                            child: Text("Excluir",style:  TextStyle(color: Colors.red, fontSize: 20.0),),
                          onPressed: (){

                              helper.deleteListaCompras(todaslistaCompras[index].id);
                              _getAllListaCompras();
                              Navigator.pop(context);

                          },

                        ),



                  ],



                )



              );

            }

          );


        }


    );



  }



    void _showListaComprasPage({ListaCompras listaCompras}) async{

      final recListaCompras = await Navigator.push(context,

        MaterialPageRoute(builder: (context) => ListaComprasPage(listaCompras: listaCompras,)));


        if(recListaCompras != null){
          if(listaCompras != null){

            await helper.updateListaCompras(recListaCompras);

          }else {
            await helper.saveListaCompras(recListaCompras);
          }

          _getAllListaCompras();

        }


    }


    void _getAllListaCompras(){


      helper.getAllListaCompras().then((list){

        setState(() {

          todaslistaCompras = list;
        });
      });



    }




}
