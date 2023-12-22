import 'dart:async';
import 'package:application_busca_cep/src/model/cep_model.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';

Future<AwesomeDialog> showErrorDialog(String? message, BuildContext context) async {
  return AwesomeDialog(
    context: context,
    animType: AnimType.scale,
    dialogType: DialogType.error,
    body: Center(
      child: Text(
        message!,
        style: const TextStyle(fontStyle: FontStyle.italic),
      ),
    ),
    btnOkOnPress: () {},
  )..show();
}

Future<AwesomeDialog> showSucessDialog(String? message, BuildContext context) async {
  return AwesomeDialog(
    context: context,
    animType: AnimType.scale,
    dialogType: DialogType.success,
    body: Center(
      child: Text(
        message!,
        style: const TextStyle(fontStyle: FontStyle.italic),
      ),
    ),
    btnOkOnPress: () {
      Navigator.of(context).pop();
    },
  )..show();
}

FutureOr<AwesomeDialog> showWarningDialog(BuildContext context, CepModel cepModel) async {
  return AwesomeDialog(
    context: context,
    dialogType: DialogType.info,
    animType: AnimType.rightSlide,
    title: 'Atenção',
    desc: 'Você tem certeza que quer excluir?',
    btnCancelOnPress: () {},
    btnOkOnPress: () {},
  )..show();
}

Future<void> showToast({required String message, bool isError = false, required context}) async {
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
