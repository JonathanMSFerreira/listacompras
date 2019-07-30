final String listaComprasTable = "listaComprasTable";
final String idColumn = "idColumn";
final String nameColumn = "nameColumn";
final String dateColumn = "dateColumn";



class ListaCompras {

  int id;
  String name;
  String date;



  ListaCompras();

  //Obtém os dados de um Map
  ListaCompras.fromMap(Map map) {
    id = map[idColumn];
    name = map[nameColumn];
    date = map[dateColumn];

  }

  //Transforma os dados em um Map
  Map toMap() {
    Map<String, dynamic> map = {
      nameColumn: name,
      dateColumn: date,

    };

    if (id != null) {
      map[idColumn] = id;
    }

    return map;
  }

  @override
  String toString() {

    return "ListaCompras(id: $id, name: $name, date: $date)";

  }


}
