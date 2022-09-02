// ignore_for_file: prefer_const_constructors, duplicate_ignore

import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/foundation/key.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BuscarCep extends StatefulWidget {
  const BuscarCep({Key? key}) : super(key: key);

  @override
  State<BuscarCep> createState() => _BuscarCepState();
}

class _BuscarCepState extends State<BuscarCep> {
  IconData IconPesquisar = Icons.search;

  TextEditingController cepController = TextEditingController();
  String? resultado;

  _consultarCep() async {
    String cep = cepController.text;

    String url = "https://viacep.com.br/ws/${cep}/json/";

    http.Response response;

    response = await http.get(url);

    Map<String, dynamic> retorno = json.decode(response.body);

    String logradouro = retorno["logradouro"];
    String complemento = retorno["complemento"];
    String bairro = retorno["bairro"];
    String cidade = retorno["localidade"];
    String uf = retorno["uf"];
    String ddd = retorno["ddd"];

    setState(() {
      resultado = "$logradouro, $complemento\n $bairro,\n $cidade, $uf, $ddd";
    });
  }

  // TextEditingController cepController = new TextEditingController();
  // String? resultado;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Busca CEP"),
        centerTitle: true,
        backgroundColor: Colors.deepOrange,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    keyboardType: TextInputType.number,
                    // controller: cepController,
                    decoration: InputDecoration(
                      labelText: "Insira um CEP",
                      // labelStyle: TextStyle(color: Colors.deepOrange),
                      prefixIcon: Icon(
                        Icons.maps_home_work,
                      ),
                    ),
                    controller: cepController,
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.deepOrange),
                  onPressed: () {
                    _consultarCep();
                  },
                  child: Icon(IconPesquisar),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "${resultado}",
            style: TextStyle(fontSize: 25, height: 1.5),
          ),
        ],
      ),
    );
  }
}
