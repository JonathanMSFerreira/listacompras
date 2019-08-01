import 'package:flutter/material.dart';
import 'package:listacompras/model/Compra.dart';

class ItemPage extends StatefulWidget {
  Compra compra;

  ItemPage(Compra compra) {
    this.compra = compra;
  }

  @override
  _ItemPageState createState() => _ItemPageState(compra);
}

class _ItemPageState extends State<ItemPage> {
  Compra compra;

  _ItemPageState(Compra compra) {
    this.compra = compra;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(compra.name),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {},
          ),
          // action button
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(child: Container()),
          Row(
            children: <Widget>[
              Expanded(
                  child: Padding(
                      padding: EdgeInsets.fromLTRB(5.0, 5.0, 1.0, 5.0),
                      child: TextField(

                        decoration: new InputDecoration(
                          labelText: "Novo item",
                          fillColor: Colors.white,
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(25.0),
                            borderSide: new BorderSide(),
                          ),
                          //fillColor: Colors.green
                        ),
                      ))),
              Container(

                alignment: Alignment.center,

                child: IconButton(
                    icon: Icon(Icons.add_circle, color: Colors.red, size: 40.0,), onPressed: () {}),
              )
            ],
          )
        ],
      ),
    );
  }
}
