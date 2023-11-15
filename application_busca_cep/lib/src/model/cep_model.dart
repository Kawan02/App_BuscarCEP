import 'package:objectbox/objectbox.dart';

@Entity()
class CepModel {
  @Id()
  int id = 0;
  String? logradouro;
  String? complemento;
  String? bairro;
  String? cidade;
  String? uf;
  String? ddd;
  String cepController;

  CepModel({
    this.logradouro,
    this.complemento,
    this.bairro,
    this.cidade,
    this.uf,
    this.ddd,
    required this.cepController,
  });
}
