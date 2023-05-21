import 'package:appbirthdaycake/custumer/model/cart_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SQLiteHlper {
  final String nameDatabase = 'flutterdb';
  String tableDatabase = 'ordertable';
  int version = 1;

  final String idColumn = 'id';
  final String cake_id = 'cake_id';
  final String cake_size = 'cake_size';
  final String cake_img = 'cake_img';
  final String cake_date = 'cake_date';
  final String cake_text = 'cake_text';
  final String amount = 'amount';
  final String price = 'price';
  final String sum = 'sum';
  final String pickup_date = 'pickup_date';
  final String distance = 'distance';
  final String transport = 'transport';

  
  SQLiteHlper() {
    initDatabase();
  }

  Future<Null> initDatabase() async {
    await openDatabase(join(await getDatabasesPath(), nameDatabase),
        onCreate: (db, version) => db.execute(
            'CREATE TABLE $tableDatabase ($idColumn INTEGER PRIMARY KEY ,$cake_id TEXT ,$cake_size TEXT,$cake_img TEXT,$cake_date TEXT,$cake_text TEXT, $price TEXT, $amount TEXT,$sum TEXT,$pickup_date TEXT ,$distance TEXT,$transport TEXT)'),
        version: version);
  }

  Future<Database> connectedDatabase() async {
    return openDatabase(join(await getDatabasesPath(), nameDatabase));
  }

  Future<Null> insertDataToSQLite(CartModel cartModel) async {
    Database database = await connectedDatabase();
    try {
      database.insert(
        tableDatabase,
        cartModel.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      print('e insertData ==>> ${e.toString()}');
    }
  }

  Future<List<CartModel>> readAllDataFormSQLite() async {
    Database database = await connectedDatabase();
    List<CartModel> cartModels = List();

    List<Map<String, dynamic>> maps = await database.query(tableDatabase);
    for (var map in maps) {
      CartModel cartModel = CartModel.fromJson(map);
      cartModels.add(cartModel);
    }

    return cartModels;
  }

  Future<Null> deleteDataWhereId(int id) async {
    Database database = await connectedDatabase();
    try {
      await database.delete(tableDatabase, where: '$idColumn = $id');
    } catch (e) {
      print('e delete ==> ${e.toString()}');
    }
  }

  Future<Null> deleteAllData() async {
    Database database = await connectedDatabase();
    try {
      await database.delete(tableDatabase);
    } catch (e) {
      print('e delete All ==> ${e.toString()}');
    }
  }
}
