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
  final GlobalKey<FormState> _formKeyFilter = GlobalKey();
  bool listFilter = false;
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
    var erro = retorno["erro"];

    if (response.statusCode == 200) {
      if (erro != null) {
        await _showErrorDialog("CEP não existe ou não localizado.");
        cepController.controllerTextField.clear();
        return;
      }
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
        _logradouro = cepBaseModel.logradouro!;
        _complemento = cepBaseModel.complemento!;
        _bairro = cepBaseModel.bairro!;
        _cidade = cepBaseModel.cidade!;
        _uf = cepBaseModel.uf!;
        _ddd = cepBaseModel.ddd!;
        showAlertDialog(context);
      });
    } else {
      await _showErrorDialog("Ocorreu um erro. Tente novamente mais tarde!");
    }
  }

  Widget _list(ListaCepController encontrarTarefa) {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 10),
      shrinkWrap: true,
      itemCount: encontrarTarefa.encontrarTarefa().length,
      itemBuilder: (context, index) {
        final cep = encontrarTarefa.encontrarTarefa()[index];

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
              cep.cepController.isEmpty ? "CEP vazio ou não encontrado" : cep.cepController,
            ),
            leading: CircleAvatar(
              child: Image.asset("assets/imgs/correios.png"),
            ),
            subtitle: Text(
              "${cep.logradouro!.isEmpty ? "Logradouro vazio ou não encontrado" : cep.logradouro}, ${cep.bairro!.isEmpty ? "Bairro vazio ou não encontrado" : cep.bairro}, ${cep.cidade!.isEmpty ? "Cidade vazia ou não encontrada" : cep.cidade}, ${cep.uf!.isEmpty ? "uf vazio ou não encontrado" : cep.uf}",
            ),
          ),
          onDismissed: (direction) async {
            var delete = await cepController.deletarTarefa(cep);
            setState(() {
              delete;
            });
          },
        );
      },
    );
  }

  Widget _listFilter(ListaCepController listFilter) {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 10),
      shrinkWrap: true,
      itemCount: listFilter.listFilter().length,
      itemBuilder: (context, index) {
        final cepFilter = listFilter.listFilter()[index];
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
              cepFilter.cepController.isEmpty ? "CEP vazio ou não encontrado" : cepFilter.cepController,
            ),
            leading: CircleAvatar(
              child: Image.asset("assets/imgs/correios.png"),
            ),
            subtitle: Text(
              "${cepFilter.logradouro!.isEmpty ? "Logradouro vazio ou não encontrado" : cepFilter.logradouro}, ${cepFilter.bairro!.isEmpty ? "Bairro vazio ou não encontrado" : cepFilter.bairro}, ${cepFilter.cidade!.isEmpty ? "Cidade vazia ou não encontrada" : cepFilter.cidade}, ${cepFilter.uf!.isEmpty ? "uf vazio ou não encontrado" : cepFilter.uf}",
            ),
          ),
          onDismissed: (direction) async {
            var delete = await cepController.deletarTarefa(cepFilter);
            setState(() {
              delete;
            });
          },
        );
      },
    );
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

  Future<void> _showErrorDialog(String? message) async {
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

  Future<void> _filterCep(TextEditingController filter) async {
    return await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Filtro"),
            GestureDetector(
              child: const MouseRegion(
                cursor: SystemMouseCursors.click,
                child: Icon(Icons.close, size: 20),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
        content: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Form(
            key: _formKeyFilter,
            child: TextFormField(
              validator: (text) {
                if (text == null || text.isEmpty) {
                  return "Informe o CEP";
                }
                return null;
              },
              controller: cepController.cepFilter,
              inputFormatters: [cepFormatter],
              keyboardType: TextInputType.number,
              autofocus: true,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.maps_home_work),
                labelText: "Insira um CEP",
                hintText: "Digite um CEP aqui...",
                isDense: true,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(18)),
              ),
            ),
          ),
        ),
        actions: <Widget>[
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            padding: const EdgeInsets.only(bottom: 15.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
              onPressed: () async {
                if (!_formKeyFilter.currentState!.validate()) return;

                setState(() {
                  listFilter = true;
                  cepController.listFilter();
                  Navigator.of(ctx).pop();
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.check),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      'Pesquisar CEP',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _refresh() {
    if (listFilter == false) return cepController.encontrarTarefa();

    return cepController.listFilter();
  }

  @override
  void initState() {
    _refresh();
    super.initState();
  }

  @override
  void dispose() {
    _refresh();
    cepController.controllerTextField.dispose();
    cepController.cepFilter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Buscar CEP"),
        centerTitle: true,
        backgroundColor: Colors.deepOrange[400],
        actions: [
          IconButton(
            icon: Icon(listFilter == false ? Icons.filter_alt : Icons.filter_alt_off),
            onPressed: () async {
              if (listFilter != false) {
                setState(() {
                  listFilter = false;
                });
                return;
              }
              cepController.cepFilter.clear();
              await _filterCep(cepController.cepFilter);
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async => await _refresh(),
        semanticsLabel: "Carregando...",
        color: Colors.deepOrange[400],
        child: Column(
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
              child: cepController.encontrarTarefa().isEmpty && listFilter == false
                  ? const Center(
                      child: Text("A lista de CEP está vazia (:"),
                    )
                  : cepController.listFilter().isEmpty && listFilter == true
                      ? const Center(
                          child: Text("CEP não econtrado, verifique se digitou corretamente (:"),
                        )
                      : listFilter == false
                          ? _list(cepController)
                          : _listFilter(cepController),
            ),
          ],
        ),
      ),
    );
  }
}
