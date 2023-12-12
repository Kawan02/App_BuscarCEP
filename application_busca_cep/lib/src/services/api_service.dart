import 'dart:async';
import 'package:application_busca_cep/src/constants/api_constants.dart';
import 'package:application_busca_cep/src/model/cep_model.dart';
import 'package:dio/dio.dart';

class ApiService {
  FutureOr<CepModel?> getAdress({required String cep}) async {
    try {
      final dio = Dio();
      // var url = Uri.parse(ApiConstants.urlBase(cep));
      var url = ApiConstants.urlBase(cep);
      final response = await dio.get(url);

      if (response.statusCode == 200) {
        // Map<String, dynamic> retorno = json.decode(response.data);
        return CepModel.fromJson(response.data);
      }
    } catch (e) {
      print(e.toString());
    }
    return null;
  }
}
