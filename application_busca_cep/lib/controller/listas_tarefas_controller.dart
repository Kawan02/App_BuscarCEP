import 'package:application_busca_cep/database/objectbox.g.dart';
import 'package:application_busca_cep/database/objectbox_database.dart';
import 'package:application_busca_cep/model/cep_model.dart';
import 'package:flutter/material.dart';

class ListaCepController {
  TextEditingController controllerTextField = TextEditingController();
  List<CepModel> _todos = [];

  List<CepModel> get todos => _todos;

  Future<void> salvarTarefa(CepModel cepModel) async {
    ObjectBoxDatabase.tarefaBox.put(cepModel);
    todos.add(cepModel);
    controllerTextField.clear();
  }

  Future<void> deletarTarefa(CepModel cepModel) async {
    ObjectBoxDatabase.tarefaBox.remove(cepModel.id);
  }

  List<CepModel> encontrarTarefa() {
    _todos = ObjectBoxDatabase.tarefaBox.getAll();
    return todos.toList();
  }

  List<CepModel> encontrarTodasTarefa() {
    final query = ObjectBoxDatabase.tarefaBox.query(CepModel_.cepController.equals(controllerTextField.text)).build();
    _todos = query.find();
    query.close();
    return todos.toList();
  }
}
