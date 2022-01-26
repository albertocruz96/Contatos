import 'package:agenda_contatos_sozinho/helper/usuario_helper.dart';
import 'package:agenda_contatos_sozinho/model/model_usuario.dart';
import 'package:agenda_contatos_sozinho/pages/usuario_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';



class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  UsuarioHelper usuarioHelper = UsuarioHelper();            //cria a variavel do banco de dados

  List<Usuario> listUsuarios = [];

  void _getAllUsuarios(){
    usuarioHelper.getAllUsuarios().then((value){
      setState(() {
        listUsuarios = value;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getAllUsuarios();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Usuarios"),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(10),
          itemCount: listUsuarios.length,
          itemBuilder: (context, index){
            return _usuarioCard(context, index);
          }
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add, size: 30,),
          onPressed: showUsuarioPage
      ),
    );
  }

  Widget _usuarioCard(BuildContext context, int index){
    return Slidable(
        child: GestureDetector(
          child: Card(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Nome: ${listUsuarios[index].nome}",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      "Idade: ${listUsuarios[index].idade}",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    "Emai: ${listUsuarios[index].email}",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                )
              ],
            ),
          ),
          onTap: (){
            showUsuarioPage(usuario: listUsuarios[index]);
          },
        ),
        actionPane: SlidableBehindActionPane(),
        secondaryActions: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 4),
            child: ElevatedButton(
              child: Column(
                children: <Widget>[
                  Icon(Icons.delete_outline),
                  Text("Excluir")
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
              onPressed: () {
                _deletUsuario(index);
              },
              style: ButtonStyle(
                  shape: MaterialStateProperty.all<
                      RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        //side: BorderSide(color: Colors.red)
                      )),
                  foregroundColor:
                  MaterialStateProperty.all<Color>(
                      Colors.white),
                  backgroundColor:
                  MaterialStateProperty.all<Color>(
                      Colors.red)),
            ),
          )
        ]
    );
  }

  void showUsuarioPage({Usuario? usuario}) async{
    final recUsuario = await Navigator.push(context, MaterialPageRoute(
        builder: (context) => UsuarioPage(usuario: usuario,)
    ));

    if(recUsuario != null){
      if(usuario != null){
        await usuarioHelper.updateUsuario(recUsuario);
      } else{
        await usuarioHelper.saveUsuario(recUsuario);
      }
      _getAllUsuarios();
    }
  }

  _deletUsuario(int id){
    usuarioHelper.deletUsuario(id);
    setState(() {
      listUsuarios.removeAt(id);
    });
  }
}
