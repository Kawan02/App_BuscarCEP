// ignore_for_file: depend_on_referenced_packages
import 'dart:convert';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:application_busca_cep/controller/listas_tarefas_controller.dart';
import 'package:application_busca_cep/model/cep_model.dart';

class BuscarCep extends StatefulWidget {
  const BuscarCep({Key? key}) : super(key: key);

  @override
  State<BuscarCep> createState() => _BuscarCepState();
}

class _BuscarCepState extends State<BuscarCep> {
  ListaCepController cepController = ListaCepController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  String _logradouro = "";
  String _complemento = "";
  String _bairro = "";
  String _cidade = "";
  String _uf = "";
  String _ddd = "";
  final cepFormatter = MaskTextInputFormatter(mask: "#####-###", filter: {"#": RegExp(r"[0-9]")});

  Future<void> _consultarCep() async {
    if (!_formKey.currentState!.validate()) return;

    final Uri url = Uri.parse("https://viacep.com.br/ws/${cepController.controllerTextField.text}/json/");
    http.Response response;
    response = await http.get(url);
    Map<String, dynamic> retorno = json.decode(response.body);

    if (response.statusCode == 200) {
      CepModel cepBaseModel = CepModel(
        cepController: retorno["cep"],
        bairro: retorno["bairro"],
        cidade: retorno["localidade"],
        complemento: retorno["complemento"],
        ddd: retorno["ddd"],
        logradouro: retorno["logradouro"],
        uf: retorno["uf"],
      );
      setState(() {
        _logradouro = cepBaseModel.logradouro;
        _complemento = cepBaseModel.complemento;
        _bairro = cepBaseModel.bairro;
        _cidade = cepBaseModel.cidade;
        _uf = cepBaseModel.uf;
        _ddd = cepBaseModel.ddd;
        showAlertDialog(context);
      });
    } else {
      String message = "Ocorreu um erro. Tente novamente mais tarde!";
      _showErrorDialog(message);
    }
  }

  void showAlertDialog(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return AlertDialog(
          title: Text(cepController.controllerTextField.text),
          content: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("CEP: ${cepController.controllerTextField.text}", textAlign: TextAlign.center),
              Text("Logradouro: $_logradouro", textAlign: TextAlign.center),
              Text("Bairro: $_bairro", textAlign: TextAlign.center),
              Text("Cidade: $_cidade", textAlign: TextAlign.center),
              Text("UF: $_uf", textAlign: TextAlign.center),
              Text("DDD: $_ddd", textAlign: TextAlign.center),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () async {
                var save = await cepController.salvarTarefa(
                  CepModel(
                    cepController: cepController.controllerTextField.text,
                    bairro: _bairro,
                    cidade: _cidade,
                    complemento: _complemento,
                    ddd: _ddd,
                    logradouro: _logradouro,
                    uf: _uf,
                  ),
                );
                setState(() {
                  save;
                  Navigator.of(ctx).pop();
                });
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  void _showErrorDialog(String? message) async {
    return await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Atenção"),
        content: Text(message!,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 20,
            )),
        actions: <Widget>[
          TextButton(
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    cepController.encontrarTarefa();
    super.initState();
  }

  @override
  void dispose() {
    cepController.encontrarTarefa();
    cepController.controllerTextField.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Buscar CEP"),
        centerTitle: true,
        backgroundColor: Colors.deepOrange[400],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: Form(
                      key: _formKey,
                      child: TextFormField(
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return "Esse campo é obrigatorio";
                          }
                          return null;
                        },
                        controller: cepController.controllerTextField,
                        inputFormatters: [cepFormatter],
                        keyboardType: TextInputType.number,
                        autofocus: true,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.maps_home_work),
                          labelText: "Insira um CEP",
                          hintText: "Digite um CEP aqui...",
                          suffixIcon: IconButton(
                            onPressed: () async {
                              await _consultarCep();
                            },
                            icon: const Icon(
                              Icons.search,
                              color: Colors.deepOrange,
                              size: 25,
                              semanticLabel: "Pesquisar",
                            ),
                          ),
                          isDense: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: cepController.encontrarTarefa().isEmpty
                ? const Center(
                    child: Text("A lista de CEP está vazia (:"),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.only(top: 10),
                    shrinkWrap: true,
                    itemCount: cepController.encontrarTarefa().length,
                    itemBuilder: (context, index) {
                      return Dismissible(
                        background: Container(
                          color: Colors.red,
                          child: const Align(
                            alignment: Alignment(-0.9, 0),
                            child: Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        direction: DismissDirection.startToEnd,
                        key: Key(DateTime.now().millisecondsSinceEpoch.toString()),
                        child: ListTile(
                          title: Text(
                            cepController.encontrarTarefa()[index].cepController.isEmpty
                                ? "CEP vazio ou não encontrado"
                                : cepController.encontrarTarefa()[index].cepController,
                          ),
                          leading: CircleAvatar(
                            child: Image.asset("assets/imgs/correios.png"),
                          ),
                          subtitle: Text(
                            "${cepController.encontrarTarefa()[index].logradouro}, ${cepController.encontrarTarefa()[index].bairro}, ${cepController.encontrarTarefa()[index].cidade}, ${cepController.encontrarTarefa()[index].uf}",
                          ),
                        ),
                        onDismissed: (direction) async {
                          var delete = await cepController.deletarTarefa(cepController.encontrarTarefa()[index]);
                          setState(() {
                            delete;
                          });
                        },
                      );
                    }),
          ),
        ],
      ),
    );
  }
}
