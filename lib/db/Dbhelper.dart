import 'package:oquetempuc/model/clientmodel.dart';
import 'package:oquetempuc/model/fornecedor.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

List WholeDataList = [];

class DbHelper {
  static Database? _db;

  static const String DB_Name = 'BancoOQTP.db';
  static const String TableUser = 'clientes';
  static const String TableFornecedor = 'fornecedor';
  static const int Version = 5;

  static const String CUserId = 'user_id';
  static const String CUserName = 'user_name';
  static const String CEmail = 'email';
  static const String CPassword = 'senha';
  static const String CLoggedIn = 'logged_in';

  static const String CId = 'id';
  static const String CEmailFornecedor = 'email';
  static const String CEncryptedPassword = 'encrypted_password';
  static const String CName = 'name';
  static const String CCEP = 'cep';
  static const String CAddress = 'address';
  static const String CService = 'service';
  static const String CURL = 'url';
  static const String CLocation = 'location';
  static const String CFuncionamento = 'funcionamento';
  static const String CAtivo = 'ativo';

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
      CREATE TABLE $TableUser (
        $CUserId INTEGER PRIMARY KEY AUTOINCREMENT,
        $CUserName TEXT,
        $CEmail TEXT UNIQUE,
        $CPassword TEXT,
        $CLoggedIn INTEGER
      );
      CREATE TABLE $TableFornecedor (
        $CId INTEGER PRIMARY KEY AUTOINCREMENT,
        $CEmailFornecedor TEXT,
        $CEncryptedPassword TEXT,
        $CName TEXT,
        $CCEP TEXT,
        $CAddress TEXT,
        $CService TEXT,
        $CURL TEXT,
        $CLocation INTEGER,
        $CFuncionamento TEXT,
        $CAtivo INTEGER
      );
      CREATE TABLE produtos (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nomeProduct TEXT,
        descricao TEXT,
        categoria TEXT,
        imagemPath TEXT
      );
      CREATE TABLE produtos_fornecedores (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        price REAL,
        idFornecedor INTEGER,
        idProduto INTEGER,
        FOREIGN KEY (idFornecedor) REFERENCES $TableFornecedor ($CId),
        FOREIGN KEY (idProduto) REFERENCES produtos (id)
      );
  ''');
  }

  Future<int> saveUserData(clientmodel user) async {
    var dbClient = await db;
    var res = await dbClient.insert(TableUser, user.toMap());
    return res;
  }

  Future<clientmodel?> getLoginUser(String userId, String password) async {
    var dbClient = await db;
    var res = await dbClient.rawQuery("SELECT * FROM $TableUser WHERE "
        "$CEmail = '$userId' AND "
        "$CPassword = '$password'"); // Verifica se o cliente está logado

    if (res.length > 0) {
      return clientmodel.fromMap(res.first);
    }

    return null;
  }

  Future<void> setLoggedInStatus(String userEmail, int status) async {
    var dbClient = await db;
    await dbClient.rawUpdate(
      'UPDATE $TableUser SET $CLoggedIn = ? WHERE $CEmail = ?',
      [status, userEmail],
    );
  }

  Future<int> updateUserData(clientmodel user) async {
    var dbClient = await db;
    var res = await dbClient.update(TableUser, user.toMap(),
        where: '$CUserId = ?', whereArgs: [user.client_id]);
    return res;
  }

  Future<int> deleteUser(String user_id) async {
    var dbClient = await db;
    var res = await dbClient
        .delete(TableUser, where: '$CUserId = ?', whereArgs: [user_id]);
    return res;
  }

  Future<void> clearUserData() async {
    var client = await db;
    await client.rawUpdate(
        'UPDATE $TableUser SET $CLoggedIn = 0'); // Define o cliente como deslogado
  }

  Future readAllUserData() async {
    var dbprint = await db;
    final alldata = await dbprint.query(TableUser);
    WholeDataList = alldata.toList();
    print(WholeDataList);
    return 'Successfully read!';
  }

  Future<int> saveFornecedorData(Fornecedor fornecedor) async {
    var dbClient = await db;
    try {
      int id = await dbClient.insert(TableFornecedor, fornecedor.toMap());

      print("Restaurante salvo com sucesso! ID: $id");
      return id;
    } catch (e) {
      print(e.toString());
      print("Falha ao salvar restaurante.");
    }
    return -1;
  }

  // Inativa fornecedor
  Future<void> desativaFornecedor(int fornecedorId) async {
    var dbClient = await db;
    await dbClient.update(
      TableFornecedor,
      {CAtivo: 0}, // Define 'desativado' para 0
      where: '$CId = ?',
      whereArgs: [fornecedorId],
    );
  }

  Future<Fornecedor?> getFornecedorById(int id) async {
    final dbClient = await db;
    final result = await dbClient.query(
      TableFornecedor,
      where: '$CId = ?',
      whereArgs: [id],
    );

    if (result.isNotEmpty) {
      print("Restaurante ${result[0][CName]}");
      return Fornecedor.fromMap(result.first);
    } else {
      print("Erro ao buscar restaurante");
      return null;
    }
  }

  Future<void> deleteDB() async {
    try {
      print('Deleting database');
      _db = null;
      deleteDatabase(join(await getDatabasesPath(), DB_Name));
    } catch (e) {
      print(e.toString());
    }

    print('Database is deleted');
  }

  Future<bool> isEmailAlreadyRegistered(String email) async {
    final dbClient = await db;
    final res = await dbClient
        .rawQuery("SELECT COUNT(*) FROM $TableUser WHERE $CEmail = '$email'");
    final count = Sqflite.firstIntValue(res);
    return count != null && count > 0;
  }
}
