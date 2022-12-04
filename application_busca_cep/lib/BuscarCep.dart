import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get/get.dart';

import 'package:path/path.dart';

class BuscarCep extends StatefulWidget {
  const BuscarCep({Key? key}) : super(key: key);

  @override
  State<BuscarCep> createState() => _BuscarCepState();
}

class _BuscarCepState extends State<BuscarCep> {
  IconData IconPesquisar = Icons.search;

  TextEditingController cepController = TextEditingController();
  String? resultado;
  final loading = ValueNotifier(false);

  String? resultado_logradouro;
  String? resultado_complemento;
  String? resultado_bairro;
  String? resultado_cidade;
  String? resultado_uf;
  String? resultado_ddd;
  final GlobalKey<FormState> _formKey = GlobalKey();

  _consultarCep() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    try {
      
    String cep = cepController.text;

    String url = "https://viacep.com.br/ws/$cep/json/";

    http.Response response;

    response = await http.get(url);

    Map<String, dynamic> retorno = json.decode(response.body);

    String logradouro = retorno["logradouro"];
    String complemento = retorno["complemento"];
    String bairro = retorno["bairro"];
    String cidade = retorno["localidade"];
    String uf = retorno["uf"];
    String ddd = retorno["ddd"];

    //     setState(() {
    //   resultado = "$logradouro, $complemento\n $bairro,\n $cidade, $uf, $ddd";
    // });

    setState(() {
      resultado_logradouro = logradouro;
      resultado_complemento = complemento;
      resultado_bairro = bairro;
      resultado_cidade = cidade;
      resultado_uf = uf;
      resultado_ddd = ddd;
    });
    } on Exception catch (e) {
      // ignore: unnecessary_null_comparison
      if(resultado == null)  {
        Get.snackbar("Atenção", "Error $e");
      }
    }
  }

  @override
  void initState() {
    super.initState();
    resultado_logradouro;
    resultado_complemento;
    resultado_bairro;
    resultado_cidade;
    resultado_uf;
    resultado_ddd;
  }

  @override
  void dispose() {
    super.dispose();
    resultado_logradouro;
    resultado_complemento;
    resultado_bairro;
    resultado_cidade;
    resultado_uf;
    resultado_ddd;
  }

  String? total;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Busca CEP"),
          centerTitle: true,
          backgroundColor: Colors.deepOrange,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      validator: (cep) {
                        if (cep == null || cep.isEmpty) {
                          return 'Esse campo é obrigatorio';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: "Insira um CEP",
                        prefixIcon: Icon(
                          Icons.maps_home_work,
                        ),
                      ),
                      controller: cepController,
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepOrange),
                    onPressed: () async {
                      if (loading.value) return;
                      setState(() => loading.value = true);
                      await Future.delayed(const Duration(milliseconds: 5000));
                      setState(() => loading.value = false);
                      await _consultarCep();
                      cepController.clear();
                    },
                    child: AnimatedBuilder(
                        animation: loading,
                        builder: (context, _) {
                          return loading.value
                              ? const MouseRegion(
                                  cursor: SystemMouseCursors.forbidden,
                                  child: SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Colors.deepOrange),
                                      backgroundColor: Colors.white,
                                      strokeWidth: 5,
                                    ),
                                  ),
                                )
                              : Icon(IconPesquisar);
                        }),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Expanded(
                flex: 1,
                child: Column(
                  children: [
                    AnimatedBuilder(
                        animation: loading,
                        builder: (context, _) {
                          return loading.value
                              ? const SizedBox(
                                  width: 40,
                                  height: 40,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.deepOrange),
                                    backgroundColor: Colors.white,
                                    strokeWidth: 5,
                                  ),
                                )
                              : Center(
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Visibility(
                                          visible: resultado_logradouro != null
                                              ? true
                                              : false,
                                          child: Text(resultado_logradouro !=
                                                  null
                                              ? "Logradouro:  $resultado_logradouro"
                                              : "Logradouro não localizado")),
                                      Visibility(
                                        visible: resultado_complemento != null
                                            ? true
                                            : false,
                                        child: Text(resultado_complemento !=
                                                null
                                            ? "Complemento: $resultado_complemento"
                                            : "Complemento não localizado"),
                                      ),
                                      Visibility(
                                          visible: resultado_bairro != null
                                              ? true
                                              : false,
                                          child: Text(resultado_bairro != null
                                              ? "Bairro: $resultado_bairro"
                                              : "Bairro não localizado")),
                                      Visibility(
                                          visible: resultado_cidade != null
                                              ? true
                                              : false,
                                          child: Text(resultado_cidade != null
                                              ? "Cidade: $resultado_cidade"
                                              : "Cidade não localizada")),
                                      Visibility(
                                          visible: resultado_uf != null
                                              ? true
                                              : false,
                                          child: Text(resultado_uf != null
                                              ? "Estado: $resultado_uf"
                                              : "Estado não localizado")),
                                      Visibility(
                                          visible: resultado_ddd != null
                                              ? true
                                              : false,
                                          child: Text(resultado_ddd != null
                                              ? "DDD: $resultado_ddd"
                                              : "DDD não localizado")),
                                    ],
                                  ),
                                );
                        }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
