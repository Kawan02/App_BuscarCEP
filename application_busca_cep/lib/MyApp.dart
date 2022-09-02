import 'package:application_busca_cep/BuscarCep.dart';
import 'package:flutter/material.dart';
import 'HomePage_Login.dart';
// import 'package:http/http.dart' as http;
// import 'BuscarCep.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Login(),
    );
  }
}
