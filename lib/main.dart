import 'package:flutter/material.dart';
import 'pages/LoginPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ceofood Lojista',
      theme: ThemeData(
        brightness: Brightness.light,
        fontFamily: 'Roboto',
      ),
      home: LoginPage(),
    );
  }
}


