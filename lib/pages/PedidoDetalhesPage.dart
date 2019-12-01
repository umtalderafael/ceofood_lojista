import 'package:ceofood_lojista/pages/PedidoStatusPage.dart';
import 'package:flutter/material.dart';
import 'package:ceofood_lojista/model/modelProduto.dart';

import 'package:badges/badges.dart';

class PedidoDetalhesPage extends StatefulWidget {

  PedidoDetalhesPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _PedidoDetalhesPageState createState() => _PedidoDetalhesPageState();
}

class _PedidoDetalhesPageState extends State<PedidoDetalhesPage> {

  List<ModelProduto> listaProdutos = [];

  @override
  void initState() {
    super.initState();
    carregarListaProdutos();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Color hexToColor(String code) {
    return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }
  
  carregarListaProdutos(){
    listaProdutos.add(new ModelProduto('2', 'X-Bacon', '12,00', '24,00'));
    listaProdutos.add(new ModelProduto('1', 'X-Egg', '16,00', '16,00'));
    listaProdutos.add(new ModelProduto('3', 'Batata Frita', '5,00', '15,00'));
    listaProdutos.add(new ModelProduto('2', 'Refrigerante Lata 350ml', '4,00', '8,00'));
    listaProdutos.add(new ModelProduto('1', 'Suco Del Vale Lata 350ml', '4,00', '4,00'));
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar:  AppBar(
        title: Text('Pedido #45654645'),
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



          FlatButton.icon(
            textColor: Colors.white,
            icon: Icon(Icons.forward_5, size: 18,),
            label: Text('Status', style: TextStyle(fontSize: 14),),
            onPressed: () async {

              Navigator.push(context, MaterialPageRoute(builder: (context) => PedidoStatusPage()));

            },
          ),




        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          new Padding(padding: EdgeInsets.fromLTRB(30, 20, 30, 0), child:
            Row(
              children: <Widget>[

                new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[

                    InkWell(
                      onTap: (){

  //                      Navigator.push(context, MaterialPageRoute(builder: (context) => PedidoStatusPage()));

                      },
                      child: new Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: hexToColor('#1B91EB')
                          ),
                          child:
                          new Padding(padding: const EdgeInsets.all(15), child:
                          new Container(
                            width: 25,
                            height: 25,
                            decoration: new BoxDecoration(
                              image: new DecorationImage(
                                  image: new ExactAssetImage('assets/status/aceito.png'),
                                  fit: BoxFit.contain
                              ),
                            ),
                          ),
                          )
                      ),
                    ),

                    new Container(
                      width: 60,
                      child: new Text('Aceito',
                        textAlign: TextAlign.center, style: TextStyle(fontSize: 12, color: Colors.black),
                      ),
                    )

                  ],
                ),


                new Padding(padding: const EdgeInsets.fromLTRB(25, 30, 0, 30),
                  child: new Text('Data: 22/11/2019 as 22:30', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),),
                ),



              ],

            ),
          ),


          new Padding(padding: const EdgeInsets.fromLTRB(30, 20, 30, 20), child:
            new Card(
              elevation: 8,
              child: new ListTile(
                leading: CircleAvatar(
                  child: Image.asset('assets/user.png'),
                ),
                title: Text('Rafael Carvalho'),
                subtitle: Text('(17) 98224-5938'),
              ),
            ),
          ),


          new Padding(padding: const EdgeInsets.fromLTRB(25, 10, 0, 10),
            child: new Text('Detalhes', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),),
          ),

          new Padding(padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
            child: Divider(color: Colors.grey,),
          ),

          new Expanded(child:

            new Padding(padding: const EdgeInsets.fromLTRB(30, 0, 30, 0), child:

              new ListView.builder(
                padding: EdgeInsets.all(0),
                itemCount: listaProdutos.length,
                itemBuilder: (context, index) {

                  return new Column(
                    children: <Widget>[

                      new SizedBox(height: 10,),

                      new Row(
                        children: <Widget>[

                          Badge(
                            badgeColor: Colors.deepOrange,
                            badgeContent: Text('${listaProdutos[index].qtd}', style: TextStyle(color: Colors.white)),

                          ),

                          SizedBox(width: 10,),


                          new Expanded(child: new Text('${listaProdutos[index].nome}',
                            style: TextStyle(fontSize: 16 ) ,),
                          ),

                          new Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[

                              new Text('R\u0024 ${listaProdutos[index].valor_unitario}',
                                style: TextStyle(fontSize: 14),
                                textAlign: TextAlign.right,
                              ),

                              new Text('R\u0024 ${listaProdutos[index].valor_total}',
                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                                textAlign: TextAlign.right,
                              ),

                            ],
                          )



                        ],
                      ),

                      new SizedBox(height: 10,),

                      Divider(color: Colors.grey,)

                    ],
                  );

                }),

            ),
          ),

          new Expanded(
            child: new Align(
                alignment: Alignment.bottomCenter,
                child: new Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[

                    new Padding(padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                      child: Divider(color: Colors.grey,),
                    ),

                    new Padding(padding: const EdgeInsets.fromLTRB(30, 0, 30, 0), child:

                      new Row(
                        children: <Widget>[

                          new Expanded(child: new Text('Pagamento:',
                            style: TextStyle(color: Colors.black38, fontSize: 15),),
                          ),

                          new Expanded(child: new Text("Cartão de crédito",
                            style: TextStyle(color: Colors.black38, fontSize: 15),
                            textAlign: TextAlign.right,),
                          )

                        ],
                      ),

                    ),





                    new Padding(padding: const EdgeInsets.fromLTRB(30, 0, 30, 0), child:

                      new Row(
                        children: <Widget>[

                          new Expanded(child: new Text('Cupom de desconto:',
                            style: TextStyle(color: Colors.black38, fontSize: 15),),
                          ),

                          new Expanded(child: new Text("R\u0024 5,00",
                            style: TextStyle(color: Colors.black38, fontSize: 15),
                            textAlign: TextAlign.right,),
                          )

                        ],
                      ),

                    ),




                    new Padding(padding: const EdgeInsets.fromLTRB(30, 0, 30, 0), child:

                      new Row(
                        children: <Widget>[

                          new Expanded(child: new Text('Subtotal:',
                            style: TextStyle(color: Colors.black38, fontSize: 15),),
                          ),

                          new Expanded(child: new Text("R\u0024 40,00",
                            style: TextStyle(color: Colors.black38, fontSize: 15),
                            textAlign: TextAlign.right,),
                          )

                        ],
                      ),

                    ),

                    new Padding(padding: const EdgeInsets.fromLTRB(30, 0, 30, 0), child:

                      new Row(
                        children: <Widget>[

                          new Expanded(child: new Text('Taxa de entrega:',
                              style: TextStyle(color: Colors.black38, fontSize: 15)),
                          ),

                          new Expanded(child: new Text("R\u0024 5,00",
                            style: TextStyle(color: Colors.black38, fontSize: 15),
                            textAlign: TextAlign.right,
                          ),)

                        ],
                      ),

                    ),


                    new Padding(padding: const EdgeInsets.fromLTRB(30, 20, 30, 20), child:

                      new Row(
                        children: <Widget>[

                          new Expanded(child: new Text('Valor Total:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500
                          ),),),

                          new Expanded(child: new Text("R\u0024 40,00",
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                            textAlign: TextAlign.right,),
                          )

                        ],
                      ),

                    ),

                  ],
                )
            ),
          ),

        ],
      ),


    );
  }
}