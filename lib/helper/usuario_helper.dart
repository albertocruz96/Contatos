import 'package:agenda_contatos_sozinho/model/model_usuario.dart';
import 'package:agenda_contatos_sozinho/model/name_tables.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class UsuarioHelper{

  Tables _tables = Tables();

  //cria um unico objeto dessa classe podendo ser chamado de qualquer lugar
  UsuarioHelper.internal();
  static final UsuarioHelper _instance = UsuarioHelper.internal();
  factory UsuarioHelper() => _instance;

  Database? _db;                              //variavel do banco

  Future<Database?> get db async{             //recupera o banco de dados
    if(_db != null){
      return _db;
    } else{
      _db = await initDb();                 //funcao q inicializa o banco
      return _db;
    }
  }

  Future<Database> initDb() async {                 //inicializa o banco
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, "usuarios.db");
    
    return await openDatabase(path, version: 1, onCreate: (Database db, int newVersion) async{
      await db.execute(
        "CREATE TABLE ${_tables.usuarioTable}(${_tables.idColum} INTEGER PRIMARY KEY, ${_tables.nomeColum} TEXT, ${_tables.idadeColum} TEXT, ${_tables.emailColum} TEXT)"
      );
    });
  }

  Future<Usuario> saveUsuario(Usuario usuario) async{                 //salvar no banco
    Database? dbUsuario = await db;                                   //é o db normal mesmo vindo do get
    usuario.id = await dbUsuario!.insert(_tables.usuarioTable, usuario.toMap());
    return usuario;
  }

  Future<Usuario?> getUsuario(int id) async{                    //recupera o usuario atraves do id
    Database? dbUsuario = await db;                             //db do get
    List<Map> maps = await dbUsuario!.query(
      _tables.usuarioTable,
      columns: [_tables.idColum.toString(), _tables.nomeColum.toString(), _tables.idadeColum, _tables.emailColum.toString()],
      where: "${_tables.idColum} = ?",
      whereArgs: [id]
    );
    if(maps.length > 0){
      return Usuario.fromMap(maps.first);
    } else{
      return null;
    }
  }

  Future<int> deletUsuario(int id) async{                   //deleta com base no id
    Database? dbUsuario = await db;
    return await dbUsuario!.delete(
      _tables.usuarioTable,
      where: "${_tables.idColum} = ?",
      whereArgs: [id]
    );
  }

  Future<int> updateUsuario(Usuario usuario) async{     //atualiza o usuario passando um novo usuario
    Database? dbUsuario = await db;
    return dbUsuario!.update(
      _tables.usuarioTable,
      usuario.toMap(),
      where: "${_tables.idColum} = ?",                     //onde o id é igual
      whereArgs: [usuario.id]                           //o id do contato
    );
  }

  Future<List<Usuario>> getAllUsuarios() async{        //pega todos os usuarios
    Database? dbUsuario = await db;
    List listMap = await dbUsuario!.rawQuery("SELECT * FROM ${_tables.usuarioTable}");     //seleciona td da nossa tabela e guarda na lista
    List<Usuario> listUsuarios = [];
    for(Map map in listMap){
      listUsuarios.add(Usuario.fromMap(map));
    }
    return listUsuarios;
  }

  Future CloseDb() async{                           //fechar o banco
    Database? dbUsuario = await db;
    dbUsuario!.close();
  }
}
