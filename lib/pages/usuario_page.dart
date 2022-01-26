import 'package:agenda_contatos_sozinho/model/model_usuario.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UsuarioPage extends StatefulWidget {

  final Usuario? usuario;

  UsuarioPage({this.usuario});

  @override
  _UsuarioPageState createState() => _UsuarioPageState();
}

class _UsuarioPageState extends State<UsuarioPage> {

  TextEditingController _editingControllerNome = TextEditingController();
  TextEditingController _editingControllerIdade = TextEditingController();
  TextEditingController _editingControllerEmail = TextEditingController();

  Usuario? editingUsuario;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.usuario == null){
      editingUsuario = Usuario();
    } else{
      editingUsuario = Usuario.fromMap(widget.usuario!.toMap());

      _editingControllerNome.text = editingUsuario!.nome!;
      _editingControllerIdade.text = editingUsuario!.idade!;
      _editingControllerEmail.text = editingUsuario!.email!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Usuario"),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            showTextfild("Nome", _editingControllerNome),
            showTextfild("Idade", _editingControllerIdade),
            showTextfild("Email", _editingControllerEmail),
          ],
        )
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.save, size: 30),
          backgroundColor: Colors.green,
          onPressed: (){

            if(editingUsuario!.nome != null){
              Navigator.pop(context, editingUsuario);
            }
          }
      ),
    );
  }

  Widget showTextfild(String text, TextEditingController editingController){
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: TextField(
        controller: editingController,
        textAlign: TextAlign.center,
        onChanged: (digitado){
          if(text == "Nome"){
            editingUsuario!.nome = digitado;
          }
          if(text == "Idade"){
            editingUsuario!.idade = digitado;
          }
          if(text == "Email"){
            editingUsuario!.email = digitado;
          }
        },
        decoration: InputDecoration(
          hintText: text,
          filled: true,							//temos que colocar como true para que a cor do fillcolor funcione
          fillColor: Colors.white,						//cor de fundo da caixa de texto
          focusedBorder: OutlineInputBorder(				//quando clica no texto ele ativa essa borda, out que dizer fora, criar a borda por fora do text
            borderSide: BorderSide(
                color: Colors.black,
                width: 1
            ),
            borderRadius: BorderRadius.circular(32),
          ),
          enabledBorder: OutlineInputBorder(				//quando nao clicamos ele fica com essa borda
            borderSide: BorderSide(						//para alterar a cor da borda circular
                color: Color(0xff25D366),
                width: 1
            ),
            borderRadius: BorderRadius.circular(32),
          ),
        ),
      ),
    );
  }
}
