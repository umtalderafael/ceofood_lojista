import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rich_alert/rich_alert.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import 'LoginPage.dart';

class EsqueciPage extends StatefulWidget {
  @override
  _EsqueciPageState createState() => _EsqueciPageState();
}

class _EsqueciPageState extends State<EsqueciPage> {

  final emailController = TextEditingController();

  FocusNode emailFocusNode;

  Future<void> _adicionarUsuario(string) async {
    final prefs = await SharedPreferences.getInstance();
    await  prefs.setString('usuario', string);
  }

  @override
  void initState() {
    super.initState();


    emailFocusNode = FocusNode();


  }

  @override
  void dispose() {

    emailFocusNode.dispose();

    super.dispose();
  }

  alertaErro(context, titulo, mensagem){

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return RichAlertDialog(
            alertTitle: richTitle(titulo),
            alertSubtitle: richSubtitle(mensagem),
            alertType: RichAlertType.WARNING,
            actions: <Widget>[
              FlatButton(
                child: Text("OK"),
                onPressed: (){
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {

    Widget conteudo = Container(
      child: new ListView(
        shrinkWrap: true,
        children: <Widget>[

          new SizedBox(height: 30.0),

          new SizedBox( width: 125, height: 125, child: Image.asset("assets/senha.png")),

          Padding(
            padding: const EdgeInsets.only(
                left: 40.0, right: 40.0, top: 0.0),
            child: new Container(
                alignment: Alignment.center,
                child: new Text("Recuperar senha",
                  style: new TextStyle(fontSize: 24.0, color: Colors.black, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                )
            ),
          ),

          new SizedBox(height: 30.0),

          Padding(
            padding: const EdgeInsets.fromLTRB(50, 20, 50, 20),
            child: new TextFormField(
              textInputAction: TextInputAction.next,
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: new InputDecoration(labelText: 'E-mail'),
              focusNode: emailFocusNode,
            ),
          ),

          new SizedBox(
            height: 30.0,
          ),

          new Padding(padding: const EdgeInsets.fromLTRB(100, 0, 100, 0), child:
          new Container(
            width: 250,
            height: 60,
            alignment: Alignment.centerLeft,
            decoration: new BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [0.3, 5],
                colors: [ Colors.deepOrange,  Colors.deepOrangeAccent ],
              ),
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
            child: new SizedBox.expand(
              child: new FlatButton(
                child: new Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[

                    new Text("Enviar",
                      textAlign: TextAlign.left,
                      style: TextStyle( fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20),
                    ),

                    new Container(child:
                      new SizedBox( child:
                        new Icon(FontAwesomeIcons.key, color: Colors.white,), height: 28, width: 28
                      )
                    )
                  ],
                ),
                onPressed: () async {

                  var email = emailController.text;

                  if(email.isNotEmpty){

                    String url = 'https://filmaxbox.com/api/emails/recuperar?email=$email';
                    var response = await http.get(url, headers: {"Accept": "application/json"});
                    var dadosRecuperar = jsonDecode(response.body);

                    if(dadosRecuperar['status'] == 'sucesso'){

                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return RichAlertDialog(
                              alertTitle: richTitle('Senha enviada!'),
                              alertSubtitle: richSubtitle('Agora você já está pronto para fazer login.'),
                              alertType: RichAlertType.SUCCESS,
                              actions: <Widget>[
                                FlatButton(
                                  child: Text("OK"),
                                  onPressed: (){
                                    Navigator.pop(context);
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
                                  },
                                ),
                              ],
                            );
                          });

                    }
                    else{
                      alertaErro(context, 'Atenção!', dadosRecuperar['mensagem']);
                    }
                  }
                  else{
                    alertaErro(context, 'Atenção!', 'Informe um e-mail para continuar');
                  }

                },
              ),
            ),
          ),
          ),

          new SizedBox(
            height: 25.0,
          ),

          Padding(
            padding: const EdgeInsets.only(
                left: 40.0, right: 40.0, top: 0.0),
            child: new Container(
                alignment: Alignment.center,
                child: new Text("Será enviada uma senha provisória para seu e-mail, faça login e cadastre uma nova senha.",
                    style: new TextStyle(fontSize: 14.0, color: Colors.black54),
                  textAlign: TextAlign.center,
                )
            ),
          ),



          new SizedBox(
            height: 45.0,
          ),



        ],
      ),
    );

    return new Scaffold(
      backgroundColor: Colors.white,
      appBar: new AppBar(
        backgroundColor:Colors.transparent,
        elevation: 0.5,
      ),
      body: conteudo
    );
  }
}

