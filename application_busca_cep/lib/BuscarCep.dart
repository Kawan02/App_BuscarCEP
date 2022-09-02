// ignore_for_file: prefer_const_constructors, duplicate_ignore

import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/foundation/key.dart';
import 'package:http/http.dart' as http;

class BuscarCep extends StatefulWidget {
  const BuscarCep({Key? key}) : super(key: key);

  @override
  State<BuscarCep> createState() => _BuscarCepState();
}

class _BuscarCepState extends State<BuscarCep> {
  IconData IconPesquisar = Icons.search;

  Future fetch() async {
    var url = 'https://viacep.com.br/ws/01001000/json/';
    var response = await http.get(url);
    print(response.body);
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
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.deepOrange),
                  onPressed: () {},
                  child: Icon(IconPesquisar),
                ),
              ],
            ),
          ),
          Text(
            "Resultado:",
            style: TextStyle(
              fontSize: 25,
              height: 3,
            ),
          )
        ],
      ),
    );
  }
}
