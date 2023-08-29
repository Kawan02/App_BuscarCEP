import 'package:objectbox/objectbox.dart';

@Entity()
class CepModel {
  @Id()
  int id = 0;
  String logradouro;
  String complemento;
  String bairro;
  String cidade;
  String uf;
  String ddd;
  String cepController;

  CepModel({
    required this.logradouro,
    required this.complemento,
    required this.bairro,
    required this.cidade,
    required this.uf,
    required this.ddd,
    required this.cepController,
  });
}
