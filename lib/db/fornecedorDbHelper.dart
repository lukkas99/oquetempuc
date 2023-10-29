import 'package:oquetempuc/model/clientmodel.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:oquetempuc/model/fornecedor.dart';

class FornecedorDbHelper {
  static Database? _db;

  static const String DB_Name = 'BancoOQTP.db';
  static const String Table_Fornecedor = 'fornecedores';
  static const int Version = 1;

  static const String C_Id = 'id';
  static const String C_Email = 'email';
  static const String C_EncryptedPassword = 'encrypted_password';
  static const String C_Name = 'name';
  static const String C_CEP = 'cep';
  static const String C_Address = 'address';
  static const String C_Service = 'service';
  static const String C_URL = 'url';
  static const String C_Location = 'location';
  static const String C_Funcionamento = 'funcionamento';
  static const String C_Ativo = 'ativo';

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
    print('Creating fornecedores table...');
    await db.execute('''
      CREATE TABLE $Table_Fornecedor (
        $C_Id INTEGER PRIMARY KEY AUTOINCREMENT,
        $C_Email TEXT,
        $C_EncryptedPassword TEXT,
        $C_Name TEXT,
        $C_CEP TEXT,
        $C_Address TEXT,
        $C_Service TEXT,
        $C_URL TEXT,
        $C_Location INTEGER,
        $C_Funcionamento TEXT,
        $C_Ativo INTEGER
      );
  ''');
  }

  Future<int> saveFornecedorData(Fornecedor fornecedor) async {
    var dbClient = await db;
    var res = await dbClient.insert(Table_Fornecedor, fornecedor.toMap());
    return res;
  }

  // Outras operações relacionadas a fornecedores podem ser adicionadas aqui

  // ... (outros métodos)

  // inativa fornecedor
  Future<void> setFornecedorAtivo(int fornecedorId) async {
    var dbClient = await db;
    await dbClient.update(
      Table_Fornecedor,
      {C_Ativo: 1}, // Define 'ativo' para 1 (true)
      where: '$C_Id = ?',
      whereArgs: [fornecedorId],
    );
  }
}
