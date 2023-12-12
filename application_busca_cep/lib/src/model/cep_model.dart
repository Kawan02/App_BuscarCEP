import 'package:intl/intl.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class CepModel {
  @Id()
  @Sync()
  int id = 0;
  String? cepController;
  String? logradouro;
  String? complemento;
  String? bairro;
  String? cidade;
  String? uf;
  String? ibge;
  String? gia;
  String? ddd;
  String? siafi;
  bool? erro;
  String? dataTime;
  String? image;

  CepModel({
    this.cepController,
    this.logradouro,
    this.complemento,
    this.bairro,
    this.cidade,
    this.uf,
    this.ibge,
    this.gia,
    this.ddd,
    this.siafi,
    this.erro,
    this.dataTime,
    this.image,
  });

  factory CepModel.fromJson(Map<String, dynamic> json) {
    return CepModel(
      cepController: json['cep'] ?? "Cep vazio ou não encontrado",
      logradouro: json['logradouro'] ?? "Logradouro vazio ou não encontrado",
      complemento: json['complemento'] ?? "Complemento vazio ou não encontrado",
      bairro: json['bairro'] ?? "Bairro vazio ou não encontrado",
      cidade: json['localidade'] ?? "Localidade vazia ou não encontrado",
      uf: json['uf'] ?? "Uf vazio ou não encontrado",
      ibge: json['ibge'] ?? "Ibge vazio ou não encontrado",
      gia: json['gia'] ?? "Gia vazio ou não encontrado",
      ddd: json['ddd'] ?? "Ddd vazio ou não encontrado",
      siafi: json['siafi'] ?? "Siafi vazio ou não encontrado",
      erro: json["erro"],
      dataTime: DateFormat('dd-MM-yyyy – kk:mm:a').format(DateTime.now()),
      image: json["image"],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cep'] = cepController;
    data['logradouro'] = logradouro;
    data['complemento'] = complemento;
    data['bairro'] = bairro;
    data['localidade'] = cidade;
    data['uf'] = uf;
    data['ibge'] = ibge;
    data['gia'] = gia;
    data['ddd'] = ddd;
    data['siafi'] = siafi;
    data['erro'] = erro;
    data['data'] = dataTime;
    data['image'] = image;
    return data;
  }
}
