final String listaComprasTable = "listaComprasTable";
final String idColumn = "idColumn";
final String nameColumn = "nameColumn";
final String emailColumn = "emailColumn";
final String phoneColumn = "phoneColumn";
final String imgColumn = "imgColumn";


class ListaCompras {

  int id;
  String name;
  String phone;
  String email;
  String img;


  ListaCompras();

  //Obtém os dados de um Map
  ListaCompras.fromMap(Map map) {
    id = map[idColumn];
    name = map[nameColumn];
    phone = map[phoneColumn];
    email = map[emailColumn];
    img = map[imgColumn];
  }

  //Transforma os dados em um Map
  Map toMap() {
    Map<String, dynamic> map = {
      nameColumn: name,
      phoneColumn: phone,
      emailColumn: email,
      imgColumn: img
    };

    if (id != null) {
      map[idColumn] = id;
    }

    return map;
  }

  @override
  String toString() {

    return "ListaCompras(id: $id, name: $name, phone: $phone, email: $email, img: $img)";

  }


}
