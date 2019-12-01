

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PedidoStatusPage extends StatefulWidget {

  @override
  _PedidoStatusPageState createState() => _PedidoStatusPageState();
}

class _PedidoStatusPageState extends State<PedidoStatusPage> {

  bool mostrarCarregando = true;

  String _formato;



  @override
  void initState() {

    super.initState();

  }

  @override
  void dispose() {
    super.dispose();
  }

  void _handleRadioValueChange(value) {

    _formato = value;
    setState(() {});
  }



  @override
  Widget build(BuildContext context)  {
    return Scaffold(

      appBar:  AppBar(
      title: Text('Escolha um status'),
        elevation: 0.5,
        leading: new IconButton(
          padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
          icon: Icon(Icons.arrow_back),
          onPressed: () {

            Navigator.pop(context, false);

          },
        ),
        backgroundColor: Colors.deepOrange,
        actions: <Widget>[



        ],
      ),

        body:  new Container(
          padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[


              new ListView(
                shrinkWrap: true,
                children: <Widget>[


                  new Container(
                    width: 250,
                    height: 60,
                    alignment: Alignment.centerLeft,
                    decoration: new BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        stops: [0.3, 5],
                        colors: [ Colors.green,  Colors.lightGreen ],
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(0)),
                    ),
                    child: new SizedBox.expand(
                      child: new FlatButton(
                        child: new Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[

                            new Container(
                                height: 28,
                                width: 28,
                                child: new SizedBox(
                                  child: Image.asset('assets/status/aceito.png')
                                )
                            ),

                            new Text("Aceito",
                              textAlign: TextAlign.left,
                              style: TextStyle( fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20),
                            ),


                          ],
                        ),
                        onPressed: () async {

                        },
                      ),
                    ),
                  ),

                  SizedBox(height: 20,),



                  new Container(
                    width: 250,
                    height: 60,
                    alignment: Alignment.centerLeft,
                    decoration: new BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        stops: [0.3, 5],
                        colors: [ Colors.blue,  Colors.blueAccent ],
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(0)),
                    ),
                    child: new SizedBox.expand(
                      child: new FlatButton(
                        child: new Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[

                            new Container(
                                height: 28,
                                width: 28,
                                child: new SizedBox(
                                  child: Image.asset('assets/status/pronto.png')
                                )
                            ),

                            new Text("Em entrega",
                              textAlign: TextAlign.left,
                              style: TextStyle( fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20),
                            ),

                          ],
                        ),
                        onPressed: () async {

                        },
                      ),
                    ),
                  ),

                  SizedBox(height: 20,),



                  new Container(
                    width: 250,
                    height: 60,
                    alignment: Alignment.centerLeft,
                    decoration: new BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        stops: [0.3, 5],
                        colors: [ Colors.indigoAccent,  Colors.indigo ],
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(0)),
                    ),
                    child: new SizedBox.expand(
                      child: new FlatButton(
                        child: new Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[

                            new Container(
                                height: 28,
                                width: 28,
                                child: new SizedBox(
                                  child: Image.asset('assets/status/pendente.png')
                                )
                            ),

                            new Text("Pronto para retirada",
                              textAlign: TextAlign.left,
                              style: TextStyle( fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20),
                            ),


                          ],
                        ),
                        onPressed: () async {

                        },
                      ),
                    ),
                  ),


                  SizedBox(height: 20,),




                  new Container(
                    width: 250,
                    height: 60,
                    alignment: Alignment.centerLeft,
                    decoration: new BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        stops: [0.3, 5],
                        colors: [ Colors.greenAccent,  Colors.green ],
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(0)),
                    ),
                    child: new SizedBox.expand(
                      child: new FlatButton(
                        child: new Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[

                            new Container(
                                height: 28,
                                width: 28,
                                child: new SizedBox(
                                  child: Image.asset('assets/status/concluido.png')
                                )
                            ),

                            new Text("Concluído",
                              textAlign: TextAlign.left,
                              style: TextStyle( fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20),
                            ),



                          ],
                        ),
                        onPressed: () async {

                        },
                      ),
                    ),
                  ),


                  SizedBox(height: 20,),



                  new Container(
                    width: 250,
                    height: 60,
                    alignment: Alignment.centerLeft,
                    decoration: new BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        stops: [0.3, 5],
                        colors: [ Colors.grey,  Colors.black87 ],
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(0)),
                    ),
                    child: new SizedBox.expand(
                      child: new FlatButton(
                        child: new Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[

                            new Container(
                                height: 28,
                                width: 28,
                                child: new SizedBox(
                                    child: Image.asset('assets/status/cancelado.png')
                                )
                            ),

                            new Text("Cancelado",
                              textAlign: TextAlign.left,
                              style: TextStyle( fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20),
                            ),

                          ],
                        ),
                        onPressed: () async {

                        },
                      ),
                    ),
                  ),



                ],
              ),



            ],
          ),
        )

    );
  }
}