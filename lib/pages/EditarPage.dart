import 'dart:convert';
import 'package:ceofood_lojista/pages/HomePage.dart';
import 'package:flutter/material.dart';

import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:email_validator/email_validator.dart';

class EditarPage extends StatefulWidget {
  @override
  _EditarPageState createState() => _EditarPageState();
}

class _EditarPageState extends State<EditarPage> {

  String URL_SOCKET;

  final nomeController = TextEditingController();

  final emailController = TextEditingController();
  final celularController = new MaskedTextController(mask: '(00)00000-0000');


//  final FocusNode _nomeFocusNode = new FocusNode();
//  final FocusNode _sobrenomeFocusNode = new FocusNode();
//  final FocusNode _emailFocusNode = new FocusNode();
//  final FocusNode _celularFocusNode = new FocusNode();

  final senhaController = TextEditingController();
  final novaSenhaController = TextEditingController();
  final confirmaController = TextEditingController();

  final FocusNode _senhaFocusNode = new FocusNode();
  final FocusNode _novaSenhaFocusNode = new FocusNode();
  final FocusNode _confirmaFocusNode = new FocusNode();

  List<String> errosEditar = [];

  String idUsuario;

  Future<void> _adicionarUsuario(string) async {
    final prefs = await SharedPreferences.getInstance();
    await  prefs.setString('usuario', string);
  }

  String _getOnlyNumbers(String text) {
    String cleanedText = text;
    var onlyNumbersRegex = new RegExp(r'[^\d]');
    cleanedText = cleanedText.replaceAll(onlyNumbersRegex, '');
    return cleanedText;
  }

  _fieldFocusChange(BuildContext context, FocusNode currentFocus,FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  @override
  void dispose() {
    super.dispose();
  }


  initPlatformState() {

    SharedPreferences.getInstance().then((SharedPreferences dados) {

      var jsonUsuario = dados.getString('usuario');
      var usuario = jsonDecode(jsonUsuario);

      nomeController.text = usuario['nome'];
      emailController.text = usuario['email'];
      celularController.text = usuario['celular'];

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => HomePage()));
          },
        ),
        elevation: 0.1,
        backgroundColor: Colors.deepOrange,
        title: Text('Editar dados', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
        actions: <Widget>[

          FlatButton.icon(
            textColor: Colors.white,
            icon: Icon(Icons.save, size: 18,),
            label: Text('Salvar', style: TextStyle(fontSize: 14),),
            onPressed: () {

              errosEditar = [];

              SharedPreferences.getInstance().then((SharedPreferences dados) {

                bool atualizarNome = false;
                bool atualizarSobrenome = false;
                bool atualizarEmail = false;
                bool atualizarCelular = false;
                bool atualizarCPF = false;
                bool atualizarNascimento = false;

                String jsonNome = '';
                String jsonSobrenome = '';
                String jsonEmail = '';
                String jsonCelular = '';
                String jsonCPF = '';
                String jsonNascimento = '';

                String novaData = '';

                var jsonUsuario = dados.getString('usuario');
                var usuario = jsonDecode(jsonUsuario);

                var nome = nomeController.text;

                var email = emailController.text;
                var celular = _getOnlyNumbers(celularController.text);

                if(nome.isNotEmpty){
                  if(nome != usuario['nome']){
                    atualizarNome = true;
                    jsonNome = '"Nome":"$nome"';
                  }
                  else{
                    jsonNome = '"Nome":null';
                  }
                }
                else{
                  jsonNome = '"Nome":null';
                }







                if(email.isNotEmpty){
                  if(email != usuario['email']) {

                    if (EmailValidator.validate(usuario['email']) == true) {
                      atualizarEmail = true;
                      jsonEmail = '"Email":"$email"';
                    }
                    else{
                      errosEditar.add('E-mail inválido.');
                      jsonEmail = '"Email":null';
                    }
                  }
                  else{
                    jsonEmail = '"Email":null';
                  }
                }
                else{
                  jsonEmail = '"Email":null';
                }




                if(celular.isNotEmpty) {
                  if(celular != usuario['celular']) {
                    atualizarCelular = true;
                    jsonCelular = '"Celular":"$celular"';
                  }
                  else{
                    jsonCelular = '"Celular":null';
                  }
                }
                else{
                  jsonCelular = '"Celular":null';
                }






              });

            },
          ),
        ],
      ),
      body: new Container(
        padding: EdgeInsets.only(top: 0, left: 20, right: 20),
        color: Colors.white,
        child: new ListView(
          children: <Widget>[

            new SizedBox(height: 30),


            new Padding(padding: const EdgeInsets.fromLTRB(60, 0, 60, 0), child:
              new FlatButton(
                child: new ListTile(
                  title: new Text('Editar imagem', style: TextStyle(color: Colors.white)),
                  leading: new Icon(Icons.image, color: Colors.white),
                ),
                color: Colors.deepOrange,
                textColor: Colors.white,
                padding: const EdgeInsets.all(8.0),
                splashColor: Colors.blueAccent,
                onPressed: () async {
  //                Navigator.push(context, MaterialPageRoute(builder: (context)=> new EditarImagemPage() ));
                },
              ),
            ),



            new SizedBox(height: 30),


            new TextFormField(
              style: TextStyle(fontSize: 15),
              controller: nomeController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: "Nome",
                labelStyle: TextStyle(color: Colors.black38, fontWeight: FontWeight.w400, fontSize: 15),
              ),
            ),

            new TextFormField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: "E-mail",
                labelStyle: TextStyle(color: Colors.black38, fontWeight: FontWeight.w400, fontSize: 15),
              ),
              style: TextStyle(fontSize: 15),
            ),

            new TextFormField(
              controller: celularController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Celular",
                labelStyle: TextStyle(color: Colors.black38, fontWeight: FontWeight.w400, fontSize: 15),
              ),
              style: TextStyle(fontSize: 15),
            ),

            errosEditar.length > 0 ?
            new Padding(padding: const EdgeInsets.fromLTRB(0, 25, 0, 5), child:
            new ListView.builder(
              shrinkWrap: true,
              itemCount: errosEditar.length,
              itemBuilder: (context, index) {
                return new Text(errosEditar[index], style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold));
              },
            )
            ) : Container(),

            new SizedBox(height: 30),

            new Text('ALTERAR SENHA', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),

            new TextFormField(
              focusNode: _senhaFocusNode,
              controller: senhaController,
              onFieldSubmitted: (term){
                _fieldFocusChange(context, _senhaFocusNode, _novaSenhaFocusNode);
              },
              keyboardType: TextInputType.text,
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Senha atual",
                labelStyle: TextStyle(color: Colors.black38, fontWeight: FontWeight.w400, fontSize: 15),
              ),
              style: TextStyle(fontSize: 15),
            ),

            new TextFormField(
              focusNode: _novaSenhaFocusNode,
              controller: novaSenhaController,
              onFieldSubmitted: (term){
                _fieldFocusChange(context, _novaSenhaFocusNode, _confirmaFocusNode);
              },
              keyboardType: TextInputType.text,
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Nova senha",
                labelStyle: TextStyle(color: Colors.black38, fontWeight: FontWeight.w400, fontSize: 15),
              ),
              style: TextStyle(fontSize: 15),
            ),

            new TextFormField(
              focusNode: _confirmaFocusNode,
              controller: confirmaController,
              keyboardType: TextInputType.text,
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Confirme a senha",
                labelStyle: TextStyle(color: Colors.black38, fontWeight: FontWeight.w400, fontSize: 15),
              ),
              style: TextStyle(fontSize: 15),
            ),


            new Padding(padding: const EdgeInsets.fromLTRB(100, 20, 100, 10), child:
              FlatButton(
                color: Colors.deepOrange,
                textColor: Colors.white,
                padding: EdgeInsets.all(15.0),
                splashColor: Colors.teal,
                child: Text("Salvar nova senha", style: TextStyle(fontSize: 13.0)),
                onPressed: () {


                },
              ),
            ),





            new SizedBox(height: 30),

          ],
        ),
      ),
    );
  }
}