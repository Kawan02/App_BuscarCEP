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
      cepController: json['cep'],
      logradouro: json['logradouro'],
      complemento: json['complemento'],
      bairro: json['bairro'],
      cidade: json['localidade'],
      uf: json['uf'],
      ibge: json['ibge'],
      gia: json['gia'],
      ddd: json['ddd'],
      siafi: json['siafi'],
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
