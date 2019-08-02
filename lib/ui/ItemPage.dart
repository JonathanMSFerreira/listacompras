import 'package:flutter/material.dart';
import 'package:listacompras/helper/ListaComprasHelper.dart';
import 'package:listacompras/model/Compra.dart';
import 'package:listacompras/model/Item.dart';

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

  Item _editedItem;

  final _nameController = TextEditingController();

  final _nameFocus = FocusNode();

  _ItemPageState(Compra compra) {
    this.compra = compra;
  }

  @override
  void initState() {
    _editedItem = Item();

    _editedItem.ok = false;
    _getAllItens(compra.id);

    super.initState();
  }

  CompraHelper helper = new CompraHelper();

  List<Item> listaItens = List();

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
          Expanded(
              child: ListView.builder(
                  padding: EdgeInsets.all(1.0),
                  itemCount: listaItens.length,
                  itemBuilder: (context, index) {
                    return _cardItem(context, index);
                  })),
          Row(
            children: <Widget>[
              Expanded(
                  child: Container(
                      padding:
                          EdgeInsets.only(left: 2.0, bottom: 2.0, right: 0.0),
                      child: TextField(
                          controller: _nameController,
                          decoration: new InputDecoration(
                            labelText: "Novo item",
                            fillColor: Colors.white,
                            border: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(25.0),
                              borderSide: new BorderSide(),
                            ),
                            //fillColor: Colors.green
                          ),
                          onChanged: (text) {
                            setState(() {
                              _editedItem.nameItem = text;
                              _editedItem.fkCompra = compra.id;
                            });
                          }))),
              Container(
                alignment: Alignment.center,
                child: IconButton(
                    icon: Icon(
                      Icons.add_circle,
                      color: Colors.red,
                      size: 40.0,
                    ),
                    onPressed: () {
                      if (_editedItem.nameItem != null &&
                          _editedItem.nameItem.isNotEmpty) {


                        helper.saveItem(_editedItem);
                        _editedItem = Item();
                        _editedItem.ok = false;
                        _nameController.text = "";
                        _getAllItens(compra.id);



                        FocusScope.of(context).requestFocus(new FocusNode());
                      } else {
                        FocusScope.of(context).requestFocus(_nameFocus);
                      }
                    }),
              )
            ],
          )
        ],
      ),
    );
  }

  void _getAllItens(int id) {
    helper.getAllItens(id).then((list) {
      setState(() {
        listaItens = list;
      });
    });
  }

  Widget _cardItem(BuildContext context, int index) {
    String cont = (index + 1).toString() + ".";

    return Dismissible(
        key: Key(listaItens[index].idItem.toString()),
        background: Container(
          color: Colors.red,
          child: Align(
            alignment: Alignment(-0.9, 0.0),
            child: Icon(
              Icons.delete,
              color: Colors.white,
            ),
          ),
        ),
        direction: DismissDirection.startToEnd,
        child: CheckboxListTile(
          title: Text(listaItens[index].nameItem ?? "",
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
          value: listaItens[index].ok,
          secondary: Text(
            cont,
            style: TextStyle(fontSize: 20.0),
          ),
          onChanged: (c) {
            setState(() {
              listaItens[index].ok = c;
            });
          },


        ),

      onDismissed: (direction){

        helper.deleteItem(listaItens[index].idItem);
        _getAllItens(compra.id);

    },

    );
  }
}
