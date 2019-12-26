import 'dart:convert';
import 'package:ceofood_lojista/pages/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:string_mask/string_mask.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cached_network_image/cached_network_image.dart';


String _nome = '';
String _sobrenome = '';
String _email = '';
String _data = '';
String _cpf = '';
String _phone = '';
String _cidade = '';
String _estado = '';
String _imagem;

bool mostrarEndereco = false;
bool mostrarNascimento = false;
bool mostrarCPF = false;

class PerfilPage extends StatefulWidget {

  @override
  _PerfilPageState createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  @override
  void dispose() {

    super.dispose();
  }

  initPlatformState() async {

    SharedPreferences.getInstance().then((SharedPreferences dados) {

      var jsonUsuario = dados.getString('usuario');
      var usuario = jsonDecode(jsonUsuario);

      _nome = 'Rafael Carvalho';

      _email = 'umtalderafael@hotmail.com';

      var formatterCelular = new StringMask('(00) 00000-0000');
      _phone = formatterCelular.apply(usuario['celular']);
      _imagem = 'https://cdn.pixabay.com/photo/2012/04/13/21/07/user-33638_960_720.png';

      _cidade = 'São José do Rio Preto';
      _estado = 'SP';

      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        elevation: 8,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: true,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context, false);
          },
        ),
        title: Text('Perfil', style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),),
        actions: <Widget>[

//          new FlatButton.icon(
//            textColor: Colors.deepOrange,
//            icon: Icon(Icons.edit, size: 16,), //`Icon` to display
//            label: Text('Editar', style: TextStyle(fontSize: 12),), //`Text` to display
//            onPressed: () {
////              Navigator.push(context, MaterialPageRoute(builder: (context)=> new EditarPage() ));
//            },
//          ),

        ],
      ),
      body: new SafeArea(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            _imagem != null ?

            new CachedNetworkImage(
              imageUrl: _imagem,
              imageBuilder: (context, imageProvider) => new InkWell(
                child: new CircleAvatar(
                  backgroundColor: Colors.deepOrange,
                  radius: 70,
                  backgroundImage: new CachedNetworkImageProvider(_imagem),
                ),
                onTap: (){
//                  Navigator.push(context, MaterialPageRoute(builder: (context)=> new EditarImagemPage() ));
                },
              ),
              placeholder: (context, url) {

                return new InkWell(
                  child: new CircularProgressIndicator(
                    backgroundColor: Colors.white,
                    valueColor: new AlwaysStoppedAnimation<Color>(Colors.deepOrange),
                  ),
                  onTap: (){
//                    Navigator.push(context, MaterialPageRoute(builder: (context)=> new EditarImagemPage() ));
                  },
                );

              },
              errorWidget: (context, url, error){
                return new Icon(Icons.error, size: 30,);
              },
            ) :
            new InkWell(
              child: new CircleAvatar(
                backgroundColor: Colors.deepOrange,
                radius: 70,
                backgroundImage: AssetImage("images/profile.png"),
              ),
              onTap: (){
//                Navigator.push(context, MaterialPageRoute(builder: (context)=> new EditarImagemPage() ));
              },
            ),

            new Text('$_nome',
                style: TextStyle(fontSize: 18.0, color: Colors.black, fontWeight: FontWeight.bold,fontFamily: 'Pacifico')
            ),

            InkWell(
              child: new Text(_email,
                style: TextStyle(fontFamily: 'Source Sans Pro', fontSize: 14.0, color: Colors.black),
              ),
              onTap: (){
//                Navigator.push(context, MaterialPageRoute(builder: (context)=> new EditarPage() ));
              },
            ),

            new SizedBox(height: 20, width: 200, child: Divider( color: Colors.deepOrange.shade700)),

            new ListView(
              shrinkWrap: true,
              children: <Widget>[

                new InkWell(
                  child: new InfoCard(text: _phone, icon: Icons.phone),
                  onTap: (){
//                    Navigator.push(context, MaterialPageRoute(builder: (context)=> new EditarPage() ));
                  },
                ),

                new InfoCard(
                  text: '$_cidade - $_estado',
                  icon: Icons.location_city,
                )

              ],
            )

          ],
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}


class InfoCard extends StatelessWidget {
  final String text;
  final IconData icon;
  Function onPressed;

  InfoCard({
    @required this.text,
    @required this.icon,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Card(
        color: Colors.deepOrange,
        margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
        child: ListTile(
          leading: Icon(icon, color: Colors.white),
          title: Text(text,
            style: TextStyle(fontFamily: 'Source Sans Pro', fontSize: 13.0, color: Colors.white),
          ),
        ),
      ),
    );
  }
}