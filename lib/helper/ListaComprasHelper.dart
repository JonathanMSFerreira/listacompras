import 'package:listacompras/model/ListaCompras.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';





class ListaComprasHelper {

  static final ListaComprasHelper _instance = ListaComprasHelper.internal();

  factory ListaComprasHelper() => _instance;

  ListaComprasHelper.internal();

  Database _db;


  //Retorna a instancia do banco de dados
 Future<Database> get db async{

    if(_db != null){
      return _db;
    }else{
       _db = await initDb();
       return _db;

    }
  }

  //Inicializa o banco de dados
  Future<Database> initDb() async{

    final databasesPath = await getDatabasesPath();
    final path =  join(databasesPath,"listaCompras.db");

   return await openDatabase(path,version: 1,onCreate: (Database db, int newerVersion) async{

      await db.execute(
        "CREATE TABLE $listaComprasTable( $idColumn INTEGER PRIMARY KEY, $nameColumn TEXT, $dateColumn TEXT)");


    });
  }

  Future<ListaCompras> saveListaCompras(ListaCompras listaCompras) async {

   Database dbListaCompras = await db;
   listaCompras.id = await dbListaCompras.insert(listaComprasTable, listaCompras.toMap());
  return listaCompras;


  }

  //Retorna um contato passando o id como paramentro
  Future<ListaCompras> getListaCompras(int id) async {

    Database dbListaCompras = await db;

    List<Map> maps = await dbListaCompras.query(listaComprasTable,
        columns: [idColumn,nameColumn,dateColumn],
    where: "$idColumn = ?",
    whereArgs: [id]);

    if(maps.length > 0){
      return ListaCompras.fromMap(maps.first);
    }else{

      return null;
    }

  }


  //Deleta um contact pelo id
  Future<int> deleteListaCompras(int id) async{

    Database dbListaCompras = await db;
    return await dbListaCompras.delete(listaComprasTable, where: "$idColumn = ?",whereArgs: [id]);

  }


  //Atualiza um contact
  Future<int> updateListaCompras(ListaCompras listaCompras) async {

    Database dbListaCompras = await db;
   return  await dbListaCompras.update(listaComprasTable, listaCompras.toMap(), where: "$idColumn = ?",whereArgs: [listaCompras.id]);


  }


  //Lista todos os contacts
  Future<List> getAllListaCompras() async {

    Database dbListaCompras = await db;
    List listMap = await dbListaCompras.rawQuery("SELECT * FROM $listaComprasTable");
    List<ListaCompras> listListaCompras =  List();
    for(Map m in listMap){

      listListaCompras.add(ListaCompras.fromMap(m));

    }

    return listListaCompras;

  }


  //Retorna o tamanho da lista
  Future<int> getSize() async {

    Database dbListaCompras = await db;
   return  Sqflite.firstIntValue(await dbListaCompras.rawQuery("SELECT COUNT(*) FROM $listaComprasTable"));


  }


  //Fecha a instanciia do banco de dados
   Future  closeDb() async {

    Database dbListaCompras = await db;
    dbListaCompras.close();


  }



}
