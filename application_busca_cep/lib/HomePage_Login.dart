// ignore_for_file: prefer_const_constructors, duplicate_ignore
// import 'dart:ffi';
import 'package:application_busca_cep/BuscarCep.dart';
import 'package:flutter/material.dart';
// @dart=2.9

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<Login> {
  bool ocultar = true;
  IconData Iconpassword = Icons.visibility;

  // Função de ver a senha
  visibilityPassword() {
    if (ocultar == true) {
      setState(() {
        ocultar = false;
        Iconpassword = Icons.visibility_off;
      });
    } else {
      setState(() {
        ocultar = true;
        Iconpassword = Icons.visibility;
      });
    }
  }

  String email = '';
  String password = '';

  logar() {
    if (email == 'teste@gmail.com' && password == '2022') {
      setState(() {
        Navigator.of(context).push(
          //pushReplacement
          MaterialPageRoute(builder: (context) => BuscarCep()),
        );
      });
    }
  }

  // final scroll = SingleChildScrollView();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Busca CEP"),
          centerTitle: true,
          backgroundColor: Colors.deepOrange,
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Login", style: TextStyle(fontSize: 25)),
              TextField(
                onChanged: (text) {
                  email = text;
                },
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: "Digite seu e-mail",
                  prefixIcon: Icon(Icons.email),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                onChanged: (senha) {
                  password = senha;
                },
                obscureText: ocultar,
                // ignore: duplicate_ignore
                decoration: InputDecoration(
                    labelText: "Digite sua senha",
                    // ignore: prefer_const_constructors
                    prefixIcon: Icon(
                      Icons.password_sharp,
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        visibilityPassword();
                      },
                      icon: Icon(Iconpassword),
                    )),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  logar();
                },
                style: ElevatedButton.styleFrom(primary: Colors.deepOrange),
                child: Text("Entrar no App"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
