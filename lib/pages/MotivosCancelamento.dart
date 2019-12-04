import 'dart:convert';
import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
//import 'package:location/location.dart';
//import 'package:google_maps_flutter/google_maps_flutter.dart';
//import 'package:http/http.dart' as http;
//import 'package:rflutter_alert/rflutter_alert.dart';
//import 'package:manda_manipular/pages/home_page.dart';
//import 'package:manda_manipular/pages/endereco/salvar_endereco_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:nice_button/nice_button.dart';

class MotivoCancelamentoPage extends StatefulWidget {

  String idPedido;

  MotivoCancelamentoPage({
    this.idPedido
  });

  _MotivoCancelamentoPageState createState() => _MotivoCancelamentoPageState();
}

class _MotivoCancelamentoPageState extends State<MotivoCancelamentoPage> {

  String URL_SOCKET;

  bool mostrarCarregando = true;
  bool mostrarOutro = false;
  bool mostrarLista = false;
  String _motivo;



  final motivoController = TextEditingController();
  final FocusNode _motivoFocusNode = new FocusNode();

  @override
  void initState() {
    super.initState();

  }

  @override
  void dispose() {
    super.dispose();
  }

  void _handleRadioValueChange(value) {

    if(value == '4') {
      mostrarOutro = true;
    }
    else {
      mostrarOutro = false;
    }
    _motivo = value;
    setState(() {});
  }

  @override
  Widget build(BuildContext context)  {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepOrange,
          title: Text('Escolha um motivo'),
        ),
        body:

        new Container(
          padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              new ListView(
                shrinkWrap: true,
                children: <Widget>[

                  new ListTile(
                    title: new Row(
                      children: <Widget>[
                        new Radio(value: '1', groupValue: _motivo, onChanged: _handleRadioValueChange ),
                        new Text('Fechamos o restaurante', style: new TextStyle(fontSize: 16.0)),
                      ],
                    )
                  ),

                  new ListTile(
                      title: new Row(
                        children: <Widget>[
                          new Radio(value: '2', groupValue: _motivo, onChanged: _handleRadioValueChange ),
                          new Text('Acabou o estoque', style: new TextStyle(fontSize: 16.0)),
                        ],
                      )
                  ),

                  new ListTile(
                      title: new Row(
                        children: <Widget>[
                          new Radio(value: '3', groupValue: _motivo, onChanged: _handleRadioValueChange ),
                          new Text('Limite de pedidos excedido', style: new TextStyle(fontSize: 16.0)),
                        ],
                      )
                  ),


                ],
              ),

              mostrarOutro ? new Padding(padding: const EdgeInsets.fromLTRB(35, 10, 30, 0), child: new TextFormField(
                style: TextStyle(fontSize: 15),
                focusNode: _motivoFocusNode,
                controller: motivoController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: "Digite o motivo",
                  labelStyle: TextStyle(color: Colors.black38, fontWeight: FontWeight.w400, fontSize: 15),
                ),
              )) : Container(),

              new Padding(padding: const EdgeInsets.fromLTRB(20, 30, 0, 10),
                  child: new NiceButton(
                    padding: const EdgeInsets.all(15),
                    text: "Confirmar",
                    background: Colors.deepOrange,
                    gradientColors: [Colors.red, Colors.redAccent],
                    onPressed: () {
                      var JsonCancelmento = '{"id": "$_motivo", "motivo": "${motivoController.text}", "idPedido": "${widget.idPedido}"}';
                      Navigator.pop(context, JsonCancelmento);
                    },
                  )
              ),

            ],
          ),
        )



    );
  }
}

