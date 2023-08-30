import 'package:application_busca_cep/database/objectbox.g.dart';
import 'package:application_busca_cep/database/objectbox_database.dart';
import 'package:application_busca_cep/model/cep_model.dart';
import 'package:flutter/material.dart';

class ListaCepController {
  TextEditingController controllerTextField = TextEditingController();
  TextEditingController cepFilter = TextEditingController();
  List<CepModel> _todos = [];

  List<CepModel> get todos => _todos;

  // Salva os dados
  Future<void> salvarTarefa(CepModel cepModel) async {
    ObjectBoxDatabase.tarefaBox.put(cepModel);
    todos.add(cepModel);
    controllerTextField.clear();
  }

  // Exclui os dados
  Future<void> deletarTarefa(CepModel cepModel) async {
    ObjectBoxDatabase.tarefaBox.remove(cepModel.id);
  }

  // Filtra todos os dados
  List<CepModel> encontrarTarefa() {
    _todos = ObjectBoxDatabase.tarefaBox.getAll();
    return todos.toList();
  }

  //Filtrar só pelo CEP
  List<CepModel> listFilter() {
    final filteredPersons = ObjectBoxDatabase.tarefaBox.query(CepModel_.cepController.equals(cepFilter.text)).build().find();
    return filteredPersons;
  }

  List<CepModel> encontrarTodasTarefa() {
    final query = ObjectBoxDatabase.tarefaBox.query(CepModel_.cepController.equals(controllerTextField.text)).build();
    _todos = query.find();
    query.close();
    return todos.toList();
  }
}
