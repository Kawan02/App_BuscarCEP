// ignore_for_file: use_build_context_synchronously
import 'dart:async';
import 'package:application_busca_cep/src/database/objectbox.g.dart';
import 'package:application_busca_cep/src/database/objectbox_database.dart';
import 'package:application_busca_cep/src/model/cep_model.dart';
import 'package:application_busca_cep/src/respostas/respostas.dart';
import 'package:application_busca_cep/src/services/api_service.dart';
import 'package:application_busca_cep/src/widgets/cep_modal.dart';
import 'package:flutter/material.dart';

class BuscarCepController extends ChangeNotifier {
  final ApiService apiService = ApiService();
  final ValueNotifier<CepModel?> adress = ValueNotifier(null);
  final ValueNotifier<bool> isLoading = ValueNotifier(false);

  List<CepModel> _todos = [];

  List<CepModel> get todos => _todos;

  FutureOr<void> searchAdress({
    required String cep,
    required BuildContext context,
    TextEditingController? controller,
    BuscarCepController? buscarCepController,
  }) async {
    isLoading.value = true;

    CepModel? model = await apiService.getAdress(cep: cep, context: context);

    if (model != null) {
      if (model.erro != null) {
        showErrorDialog("CEP não existe ou não localizado.", context);
        return;
      }
      adress.value = model;
      showAlertDialog(context, model, buscarCepController!, controller!);
      isLoading.value = false;
      notifyListeners();
    } else {
      adress.value = null;
      isLoading.value = false;
      notifyListeners();
    }
  }

  // Salva os dados
  FutureOr<void> salvarTarefa(CepModel cepModel) async {
    await ObjectBoxDatabase.tarefaBox.putAsync(cepModel);
    todos.add(cepModel);
    notifyListeners();
  }

  // Exclui os dados
  FutureOr<void> deletarTarefa(CepModel cepModel) async {
    await ObjectBoxDatabase.tarefaBox.removeAsync(cepModel.id);
    notifyListeners();
  }

  // Filtra todos os dados
  List<CepModel> encontrarTarefa() {
    _todos = ObjectBoxDatabase.tarefaBox.query().order(CepModel_.dataTime, flags: Order.descending).build().find();
    notifyListeners();
    return _todos;
  }

  //Filtra só pelo CEP, digitando os numeros do CEP inicial ele já busca
  List<CepModel> listFilter(TextEditingController cepFilter) {
    var filter = ObjectBoxDatabase.tarefaBox.query(CepModel_.cepController.startsWith(cepFilter.text)).build().find();
    notifyListeners();
    return filter;
  }

//Filtra só pelo CEP se estiver igual
  List<CepModel> encontrarTodasTarefa(TextEditingController controllerTextField) {
    var filterCep = ObjectBoxDatabase.tarefaBox.query(CepModel_.cepController.equals(controllerTextField.text)).build().find();
    notifyListeners();
    return filterCep;
  }
}