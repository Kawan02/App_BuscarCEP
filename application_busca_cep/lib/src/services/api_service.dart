// ignore_for_file: use_build_context_synchronously
import 'dart:async';
import 'package:application_busca_cep/src/constants/api_constants.dart';
import 'package:application_busca_cep/src/model/cep_model.dart';
import 'package:application_busca_cep/src/respostas/respostas.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ApiService {
  FutureOr<CepModel?> getAdress({required String cep, BuildContext? context}) async {
    try {
      final dio = Dio();
      var url = ApiConstants.urlBase(cep);
      final response = await dio.get(url);

      if (response.statusCode == 200) {
        return CepModel.fromJson(response.data);
      }
    } catch (error) {
      showErrorDialog(error.toString(), context!);
    }
    return null;
  }
}
