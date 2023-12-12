import 'dart:async';
import 'package:application_busca_cep/src/controller/buscar_cep.dart';
import 'package:application_busca_cep/src/model/cep_model.dart';
import 'package:flutter/material.dart';

FutureOr showAlertDialog(
  BuildContext context,
  CepModel model,
  BuscarCepController buscarCepController,
  TextEditingController controller,
) async {
  return await showDialog(
    context: context,
    builder: (BuildContext ctx) {
      return AlertDialog(
        title: Text(controller.text),
        content: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text("CEP: ${model.cepController}", textAlign: TextAlign.center),
            Text("Logradouro: ${model.logradouro}", textAlign: TextAlign.center),
            Text("Bairro: ${model.bairro}", textAlign: TextAlign.center),
            Text("Cidade: ${model.cidade}", textAlign: TextAlign.center),
            Text("UF: ${model.uf}", textAlign: TextAlign.center),
            Text("DDD: ${model.ddd}", textAlign: TextAlign.center),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () async {
              await buscarCepController.salvarTarefa(model);
              controller.clear();

              // Navigator.of(ctx).pop();
            },
            child: const Text("OK"),
          ),
        ],
      );
    },
  );
}
