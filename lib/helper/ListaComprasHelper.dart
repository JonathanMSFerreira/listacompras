import 'package:listacompras/model/Compra.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:listacompras/model/Item.dart';




class CompraHelper {

  static final CompraHelper _instance = CompraHelper.internal();

  factory CompraHelper() => _instance;

  CompraHelper.internal();

  Database _db;


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
    final path =  join(databasesPath,"db_compras.db");

    return await openDatabase(path,version: 1,onCreate: (Database db, int newerVersion) async{

      await db.execute(
        "CREATE TABLE $compraTable( $idColumn INTEGER PRIMARY KEY, $nameColumn TEXT, $dateColumn TEXT)");


      await db.execute(
          "CREATE TABLE $itemTable( $idItemColumn INTEGER PRIMARY KEY, $nameColumn TEXT,  $okColumn BOOL,  $fkCompraColumn INTEGER)");


    });
  }

  Future<Compra> saveCompra(Compra compra) async {

   Database dbCompra = await db;
   compra.id = await dbCompra.insert(compraTable, compra.toMap());
   return compra;


  }

  //Retorna um lista passando o id como paramentro
  Future<Compra> getCompras(int id) async {

    Database dbCompra = await db;

    List<Map> maps = await dbCompra.query(compraTable,
        columns: [idColumn,nameColumn,dateColumn],
    where: "$idColumn = ?",
    whereArgs: [id]);

    if(maps.length > 0){
      return Compra.fromMap(maps.first);
    }else{

      return null;
    }

  }


  //Deleta um contact pelo id
  Future<int> deleteCompra(int id) async{

    Database dbCompra = await db;
    return await dbCompra.delete(compraTable, where: "$idColumn = ?",whereArgs: [id]);

  }


  //Atualiza uma compra
  Future<int> updateCompra(Compra compra) async {

    Database dbCompra = await db;
   return  await dbCompra.update(compraTable, compra.toMap(), where: "$idColumn = ?",whereArgs: [compra.id]);


  }


  //Lista todos as listas de compras
  Future<List> getAllCompra() async {

    Database dbCompra = await db;
    List listMap = await dbCompra.rawQuery("SELECT * FROM $compraTable");
    List<Compra> listCompras =  List();
    for(Map m in listMap){

      listCompras.add(Compra.fromMap(m));

    }

    return listCompras;

  }


  //Retorna o tamanho da lista
  Future<int> getSize() async {

    Database dbListaCompras = await db;
   return  Sqflite.firstIntValue(await dbListaCompras.rawQuery("SELECT COUNT(*) FROM $compraTable"));


  }


  //Fecha a instanciia do banco de dados
   Future  closeDb() async {

    Database dbListaCompras = await db;
    dbListaCompras.close();


  }
//CRUD DE ITEM DA LISTA DE COMPRAS


  Future<Item> saveItem(Item item) async {

    Database dbCompra = await db;
    item.idItem = await dbCompra.insert(itemTable, item.toMap());
    return item;


  }



  //Retorna um lista passando o id como paramentro
  Future<Item> getItem(int id) async {

    Database dbCompra = await db;

    List<Map> maps = await dbCompra.query(itemTable,
        columns: [idItemColumn,nameItemColumn,okColumn, fkCompraColumn],
        where: "$idItemColumn = ?",
        whereArgs: [id]);

    if(maps.length > 0){
      return Item.fromMap(maps.first);
    }else{

      return null;
    }

  }


  //Deleta um contact pelo id
  Future<int> deleteItem(int id) async{

    Database dbCompra = await db;
    return await dbCompra.delete(itemTable, where: "$idItemColumn = ?",whereArgs: [id]);

  }



  //Atualiza uma compra
  Future<int> updateItem(Item item) async {

    Database dbCompra = await db;
    return  await dbCompra.update(itemTable, item.toMap(), where: "$idItemColumn = ?",whereArgs: [item.idItem]);


  }







}
