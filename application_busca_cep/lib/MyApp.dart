import 'package:application_busca_cep/Photo_Screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'HomePage_Login.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Login(),
    );
  }
}
