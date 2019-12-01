//import 'package:filmaxbox/components/sidebar.dart';
//import 'package:filmaxbox/model/modelDestaques.dart';

//import 'package:filmaxbox/pages/inicio/FilmeDetalhesPage.dart';
//import 'ConfiguracoesPage.dart';
//import 'DestaquePage.dart';
//import 'FiltrarPage.dart';
//import '../ImagemPage.dart';
//import '../usuario/LoginPage.dart';
//import 'OrdemPage.dart';
//import 'PesquisarPage.dart';

import 'package:ceofood_lojista/components/sidebar.dart';
import 'package:ceofood_lojista/model/modelPedido.dart';

import 'dart:io';
import 'dart:async';
import 'dart:convert';
//import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:connectivity/connectivity.dart';
//import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//import 'package:cached_network_image/cached_network_image.dart';
import 'package:animated_card/animated_card.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

bool _conectado = false;
bool _logado = false;
bool _carregando = false;

String usuarioNome;
String usuarioEmail;
String usuarioImagem;
String token;

String _connectionStatus = 'Unknown';

Connectivity connectivity;
StreamSubscription<ConnectivityResult> subscription;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();


  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  List<ModelPedido> listaPedidos = [];

  bool _mostrarPedidos = true;


  @override
  void initState() {

    super.initState();

    verificarConexao();

    SharedPreferences.getInstance().then((SharedPreferences dados) {

      if (dados.containsKey('usuario')) {


        var jsonUsuario = dados.getString('usuario');
        var usuario = jsonDecode(jsonUsuario);

        usuarioNome = usuario['nome'];
        usuarioEmail = usuario['email'];
        usuarioImagem = usuario['imagem'];
        token = usuario['token'];

//        if (dados.containsKey('template')) {
//          _template = dados.getString('template');
//        }
//        else{
//          adicionarTemplate('poster');
//          _template = 'poster';
//        }


        carregarPedidos();
      }
      else {


      }

    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> adicionarTemplate(string) async {
    final prefs = await SharedPreferences.getInstance();
    await  prefs.setString('template', string);
  }

  Future<void> adicionarOrdem(string) async {
    final prefs = await SharedPreferences.getInstance();
    await  prefs.setString('ordem', string);
  }

  Color hexToColor(String code) {
    return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }

  verificarConexao(){

    connectivity = new Connectivity();

    subscription = connectivity.onConnectivityChanged.listen((ConnectivityResult result) {

      _connectionStatus = result.toString();

      if (result == ConnectivityResult.wifi || result == ConnectivityResult.mobile) {
        _conectado = true;
      }
      else {
        _conectado = false;
      }

      setState(() {});
    });
  }

  formatarData(data){
    var arrayData = data.split('-');
    String novaData = arrayData[2] + '/' + arrayData[1] + '/' + arrayData[0];
    return novaData;
  }

  carregarPedidos() async {

    setState(() {
      listaPedidos = [];
      _carregando = false;
    });

//    String url = '';
//    var response = await http.get(url, headers: {"Accept": "application/json"});
//    var dadosPedidos = jsonDecode(response.body);

  }

  Future<void> _handleRefresh() {

//    carregarPedidos();

    final Completer<void> completer = Completer<void>();

    Timer(const Duration(seconds: 1), () {
      completer.complete();
    });

    return completer.future.then<void>((_) {
      _scaffoldKey.currentState?.showSnackBar(SnackBar(
          content: const Text('Atualização completa'),
          action: SnackBarAction(
              label: 'Tentar novamente',
              onPressed: () {
                _refreshIndicatorKey.currentState.show();
              })));
    });
  }

  Future<bool> _exitApp(BuildContext context) {

    return  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Atenção!"),
          content: new Text("Tem certeza que deseja sair?"),
          actions: <Widget>[

            new FlatButton(
              child: new Text("Ficar"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            new FlatButton(
              child: new Text("Sair"),
              onPressed: () {
                exit(0);
              },
            ),

          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    Widget navBarLogado = AppBar(

      iconTheme: new IconThemeData(color: Colors.deepOrange),

      elevation: 0.5,
      leading: new IconButton(
        padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
        icon: Image(image: AssetImage('assets/logo_icon.png')),
        onPressed: () {
          _scaffoldKey.currentState.openDrawer();
        },
      ),
      backgroundColor: Colors.deepOrange,
      actions: <Widget>[

        new FlatButton.icon(
          textColor: Colors.white,
          icon: Icon(Icons.history, size: 14,), //`Icon` to display
          label: Text('Concluídos', style: TextStyle(fontSize: 14)), //`Text` to display
          onPressed: () {
//            Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => new PedidosFinalizadosPage()));
          },
        ),

      ],
    );



    Widget sidebar = new Sidebar(

        nome: usuarioNome,
        email: usuarioEmail,
        imagem: usuarioImagem
    );

    Widget carregando = new Center(child:
    SizedBox(
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
                    valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                ),
              ),
              new Center(child:
              new Text("Carregando",
                  style: TextStyle(color: Colors.white)
              )
              ),
            ],
          ),
        )
    ),
    );

    Widget appDesconectado = ListView(
      children: <Widget>[

        new Padding(padding: const EdgeInsets.all(30.0),
          child: Image.asset('assets/logo_icon.png'),
        ),
        new Padding(padding: const EdgeInsets.fromLTRB(30, 10, 30, 20),
          child: SizedBox(
            width: 135,
            height: 135,
            child: Image.asset("assets/semsinal.png"),
          ),
        ),

        new Container(
            child: new Center(
              child: new Padding(padding: const EdgeInsets.fromLTRB(30, 5, 30, 0),
                child: new Text('Desconectado',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0 )
                ),
              ),
            )
        ),

        new Container(
            child: new Center(
              child: new Padding(padding: const EdgeInsets.fromLTRB(0, 5.0, 0, 0),
                child: new Text('Ative a conexão de dados ou o Wi-fi do seu dispositivo',
                    style: TextStyle(fontSize: 12.0 )
                ),
              ),
            )
        ),

      ],
    );





    Widget listagem = new ListView.builder(
      itemCount: 20,
      itemBuilder: (context, index) {

        return new ListTile(
          onTap: (){

            print('card');


          },
          title: new AnimatedCard(
            direction: AnimatedCardDirection.left, //Initial animation direction
            initDelay: Duration(milliseconds: 0), //Delay to initial animation
            duration: Duration(milliseconds: 1000), //Initial animation duration
            child: new Card(
//                margin: EdgeInsets.all(5),
                elevation: 5,
                child: new Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/home.jpg"),
                      fit: BoxFit.cover,
                      colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.6), BlendMode.dstATop),
                    ),
                  ),
                  child: new Padding(padding: const EdgeInsets.fromLTRB(10, 0, 0, 10),
                      child: new Row(
                        children: <Widget>[

                          new Column(
                            children: <Widget>[

                              new Container(
                                width: 60,
                                child: new Text('Pedido',
                                  textAlign: TextAlign.center, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                                ),
                              ),

                              new Container(
                                width: 60,
                                child: new Text('#562452',
                                  textAlign: TextAlign.center, style: TextStyle(fontSize: 10),
                                ),
                              ),

                              new SizedBox(height: 10),

                              InkWell(
                                onTap: (){
                                  
                                  print('apertou');

                                },
                                child: new Container(
                                    width: 60,
                                    height: 60,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: hexToColor('#FF6417')
                                    ),
                                    child:
                                    new Padding(padding: const EdgeInsets.all(15), child:
                                    new Container(
                                      width: 25,
                                      height: 25,
                                      decoration: new BoxDecoration(
                                        image: new DecorationImage(
                                            image: new ExactAssetImage('assets/status/analise.png'),
                                            fit: BoxFit.contain
                                        ),
                                      ),
                                    ),
                                    )
                                ),
                              ),



                              new Container(
                                width: 60,
                                child: new Text('Análise',
                                  textAlign: TextAlign.center, style: TextStyle(fontSize: 10, color: Colors.white),
                                ),
                              )

                            ],
                          ),

                          new Padding(padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                            child: new Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[

                                new Container(
                                    width: MediaQuery.of(context).size.width * 0.65,
                                    height: 25,
                                    child: new ListTile(
                                      leading: Icon(Icons.person, size: 18,),
                                      contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                      title: new Text('Rafael Carvalho',
                                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)
                                      ),

                                    )
                                ),

                                new Container(
                                    width: MediaQuery.of(context).size.width * 0.65,
                                    height: 25,
                                    child: new ListTile(
                                      leading: Icon(Icons.calendar_today, size: 18,),
                                      contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                      title: new Text('22/11/2019 as 19:00', style: TextStyle(fontSize: 14)),
                                    )
                                ),

                                Divider(color: Colors.black,),

                                new Container(
                                    width: MediaQuery.of(context).size.width * 0.65,
                                    height: 45,
                                    child: new ListTile(
                                      leading: Icon(Icons.local_shipping, size: 40,),
                                      contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                      title: new Text('Delivery', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                                      subtitle: new Text('Taxa de entrega - R\u0024 5,00'),
                                    )
                                ),

                                Divider(color: Colors.black,),

                                new Container(
                                    width: MediaQuery.of(context).size.width * 0.65,
                                    height: 50,
                                    child: new ListTile(
                                      leading: Icon(Icons.monetization_on, size: 40,),
                                      contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                      title: new Text('Cartão Elo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                                      subtitle: new Text('Total - R\u0024 25,00'),
                                    )
                                ),

                                SizedBox(height: 20,)

                              ],
                            ),
                          )

                        ],
                      )
                  ),
                )
            ),
          ),
        );

      },
    );












    Widget nenhumPedido = new Center(
      child: Container(
        child: new Card(
            child: new Padding(padding: const EdgeInsets.all(20), child: new Text('Nenhum pedido encontrado'),)
        ),
      ),
    );

    if(_conectado) {

        return Scaffold(
            key: _scaffoldKey,
            backgroundColor: Colors.white30,
            appBar: navBarLogado,
            drawer: sidebar,
            body: new ModalProgressHUD(
                child: new LiquidPullToRefresh(
                    color: Colors.deepOrangeAccent,
                    backgroundColor: Colors.white,
                    key: _refreshIndicatorKey,
                    onRefresh: _handleRefresh,
                    showChildOpacityTransition: true,
                    child: listagem
                ),
                inAsyncCall: _carregando,
                dismissible: false,
                opacity: 1.0,
                color: Colors.black26,
                progressIndicator: carregando
            ),

        );

    }
    else {

      return new WillPopScope(
          onWillPop: () => _exitApp(context),
          child: new Scaffold(
            key: _scaffoldKey,
            body: new Container(
                padding: EdgeInsets.only(top: 60, left: 40, right: 50),
                color: Colors.white,
                child: appDesconectado
            ),
          )
      );

    }
  }
}

