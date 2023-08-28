import 'package:application_busca_cep/database/objectbox_database.dart';
import 'package:application_busca_cep/model/cep_model.dart';
import 'package:flutter/material.dart';

class ListaTarefasController {
  TextEditingController controllerTextField = TextEditingController();
  List<Tarefa> _todos = [];

  List<Tarefa> get todos => _todos;

  salvarTarefa(Tarefa tarefa) {
    //o método put serve tanto para salvar quanto para editar uma tarefa.
    final todo = Tarefa(
      bairro: tarefa.bairro,
      cepController: tarefa.cepController,
      // cepList: tarefa.cepList,
      cidade: tarefa.cidade,
      complemento: tarefa.complemento,
      ddd: tarefa.ddd,
      logradouro: tarefa.logradouro,
      uf: tarefa.uf,
    );
    // _todos =
    ObjectBoxDatabase.tarefaBox.put(todo);
    todos.add(todo);
    controllerTextField.clear();
    // cepList.add(tarefa);
  }

  void deletarTarefa(Tarefa tarefa) {
    ObjectBoxDatabase.tarefaBox.remove(tarefa.id);
  }

  List<Tarefa> encontrarTarefa() {
    // print("${ObjectBoxDatabase.tarefaBox.getAll()}");
    _todos = ObjectBoxDatabase.tarefaBox.getAll();
    return todos.toList();
    // return ObjectBoxDatabase.tarefaBox.getAll();
  }
}
