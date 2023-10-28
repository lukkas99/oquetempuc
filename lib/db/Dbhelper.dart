import 'package:oquetempuc/model/clientmodel.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

List WholeDataList = [];

class Dbhelper {
  static Database? _db;

  static const String DB_Name = 'BancoOQTP.db';
  static const String Table_User = 'clientes';
  static const int Version = 1;

  static const String C_UserID = 'user_id';
  static const String C_UserName = 'user_name';
  static const String C_Email = 'email';
  static const String C_Password = 'senha';
  static const String C_LoggedIn = 'logged_in';

  Future<Database> get db async {
    if (_db != null) {
      return _db!;
    }
    _db = await initDb();
    return _db!;
  }

  initDb() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, DB_Name);
    print(path);
    var db = await openDatabase(path, version: Version, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int intVersion) async {
    print('Creating db...');
    await db.execute('''
      CREATE TABLE clientes (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome VARCHAR,
        email VARCHAR UNIQUE,
        senha VARCHAR,
        logged_in INTEGER
      );
      CREATE TABLE fornecedores (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome VARCHAR,
        email VARCHAR UNIQUE,
        senha VARCHAR,
        tipo VARCHAR,
        cnpj VARCHAR,
        endereco VARCHAR,
        logged_in INTEGER
      );
      CREATE TABLE produtos (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nomeProduct VARCHAR,
        descricao VARCHAR,
        categoria VARCHAR,
        imagemPath VARCHAR
      );
      CREATE TABLE produtos_fornecedores (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        price REAL,
        idFornecedor INTEGER,
        idProduto INTEGER,
        FOREIGN KEY (idFornecedor) REFERENCES fornecedores (id),
        FOREIGN KEY (idProduto) REFERENCES produtos (id)
      );
  ''');
  }

  Future<int> saveData(clientmodel user) async {
    var dbClient = await db;
    var res = await dbClient.insert(Table_User, user.toMap());
    return res;
  }

  Future<clientmodel?> getLoginUser(String userId, String password) async {
    var dbClient = await db;
    var res = await dbClient.rawQuery("SELECT * FROM $Table_User WHERE "
        "$C_Email = '$userId' AND "
        "$C_Password = '$password'"); // Verifica se o cliente está logado

    if (res.length > 0) {
      return clientmodel.fromMap(res.first);
    }

    return null;
  }

  Future<void> setLoggedInStatus(String userEmail, int status) async {
    var dbClient = await db;
    await dbClient.rawUpdate(
      'UPDATE $Table_User SET logged_in = ? WHERE $C_Email = ?',
      [status, userEmail],
    );
  }

  Future<int> updateUser(clientmodel user) async {
    var dbClient = await db;
    var res = await dbClient.update(Table_User, user.toMap(),
        where: '$C_UserID = ?', whereArgs: [user.client_id]);
    return res;
  }

  Future<int> deleteUser(String user_id) async {
    var dbClient = await db;
    var res = await dbClient
        .delete(Table_User, where: '$C_UserID = ?', whereArgs: [user_id]);
    return res;
  }

  Future<void> clearUserData() async {
    var client = await db;
    await client.rawUpdate(
        'UPDATE clientes SET logged_in = 0'); // Define o cliente como deslogado
  }

  Future readalldata() async {
    var dbprint = await db;
    final alldata = await dbprint.query(Table_User);
    WholeDataList = alldata.toList();
    print(WholeDataList);
    return 'succesfully read!';
  }

  Future<void> deleteDB() async {
    try {
      print('deleting db');
      _db = null;
      deleteDatabase(join(await getDatabasesPath(), DB_Name));
    } catch (e) {
      print(e.toString());
    }

    print('db is deleted');
  }

  Future<bool> isEmailAlreadyRegistered(String email) async {
    final dbClient = await db;
    final res = await dbClient
        .rawQuery("SELECT COUNT(*) FROM $Table_User WHERE $C_Email = '$email'");
    final count = Sqflite.firstIntValue(res);
    return count != null && count > 0;
  }
}
