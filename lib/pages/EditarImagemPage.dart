import 'dart:io';
import 'dart:convert';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:permission_handler/permission_handler.dart';

class EditarImagemPage extends StatefulWidget {

  @override
  _EditarImagemState createState() => _EditarImagemState();
}

class _EditarImagemState extends State<EditarImagemPage> {

  String URL_SOCKET;
  String URL_PERFIL;

  String idUsuario;

  bool _saving = false;

  var _imagem;
  var _novaImagem;

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
      _imagem = usuario['imagem'];
      idUsuario = usuario['id'];

      setState(() {});
    });
  }

  Future<void> _adicionarUsuario(string) async {
    final prefs = await SharedPreferences.getInstance();
    await  prefs.setString('usuario', string);
  }

  Future getImage(bool isCamera) async {

    if (isCamera) {
      _novaImagem = await ImagePicker.pickImage(source: ImageSource.camera);
    }
    else {
      _novaImagem = await ImagePicker.pickImage(source: ImageSource.gallery);
    }
    setState(() {});
  }


  upload(File imageFile, context) async {

    var stream = new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    var length = await imageFile.length();
    var uri = Uri.parse(URL_PERFIL);
    var request = new http.MultipartRequest("POST", uri);
    request.fields['UsuarioId'] = idUsuario;

    var multipartFile = new http.MultipartFile('file', stream, length, filename: basename(imageFile.path));
    request.files.add(multipartFile);
    var response = await request.send();

    if (response.statusCode == 200) {

      response.stream.transform(utf8.decoder).listen((resposta) {

        var imagem = jsonDecode(resposta);

        SharedPreferences.getInstance().then((SharedPreferences dados) {

          var jsonUsuario = dados.getString('usuario');
          var usuario = jsonDecode(jsonUsuario);
          usuario['imagemPerfil'] = imagem['imagemUrl'];
          _adicionarUsuario(jsonEncode(usuario));

          Toast.show("Imagem do perfil modificada.", context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
//          Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => new PerfilPage()));
        });
      });

    }
    else {
      print('erro no envio da imagem');
    }
  }


  @override
  Widget build(BuildContext context) {

    Widget conteudo = new ListView(
      children: <Widget>[

        new SizedBox(height: 50),

        new Center(
          child: Text('Imagem do perfil', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.white)),
        ),

        new SizedBox(height: 10),

        _imagem != null ?

        new CachedNetworkImage(
          imageUrl: _imagem,
          imageBuilder: (context, imageProvider) => Container(
            width: 200.0,
            height: 200.0,
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: imageProvider,
                fit: BoxFit.contain,
              ),
            ),
          ),
          placeholder: (context, url) {
            return new Center(
              child: new Container(
                width: 150,
                height: 150,
                child: new Padding(padding: const EdgeInsets.all(25), child:
                new CircularProgressIndicator(
                  backgroundColor: Colors.white,
                  valueColor: new AlwaysStoppedAnimation<Color>(Colors.deepOrange),
                )
                ),
              ),
            );
          },
          errorWidget: (context, url, error){
            return new Center(
              child: new Container(
                width: 150,
                height: 150,
                child: new Card(
                  child: new Padding(padding: const EdgeInsets.all(25), child:
                  new Icon(Icons.error, size: 30,
                  ),
                  ),
                ),
              ),
            );
          },
        ) :
        new SizedBox(
            width: 150,
            height: 150,
            child: Image.asset("assets/user.png")
        ),

        new SizedBox(height: 10),

        new Padding(padding: const EdgeInsets.fromLTRB(30, 15, 30, 5),
          child: new FlatButton(
            child: new ListTile(
              title: new Text('Imagem da galeria', style: TextStyle(color: Colors.white),),
              leading: Icon(Icons.image, color: Colors.white,),
            ),
            color: Colors.deepOrange,
            textColor: Colors.white,
            splashColor: Colors.blueAccent,
            onPressed: () async {

              PermissionStatus permission = await PermissionHandler().checkPermissionStatus(PermissionGroup.storage);

              if(permission.toString() == 'PermissionStatus.granted'){
                getImage(false);
              }
              else{

                Map<PermissionGroup, PermissionStatus> permissions = await PermissionHandler().requestPermissions([PermissionGroup.storage]);

                if(permissions.values.toString() == '(PermissionStatus.denied)'){

                  new Alert(
                    context: context,
                    type: AlertType.warning,
                    title: "Atenção",
                    desc: "Precisamos da permissão para enviar arquivos.",
                    buttons: [

                      new DialogButton(
                        width: 120,
                        child: new Text("Tentar novamente", style: TextStyle(color: Colors.white, fontSize: 14)),
                        onPressed: () async {
                          Navigator.pop(context);
                          await PermissionHandler().requestPermissions([PermissionGroup.storage]);
                        },
                      ),

                      new DialogButton(
                        width: 120,
                        child: new Text("Cancelar", style: TextStyle(color: Colors.white, fontSize: 14)),
                        onPressed: (){
                          Navigator.pop(context);
                        },
                      ),

                    ],
                  ).show();

                }
                else{
                  getImage(false);
                }
              }

            },
          ),
        ),

        new Padding(padding: const EdgeInsets.fromLTRB(30, 5, 30, 15),
          child: new FlatButton(
            child: new ListTile(
              title: new Text('Tirar Foto', style: TextStyle(color: Colors.white),),
              leading: Icon(Icons.camera_alt, color: Colors.white,),
            ),
            color: Colors.deepOrange,
            textColor: Colors.white,
            splashColor: Colors.blueAccent,
            onPressed: () async {

              PermissionStatus permission = await PermissionHandler().checkPermissionStatus(PermissionGroup.camera);

              if(permission.toString() == 'PermissionStatus.granted'){
                getImage(true);
              }
              else{

                Map<PermissionGroup, PermissionStatus> permissions = await PermissionHandler().requestPermissions([PermissionGroup.camera]);

                if(permissions.values.toString() == '(PermissionStatus.denied)'){

                  new Alert(
                    context: context,
                    type: AlertType.warning,
                    title: "Atenção",
                    desc: "Precisamos da permissão para tirar fotos com a câmera.",
                    buttons: [

                      new DialogButton(
                        width: 120,
                        child: new Text("Tentar novamente", style: TextStyle(color: Colors.white, fontSize: 14)),
                        onPressed: () async {
                          Navigator.pop(context);
                          await PermissionHandler().requestPermissions([PermissionGroup.camera]);
                        },
                      ),

                      new DialogButton(
                        width: 120,
                        child: new Text("Cancelar", style: TextStyle(color: Colors.white, fontSize: 14)),
                        onPressed: (){
                          Navigator.pop(context);
                        },
                      ),

                    ],
                  ).show();

                }
                else{
                  getImage(true);
                }
              }

            },
          ),
        ),

      ],
    );

    Widget conteudoNovaImagem = new ListView(
      children: <Widget>[

        new SizedBox(height: 50),

        new Center(
          child: Text('Nova imagem',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.white)
          ),
        ),

        new SizedBox(height: 10),

        _novaImagem != null ? new SizedBox(
            width: 150,
            height: 150,
            child: Image.file(_novaImagem)
        ) : Container(),

        new SizedBox(height: 20),

        new Padding(padding: const EdgeInsets.fromLTRB(30, 15, 30, 5),
          child: new FlatButton(
            color: Colors.white,
            textColor: Colors.white,
            splashColor: Colors.blueAccent,
            onPressed: () {
              getImage(false);
            },
            child: new ListTile(
              title: new Text('Imagem da galeria', style: TextStyle(color: Colors.deepOrange),),
              leading: new Icon(Icons.image, color: Colors.deepOrange,),
            ),
          ),
        ),

        new Padding(padding: const EdgeInsets.fromLTRB(30, 5, 30, 15),
          child: new FlatButton(
            color: Colors.white,
            textColor: Colors.white,
//            padding: EdgeInsets.all(8.0),
            splashColor: Colors.blueAccent,
            onPressed: () {
              getImage(true);
            },
            child: new ListTile(
              title: new Text('Tirar Foto', style: TextStyle(color: Colors.deepOrange),),
              leading: new Icon(Icons.camera_alt, color: Colors.deepOrange,),
            ),
          ),
        ),

        new SizedBox(height: 50),

        new Center(
            child: new Text('Deseja salvar a nova imagem?',
                style: TextStyle(fontSize: 14.0, color: Colors.white )
            )
        ),

        new SizedBox(height: 10),

        new Padding(padding: const EdgeInsets.fromLTRB(80, 10, 80, 40), child:
        new FlatButton(
          child: new ListTile(
            title: new Text('Salvar imagem', style: TextStyle(color: Colors.teal),),
            leading: new Icon(Icons.save, color: Colors.teal,),
          ),
          color: Colors.white,
          textColor: Colors.white,
          splashColor: Colors.blueAccent,
          onPressed: () {

            setState(() {
              _saving = true;
            });

            upload(_novaImagem, context);
          },
        ),
        )

      ],
    );

    Widget navBar = new AppBar(
      title: Text('Trocar imagem', style: TextStyle(color: Colors.black),),
      backgroundColor: Colors.white,
      automaticallyImplyLeading: true,
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        color: Colors.black,
        onPressed: () {
          Navigator.pop(context, false);
        },
      ),
    );

    if (_novaImagem == null) {

      return new Scaffold(
          backgroundColor: Colors.white,
          appBar: navBar,
          body: conteudo
      );

    }
    else {

      return new Scaffold(
          backgroundColor: Colors.white,
          appBar: navBar,
          body: new ModalProgressHUD(
              child: conteudoNovaImagem,
              inAsyncCall: _saving,
              dismissible: false,
              opacity: 1.0,
              color: Colors.white,
              progressIndicator: new Center(
                child: SizedBox(
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
                                valueColor: new AlwaysStoppedAnimation<Color>(Colors.teal),
                              ),
                            ),
                          ),
                          new Center(child: new Text("Salvando imagem", style: TextStyle(color: Colors.teal))),
                        ],
                      ),
                    )
                ),
              )
          )
      );

    }
  }
}