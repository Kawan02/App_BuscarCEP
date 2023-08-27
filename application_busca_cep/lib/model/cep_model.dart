import 'dart:convert';
import 'package:application_busca_cep/database/objectbox.g.dart';

@Entity()
class DataBase {
  int id = 0;
  String? logradouro;
  String? complemento;
  String? bairro;
  String? cidade;
  String? uf;
  String? ddd;
  String? cepController;

  DataBase({
    this.logradouro,
    this.complemento,
    this.bairro,
    this.cidade,
    this.uf,
    this.ddd,
    this.cepController,
  });
}

// DataBase cepModelFromJson(String str) => DataBase.fromJson(json.decode(str));

// String cepModelToJson(DataBase data) => json.encode(data.toJson());

// @Entity()
// class DataBase {
//   DataBase({
//     this.logradouro,
//     this.complemento,
//     this.bairro,
//     this.cidade,
//     this.uf,
//     this.ddd,
//     this.cep,
//   });

//   int id = 0;
//   final String? logradouro;
//   final String? complemento;
//   final String? bairro;
//   final String? cidade;
//   final String? uf;
//   final String? ddd;
//   final String? cep;

//   factory DataBase.fromJson(Map<String, dynamic> json) => DataBase(
//         logradouro: json["logradouro"] ?? [],
//         complemento: json["complemento"] ?? [],
//         bairro: json["bairro"] ?? [],
//         cidade: json["localidade"] ?? [],
//         uf: json["uf"] ?? [],
//         ddd: json["ddd"] ?? [],
//         cep: json["title"] ?? [],
//       );

//   Map<String, dynamic> toJson() => {
//         "logradouro": logradouro ?? [],
//         "complemento": complemento ?? [],
//         "bairro": bairro ?? [],
//         "localidade": cidade ?? [],
//         "uf": uf ?? [],
//         "ddd": ddd ?? [],
//         "cep": cep ?? [],
//       };

//   static List<DataBase> fromJsonList(List list) {
//     return list.map((item) => DataBase.fromJson(item)).toList();
//   }
// }
