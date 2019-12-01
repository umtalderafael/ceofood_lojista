import 'dart:convert';

import 'package:ceofood_lojista/pages/EditarPage.dart';
import 'package:ceofood_lojista/pages/HomePage.dart';
import 'package:ceofood_lojista/pages/LoginPage.dart';
import 'package:ceofood_lojista/pages/SuportePage.dart';

import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Sidebar extends StatefulWidget {


  final String nome;
  final String email;
  final String imagem;

  const Sidebar({Key key, this.nome, this.email, this.imagem }) : super(key: key);
  _SidebarState createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {

  @override
  void initState(){
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void showToast(String msg, {int duration, int gravity}) {
    Toast.show(msg, context, duration: duration, gravity: gravity);
  }

  Widget build(BuildContext context) {

    return new Drawer(
      elevation: 10,
      child: new ListView(
        padding: const EdgeInsets.all(0),
        children: <Widget>[

          widget.imagem != null ?

          new CachedNetworkImage(
            imageUrl: '${widget.imagem}',
            imageBuilder: (context, imageProvider) => new UserAccountsDrawerHeader(
              currentAccountPicture: GestureDetector(
                onTap: () {
                  Navigator.push(context, PageTransition(type: PageTransitionType.leftToRightWithFade, child: EditarPage()));
                },
                child: new CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: 70,
                  backgroundImage: widget.imagem != null ? CachedNetworkImageProvider(widget.imagem) : AssetImage("assets/user.png"),
                ),
              ),
              accountName: Text(widget.nome),
              margin: const EdgeInsets.all(0),
              onDetailsPressed: (){
                Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeftWithFade, child: EditarPage()));
              },
              accountEmail: Text(widget.email),
              decoration: new BoxDecoration(color: Colors.deepOrange),
            ),
            placeholder: (context, url) {

              return new UserAccountsDrawerHeader(
                currentAccountPicture: GestureDetector(
                  onTap: () {
                    Navigator.push(context, PageTransition(type: PageTransitionType.leftToRightWithFade, child: EditarPage()));
                  },
                  child: new CircularProgressIndicator(
                    backgroundColor: Colors.white,
                    valueColor: new AlwaysStoppedAnimation<Color>(Colors.deepOrange),
                  )
                ),
                accountName: Text(widget.nome),
                margin: const EdgeInsets.all(0),
                onDetailsPressed: (){
                  Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeftWithFade, child: EditarPage()));
                },
                accountEmail: Text(widget.email),
                decoration: new BoxDecoration(color: Colors.deepOrange),
              );

            },
            errorWidget: (context, url, error){

              return  new UserAccountsDrawerHeader(
                accountName: Text(widget.nome),
                accountEmail: Text(widget.email),
                currentAccountPicture: GestureDetector(
                  onTap: () {
                    Navigator.push(context, PageTransition(type: PageTransitionType.leftToRightWithFade, child: EditarPage()));
                  },
                  child: new CircleAvatar(
                      backgroundColor: Colors.grey,
                      radius: 70,
                      child: new Icon(Icons.person, color: Colors.white)
                  ),
                ),

                decoration: new BoxDecoration(
                    color: Colors.deepOrange
                ),
              );

            },
          )

          :

          new UserAccountsDrawerHeader(
            accountName: Text(widget.nome),
            accountEmail: Text(widget.email),
            currentAccountPicture: GestureDetector(
              onTap: () {
                Navigator.push(context, PageTransition(type: PageTransitionType.leftToRightWithFade, child: EditarPage()));
              },
              child: new CircleAvatar(
                  backgroundColor: Colors.grey,
                  radius: 70,
                  child: new Icon(Icons.person, color: Colors.white)
              ),
            ),

            decoration: new BoxDecoration(
                color: Colors.deepOrange
            ),
          ),


          new InkWell(
            onTap: (){
//              Navigator.push(context, PageTransition(type: PageTransitionType.scale, child: PesquisarFilmePage()));
            },
            child: new ListTile(
              title: new Text('Estabelecimento aberto', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green),),
              leading: new Icon(FontAwesomeIcons.doorOpen, color: Colors.green,),
            ),
          ),

          new InkWell(
            onTap: (){
//              Navigator.push(context, PageTransition(type: PageTransitionType.scale, child: PesquisarFilmePage()));
            },
            child: new ListTile(
              title: new Text('Estabelecimento fechado', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),),
              leading: new Icon(FontAwesomeIcons.doorClosed, color: Colors.red,),
            ),
          ),

          Divider(),

          new InkWell(
            onTap: (){
//              Navigator.push(context, PageTransition(type: PageTransitionType.scale, child: PesquisarArtistaPage()));
            },
            child: new ListTile(
              title: new Text('Pedidos concluídos', style: TextStyle(fontWeight: FontWeight.bold),),
              leading: new Icon(FontAwesomeIcons.checkCircle, color: Colors.deepOrange,),
            ),
          ),



          new InkWell(
            child: new ListTile(
              title: new Text('Histórico de pedidos', style: TextStyle(fontWeight: FontWeight.bold)),
              leading: new Icon(FontAwesomeIcons.history, color: Colors.deepOrange,),
            ),
            onTap: () async {

            },
          ) ,

          new InkWell(
            child: new ListTile(
              title: new Text('Suporte'),
              leading: new Icon(FontAwesomeIcons.questionCircle, color: Colors.deepOrange,),
            ),
            onTap: (){

              Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft, child: SuportePage()));

            },
          ),



          new InkWell(
            child: new ListTile(
              title: new Text('Sair'),
              leading: new Icon(Icons.exit_to_app, color: Colors.deepOrange),
            ),
            onTap: () async {

              Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft, child: LoginPage()));
//                    showToast("Usuário desconectado!", duration: Toast.LENGTH_LONG , gravity: Toast.BOTTOM);
//
//              String json = '{"token":"$token"}';
//
//              var response = await http.post('https://filmaxbox.com/api/usuarios/deslogar', body: json, headers: {"Accept": "application/json"});
//
//              if(response.statusCode == 200) {
//
//                var respostaLogout = jsonDecode(response.body);
//
//                if(respostaLogout['status'] == 'sucesso'){
//
//                  SharedPreferences.getInstance().then((SharedPreferences dados) {
//
//                    dados.remove('usuario');
//                    dados.remove('template');
//                    dados.remove('ordem');
//
//                    Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft, child: HomePage()));
//                    showToast("Usuário desconectado!", duration: Toast.LENGTH_LONG , gravity: Toast.BOTTOM);
//                  });
//
//                }
//                else{
//                  showToast("Não foi possível fazer Logout desse usuário!", duration: Toast.LENGTH_LONG , gravity: Toast.BOTTOM);
//                }
//              }
//              else{
//                showToast("Ocorreu um erro na comunicação com o servidor!", duration: Toast.LENGTH_LONG , gravity: Toast.BOTTOM);
//              }

            },
          ),

          new Divider(),
        ],

      ),
    );
  }
}
