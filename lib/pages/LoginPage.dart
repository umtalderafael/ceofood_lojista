import 'package:ceofood_lojista/pages/SuportePage.dart';
import 'package:flutter/material.dart' as prefix0;

import 'EsqueciPage.dart';
import 'HomePage.dart';

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rich_alert/rich_alert.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  bool _carregando = false;

  final emailController = TextEditingController();
  final senhaController = TextEditingController();

  FocusNode senhaFocusNode;
  FocusNode emailFocusNode;

  Future<void> _adicionarUsuario(string) async {
    final prefs = await SharedPreferences.getInstance();
    await  prefs.setString('usuario', string);
  }

  @override
  void initState() {
    super.initState();

    senhaFocusNode = FocusNode();
    emailFocusNode = FocusNode();
    emailController.text = 'umtalderafael@hotmail.com';
//    emailController.text = 'rafael@hotmail.com';
//    emailController.text = 'contato@filmaxbox.com';
    senhaController.text = '456789';

  }

  @override
  void dispose() {

    senhaFocusNode.dispose();
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

    Size size = MediaQuery.of(context).size;

    final theme = Theme.of(context);

    Widget conteudo = Container(
      child: new ListView(
        shrinkWrap: true,
        children: <Widget>[

          new SizedBox( width: 150, height: 150, child: Image.asset("assets/entrada.jpg")),

          new SizedBox(height: 30.0),

          Padding(
            padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
            child: new TextFormField(
              style: TextStyle(
                color: Colors.white,
                decorationColor: Colors.white,

              ),
              textInputAction: TextInputAction.next,
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: new InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 2.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 2.0),
                  ),
                labelText: 'E-mail',
                prefixStyle: TextStyle(color: Colors.white, decorationColor: Colors.white),
                labelStyle: theme.textTheme.caption.copyWith(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                border: OutlineInputBorder()
              ),
              focusNode: emailFocusNode,
              onFieldSubmitted: (term){
                FocusScope.of(context).requestFocus(senhaFocusNode);
              },
            ),
          ),

          new SizedBox(height: 15.0),

          Padding(
            padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
            child: new TextFormField(
              style: TextStyle(
                color: Colors.white,
                decorationColor: Colors.white
              ),
              textInputAction: TextInputAction.next,
              controller: senhaController,
              obscureText: true,
              decoration: new InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 2.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 2.0),
                  ),
                labelText: 'Senha',
                labelStyle: theme.textTheme.caption.copyWith(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                border: OutlineInputBorder()
              ),
              focusNode: senhaFocusNode,
              onFieldSubmitted: (term){
                FocusScope.of(context).requestFocus(emailFocusNode);
              },
            ),
          ),

          new SizedBox(
            height: 20.0,
          ),

          new Padding(padding: const EdgeInsets.fromLTRB(100, 0, 100, 0), child:
          new Container(
            width: 10,
            height: 60,
            alignment: Alignment.centerLeft,
            decoration: new BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [0.3, 5],
                colors: [ Colors.deepOrange,  Colors.orangeAccent ],
              ),
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
            child:  new FlatButton(
              child: new Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[

                  new Text("ENTRAR",
                    textAlign: TextAlign.left,
                    style: TextStyle( fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20),
                  ),

                  new Container(child:
                    new SizedBox( child:
                      new Icon(FontAwesomeIcons.utensils, color: Colors.white,), height: 28, width: 28
                    )
                  )

                ],
              ),
              onPressed: () async {

                var email = emailController.text;
                var senha = senhaController.text;

                if(email.isNotEmpty){

                  if(senha.isNotEmpty){


                    setState(() {
                      _carregando = true;
                    });


//                    String json = '{"email":"$email","senha":"$senha", "tipo": "app"}';
//
//                    var response = await http.post('', body: json, headers: {"Accept": "application/json"});
//
//                    if(response.statusCode == 200) {
//
//                      var respostaAcesso = jsonDecode(response.body);
//
//                      if(respostaAcesso['status'] == 'sucesso'){
//
//                        var dadosUsuario = respostaAcesso['usuario'];
//
//                        var jsonUsuario = jsonEncode(dadosUsuario);
//
//                        await _adicionarUsuario(jsonUsuario);
//
//                        Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
//                      }
//                      else{
//
//                        setState(() {
//                          _carregando = false;
//                        });
//
//                        alertaErro(context, 'Atenção!', respostaAcesso['mensagem']);
//                      }
//                    }
//                    else{
//
//                      setState(() {
//                        _carregando = false;
//                      });
//
//                      alertaErro(context, 'Atenção!', "Ocorreu um erro na comunicação com o servidor!");
//                    }


                    String json = '{"nome":"Pizzaria Arte Nobre","email":"contato@artenobrepizarria.com.br", "celular":"17982245938", "imagem": "https://static.expressodelivery.com.br/imagens/banners/35795/Expresso-Delivery_48d2f753b05c87739dd7b62b3fa730d9.png", "token":"sf41ds65f4sd6f4sd65f4sd6f54sd6f54sd65f4sd65f4sd65f46sd4"}';
                    await _adicionarUsuario(json);

                    Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));


                  }
                  else{
                    alertaErro(context, 'Atenção!', "Informe a senha para continuar");
                  }
                }
                else{
                  alertaErro(context, 'Atenção!', "Informe o e-mail para continuar");
                }



              },
            ),
          ),
          ),

          new SizedBox(
            height: 25.0,
          ),

          Padding(
            padding: const EdgeInsets.only(
                left: 20.0, right: 20.0, top: 0.0),
            child: new InkWell(
              onTap: (){

                Navigator.push(context, MaterialPageRoute(builder: (context) => EsqueciPage()));

              },
              child: new Container(
                  alignment: Alignment.center,
                  child: new Text("Esqueci a senha", style: new TextStyle(fontSize: 17.0, color: Colors.white))
              ),
            ),
          ),

          new SizedBox(
            height: 45.0,
          ),

        ],
      ),
    );

    Widget principal = Stack(
      children: <Widget>[
        Center(
          child: new Image.asset(
            'assets/home.jpg',
            width: size.width,
            height: size.height,
            fit: BoxFit.cover,
            colorBlendMode: BlendMode.darken,
            color: Colors.black54,
          ),
        ),
        Center(
            child: conteudo
        ),
        Align(
            alignment: Alignment.bottomCenter,
            child: Theme(
                data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
                child: InkWell(
                    onTap: (){

                      Navigator.push(context, MaterialPageRoute(builder: (context) => SuportePage()));

                    },
                    child: new Padding(padding: const EdgeInsets.all(20),
                    child: new Text("Solicitar suporte",
                      textAlign: TextAlign.center,
                      style: new TextStyle(fontSize: 18.0, color: Colors.white, fontWeight: FontWeight.bold)
                  ),
                ))
            )
        ),




      ],
    );

    return new Scaffold(
      backgroundColor: Colors.white,
//      appBar: new AppBar(
//          backgroundColor:Colors.transparent,
//          elevation: 0.5,
//      ),
      body: new ModalProgressHUD(
          child: principal,
          inAsyncCall: _carregando,
          dismissible: false,
          opacity: 1.0,
          color: Colors.white,
          progressIndicator: new Center(child: SizedBox(
              height: 200.0,
              child: new Center(
                child: new Stack(
                  children: <Widget>[
                    new Center(
                      child: new Container(
                        width: 150,
                        height: 150,
                        child: new CircularProgressIndicator(
                          strokeWidth: 15,
                          valueColor: new AlwaysStoppedAnimation<Color>(Colors.deepOrange),
                        ),
                      ),
                    ),
                    new Center(child:
                    new Text("Acessando", style: TextStyle(color: Colors.deepOrange))
                    ),
                  ],
                ),
              )
          ),
          )
      ),


    );
  }
}

