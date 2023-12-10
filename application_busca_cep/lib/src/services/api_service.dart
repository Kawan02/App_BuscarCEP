import 'dart:async';
import 'dart:convert';
import 'package:application_busca_cep/src/constants/api_constants.dart';
import 'package:application_busca_cep/src/model/cep_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  FutureOr<CepModel?> getAdress({required String cep}) async {
    try {
      var url = Uri.parse(ApiConstants.urlBase(cep));
      http.Response response = await http.get(url);

      if (response.statusCode == 200) {
        Map<String, dynamic> retorno = json.decode(response.body);
        return CepModel.fromJson(retorno);
      }
    } catch (e) {
      print(e.toString());
    }
    return null;
  }
}
