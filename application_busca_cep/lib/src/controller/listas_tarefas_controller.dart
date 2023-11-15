import 'package:application_busca_cep/src/database/objectbox.g.dart';
import 'package:application_busca_cep/src/database/objectbox_database.dart';
import 'package:application_busca_cep/src/model/cep_model.dart';
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

  //Filtra só pelo CEP, digitando os numeros do CEP inicial ele já busca
  List<CepModel> listFilter() {
    var filteredPersons = ObjectBoxDatabase.tarefaBox.query(CepModel_.cepController.startsWith(cepFilter.text)).build().find();
    return filteredPersons;
  }

//Filtra só pelo CEP se estiver igual
  List<CepModel> encontrarTodasTarefa() {
    final query = ObjectBoxDatabase.tarefaBox.query(CepModel_.cepController.equals(controllerTextField.text)).build().find();
    return query;
  }
}
