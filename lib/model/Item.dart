final String itemTable = "itemTable";
final String idItemColumn = "idItemColumn";
final String nameItemColumn = "nameItemColumn";
final String okColumn = "okColumn";
final String fkCompraColumn = "fkCompraColumn";



class Item {

  int idItem;
  String name;
  bool ok ;
  int fkCompra;


  Item();


  Item.fromMap(Map map) {

    idItem = map[idItemColumn];
    name = map[nameItemColumn];
    ok = map[okColumn];
    fkCompra = map[fkCompraColumn];



  }


  Map toMap() {

      Map<String, dynamic> map = {

      nameItemColumn: name,
      okColumn: ok,
      fkCompraColumn: fkCompra,

    };

    if (idItem != null) {
      map[idItemColumn] = idItem;
    }

    return map;
  }

  @override
  String toString() {

    return "Item(idItem: $idItem, name: $name, ok: $ok, fkCompra: $fkCompra)";

  }


}
