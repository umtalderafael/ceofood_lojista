import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';

class SuportePage extends StatefulWidget {
  @override
  _SuportePageState createState() => new _SuportePageState();
}

class _SuportePageState extends State<SuportePage> {

  String ano = '';

  @override
  void initState(){

    super.initState();
    var now = new DateTime.now();

    setState(() {
      ano = now.year.toString();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  _launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    }
    else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,

        title: new Text('Suporte'),
        actions: <Widget>[

          new FlatButton.icon(
            textColor: Colors.white,
            icon: SizedBox(width: 25, child: Image.asset('assets/whatsapp.png'),),
            label: new Text('What´s App'),
            onPressed: () {

              FlutterOpenWhatsapp.sendSingleMessage(
                  "5517982245938",
                  "Olá, estou utilizando o app CeoFood Lojista e gostaria de tirar uma dúvida."
              );

            },
          ),

        ],
      ),
      body: new ListView(
        shrinkWrap: true,
        children: <Widget>[

          new SizedBox(height: 10),

          new SizedBox(
            width: 300,
            height: 300,
            child: new Image.asset('assets/support.png'),
          ),

          new SizedBox(height: 10),

          new Padding(padding: const EdgeInsets.fromLTRB(20,0,20,0),
              child: new Row(
                children: <Widget>[

                  new Expanded(
                      child: new Padding(padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                        child: new FlatButton.icon(
                          textColor: Colors.white,
                          color: Colors.deepOrange,
                          icon: Icon(Icons.call, size: 16,), //`Icon` to display
                          label: new Text('Ligar'),
                          onPressed: () {
                            _launchURL('tel:+1732215474');
                          },
                        ),
                      )
                  ),

                  new Expanded(
                      child: new Padding(padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                        child: new FlatButton.icon(
                          textColor: Colors.white,
                          color: Colors.deepOrange,
                          icon: Icon(Icons.sms, size: 16,), //`Icon` to display
                          label: new Text('Mensagem'),
                          onPressed: () {
                            _launchURL('sms:+1732215474');
                          },
                        ),
                      )
                  ),

                  new Expanded(
                      child: new Padding(padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                        child: new FlatButton.icon(
                          textColor: Colors.white,
                          color: Colors.deepOrange,
                          icon: Icon(Icons.mail_outline, size: 16,), //`Icon` to display
                          label: new Text('E-mail'),
                          onPressed: () {
                            _launchURL('mailto:atendimento@ceofood.com.br?subject=Contato pelo APP');
                          },
                        ),
                      )
                  ),

                ],
              )
          ),

          Divider(),

          new ListTile(
            title: new Text('E-mail de contato', style: TextStyle(fontWeight: FontWeight.bold),),
            subtitle: new Text('atendimento@ceofood.com.br'),
          ),

          Divider(),

          new ListTile(
            title: new Text('Telefone / What´s App',  style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: new Text('(17) 3221-5474'),
          ),

          Divider(),

          new ListTile(
            title: new Text('Horário de funcionamento', style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: new Text('08:00 às 12:00 e das 13:00 as 17:00'),
          ),

          Divider()

        ],
      ),
      bottomNavigationBar: new Padding(padding: const EdgeInsets.all(5),
          child: new Container(
            padding: const EdgeInsets.all(10),
            child: new Text('Ceofood $ano', textAlign: TextAlign.center, style: TextStyle(color: Colors.grey), ),
          )
      ),

    );
  }
}
