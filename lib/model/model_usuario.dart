import 'package:agenda_contatos_sozinho/model/name_tables.dart';

class Usuario{

  //tudo que um usuario tem
  int? id;                          //todo usuario sera identificado pelo id
  String? nome;
  String? idade;
  String? email;

  Usuario();

  Tables _tables = Tables();

  Usuario.fromMap(Map map){         //construtor que converte de um mapa para usuario, ele cria um usuario apartir de um mapa recebido no parametro
    id = map[_tables.idColum];
    nome = map[_tables.nomeColum];
    idade = map[_tables.idadeColum];
    email = map[_tables.emailColum];
  }

  Map<String, dynamic> toMap(){                      //converte para map, monta um map com a chave o nome da coluna e no valor é o valor que esta no objeto do usuario e retorna esse map
    Map<String, dynamic> map = {
      _tables.nomeColum: nome,
      _tables.idadeColum: idade,
      _tables.emailColum: email,
    };
    if(id != null){             //se o id ja existir
      map[_tables.idColum] = id;
    }
    return map;
  }

  @override
  String toString() {                 //serve para visualizarmos as informaçoes do objeto do usuario
    // TODO: implement toString
    return "Id: $id, Nome: $nome, Idade: $idade, Email: $email";
  }
}