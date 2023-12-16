import 'dart:async';
import 'package:application_busca_cep/src/controller/buscar_cep_controller.dart';
import 'package:application_busca_cep/src/model/cep_model.dart';
import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';

Future<T?> showAlertDialog<T>(
  BuildContext context,
  CepModel model,
  BuscarCepController buscarCepController,
  TextEditingController controller,
) async {
  return await showDialog(
    context: context,
    builder: (BuildContext ctx) {
      return CepModal(model: model, buscarCepController: buscarCepController, controller: controller);
    },
  );
}

class CepModal extends StatefulWidget {
  final CepModel model;
  final BuscarCepController buscarCepController;
  final TextEditingController controller;
  const CepModal({
    super.key,
    required this.model,
    required this.buscarCepController,
    required this.controller,
  });

  @override
  State<CepModal> createState() => _CepModalState();
}

class _CepModalState extends State<CepModal> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.controller.text),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text("CEP: ${widget.model.cepController}", textAlign: TextAlign.center),
          Text("Logradouro: ${widget.model.logradouro}", textAlign: TextAlign.center),
          Text("Bairro: ${widget.model.bairro}", textAlign: TextAlign.center),
          Text("Cidade: ${widget.model.cidade}", textAlign: TextAlign.center),
          Text("UF: ${widget.model.uf}", textAlign: TextAlign.center),
          Text("DDD: ${widget.model.ddd}", textAlign: TextAlign.center),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () async {
            await widget.buscarCepController.salvarTarefa(widget.model);
            widget.controller.clear();
            setState(() => Navigator.of(context).pop());
          },
          child: const Text("OK"),
        ),
      ],
    );
  }
}

void showToast({required String message, bool isError = false, required context}) {
  MotionToast(
    icon: isError ? Icons.info : Icons.check_circle,
    primaryColor: isError ? Colors.red : Colors.green,
    description: Text(
      message,
      style: const TextStyle(
        fontSize: 14,
        color: Colors.black,
      ),
    ),
    width: 200,
    height: 100,
    padding: const EdgeInsets.symmetric(vertical: 40),
  ).show(context);
}
