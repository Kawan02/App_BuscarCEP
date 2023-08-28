// ignore_for_file: import_of_legacy_library_into_null_safe
import 'dart:io';
import 'package:application_busca_cep/controller/listas_tarefas_controller.dart';
import 'package:application_busca_cep/database/objectbox.g.dart';
import 'package:application_busca_cep/database/objectbox_database.dart';
import 'package:application_busca_cep/model/cep_model.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:core';
import 'package:http/http.dart' as http;
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:objectbox/objectbox.dart';
import 'package:path_provider/path_provider.dart';

class BuscarCep extends StatefulWidget {
  const BuscarCep({Key? key}) : super(key: key);

  @override
  State<BuscarCep> createState() => _BuscarCepState();
}

class _BuscarCepState extends State<BuscarCep> {
  // ObjectBoxDataBase? _dataBase;
  final GlobalKey<FormState> _formKey = GlobalKey();
  TextEditingController cepController = TextEditingController();
  String? resultado;
  String _logradouro = "";
  String _complemento = "";
  String _bairro = "";
  String _cidade = "";
  String _uf = "";
  String _ddd = "";
  // List _cepList = [];
  List cepList = [];
  Map<String, dynamic>? _lastRemoved;
  // List<DataBase>? profile = <DataBase>[];
  // Tarefa dataBaseModel = Tarefa();
  final cepFormatter = MaskTextInputFormatter(mask: "#####-###", filter: {"#": RegExp(r"[0-9]")});

  ListaTarefasController listaTarefasController = ListaTarefasController();

  Future<void> _consultarCep() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final Uri url = Uri.parse("https://viacep.com.br/ws/${listaTarefasController.controllerTextField.text}/json/");

    http.Response response;

    response = await http.get(url);

    Map<String, dynamic> retorno = json.decode(response.body);

    Tarefa dataBaseModel = Tarefa(
      bairro: retorno["bairro"],
      cidade: retorno["localidade"],
      complemento: retorno["complemento"],
      ddd: retorno["ddd"],
      logradouro: retorno["logradouro"],
      uf: retorno["uf"],
      cepController: retorno["cep"],
    );

    setState(() {
      _logradouro = dataBaseModel.logradouro;
      _complemento = dataBaseModel.complemento;
      _bairro = dataBaseModel.bairro;
      _cidade = dataBaseModel.cidade;
      _uf = dataBaseModel.uf;
      _ddd = dataBaseModel.ddd;
      cepList = [_logradouro, _complemento, _bairro, _cidade, _uf, _ddd];
      // listaTarefasController.salvarTarefa(
      //   Tarefa(
      //     cepController: listaTarefasController.controllerTextField.text,
      //     bairro: _bairro,
      //     cidade: _cidade,
      //     complemento: _complemento,
      //     ddd: _ddd,
      //     logradouro: _logradouro,
      //     uf: _uf,
      //     cepList: cepList,
      //   ),
      // );
      showAlertDialog(context);
    });
  }

  void showAlertDialog(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return AlertDialog(
          title: Text(listaTarefasController.controllerTextField.text),
          content: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("CEP: ${listaTarefasController.controllerTextField.text}"),
              Text("Logradouro: $_logradouro"),
              Text("Bairro: $_bairro"),
              Text("Cidade: $_cidade"),
              Text("UF: $_uf"),
              Text("DDD: $_ddd"),
              Text("DDD: $cepList"),
              // Text("CEP: ${listaTarefasController.encontrarTarefa()[0].cepController}"),
              // Text("Logradouro: ${listaTarefasController.encontrarTarefa()[0].logradouro}"),
              // Text("Bairro: ${listaTarefasController.encontrarTarefa()[0].bairro}"),
              // Text("Cidade: ${listaTarefasController.encontrarTarefa()[0].cidade}"),
              // Text("UF: ${listaTarefasController.encontrarTarefa()[0].uf}"),
              // Text("DDD: ${listaTarefasController.encontrarTarefa()[0].ddd}"),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () async {
                setState(() {
                  listaTarefasController.salvarTarefa(
                    Tarefa(
                      cepController: listaTarefasController.controllerTextField.text,
                      // cepController: cepController.text,
                      bairro: _bairro,
                      cidade: _cidade,
                      complemento: _complemento,
                      ddd: _ddd,
                      logradouro: _logradouro,
                      uf: _uf,
                      // cepList: cepList,
                    ),
                  );
                });

                // _addCep();
                Navigator.of(ctx).pop();
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  Future<void> _addCep() async {
    setState(() {
      dynamic newCep = {};
      newCep["title"] = cepController.text;
      newCep["logradouro"] = _logradouro;
      newCep["cidade"] = _cidade;
      newCep["bairro"] = _bairro;
      newCep["complemento"] = _complemento;
      newCep["uf"] = _uf;
      newCep["ddd"] = _ddd;
      var dadosEncode = json.encode(newCep);
      var dadosDecoder = json.encode(dadosEncode);
      // cepList.add(newCep);
      listaTarefasController.todos.add(newCep);

      listaTarefasController.salvarTarefa(
        Tarefa(
          cepController: listaTarefasController.controllerTextField.text,
          // cepController: cepController.text,
          bairro: _bairro,
          cidade: _cidade,
          complemento: _complemento,
          ddd: _ddd,
          logradouro: _logradouro,
          uf: _uf,
          // cepList: cepList,
        ),
      );
      // _saveData();
    });
  }

  // Future<File> _getFile() async {
  //   final directory = await getApplicationDocumentsDirectory();
  //   return File("${directory.path}/data.json");
  // }

  // Future<Box?> _getBox() async {
  //   final store = await _dataBase?.getStore();
  //   // return store.box<CepModel>();
  //   return store?.box<DataBase>();
  // }

  // void getAll() async {
  //   final box = await _getBox();
  //   _cepList = box!.getAll();
  // }

  // void remove() async {
  //   final box = await _getBox();
  //   box?.remove(dataBaseModel.id);
  //   _cepList.remove(_cepList);
  // }

  // Future<File> _saveData() async {
  //   String data = json.encode(_cepList);
  //   dynamic dataDecoder = json.decode(data);
  //   final box = await _getBox();
  //   _cepList.add(dataDecoder);
  //   box?.put(dataDecoder);
  //   return await _getFile();
  //   // return file.writeAsString(data);
  // }

  // Future<String?> _readData() async {
  //   try {
  //     final file = await _getFile();
  //     return file.readAsString();
  //   } catch (e) {
  //     return null;
  //   }
  // }

  @override
  void initState() {
    super.initState();
    listaTarefasController.encontrarTarefa();
    // _readData().then((data) {
    //   setState(() {
    //     listaTarefasController = json.decode(data!);
    //   });
    // });
  }

  @override
  void dispose() {
    listaTarefasController.controllerTextField.dispose();
    super.dispose();
  }
  // @override
  // void dispose() {
  //   super.dispose();
  //   _logradouro;
  //   _complemento;
  //   _bairro;
  //   _cidade;
  //   _uf;
  //   _ddd;
  //   cepController;
  // }

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
                        controller: listaTarefasController.controllerTextField,
                        inputFormatters: [cepFormatter],
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.maps_home_work),
                          labelText: "Insira um CEP",
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
            child: ListView.builder(
              padding: const EdgeInsets.only(top: 10),
              shrinkWrap: true,
              itemCount: listaTarefasController.todos.length,
              // listaTarefasController.encontrarTarefa().length,
              // profile!.length,
              // _cepList.length,
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
                        // "${listaTarefasController.encontrarTarefa()[index].cepController}",
                        listaTarefasController.todos[index].cepController ?? "CEP não encontrado"
                        // _cepList[index]["title"],
                        ),
                    leading: CircleAvatar(
                      child: Image.asset("assets/imgs/correios.png"),
                    ),
                    subtitle: Text(
                      "${listaTarefasController.encontrarTarefa()[index].logradouro}, ${listaTarefasController.encontrarTarefa()[index].bairro}, ${listaTarefasController.encontrarTarefa()[index].cidade}, ${listaTarefasController.encontrarTarefa()[index].uf}",
                      // "${_cepList[index]["logradouro"]}, ${_cepList[index]["bairro"]}, ${_cepList[index]["cidade"]}, ${_cepList[index]["uf"]}",
                    ),
                  ),
                  onDismissed: (direction) async {
                    setState(() {
                      listaTarefasController.deletarTarefa(listaTarefasController.encontrarTarefa()[index]);
                      // _lastRemoved = _cepList[index];
                      // _cepList.removeAt(index);
                      // remove();
                      // _saveData();
                      // listaTarefasController.salvarTarefa(listaTarefasController.encontrarTarefa()[index]);
                      listaTarefasController.encontrarTarefa();
                    });
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
