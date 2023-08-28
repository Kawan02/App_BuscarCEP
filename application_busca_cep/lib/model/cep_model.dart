import 'package:application_busca_cep/database/objectbox.g.dart';

@Entity()
class Tarefa {
  @Id()
  int id = 0;
  String logradouro;
  String complemento;
  String bairro;
  String cidade;
  String uf;
  String ddd;
  String cepController;

  Tarefa({
    required this.logradouro,
    required this.complemento,
    required this.bairro,
    required this.cidade,
    required this.uf,
    required this.ddd,
    required this.cepController,
  });
}

// @Entity()
// class DataBase {
//   int id = 0;
//   String? logradouro;
//   String? complemento;
//   String? bairro;
//   String? cidade;
//   String? uf;
//   String? ddd;
//   String? cepController;

//   DataBase({
//     this.logradouro,
//     this.complemento,
//     this.bairro,
//     this.cidade,
//     this.uf,
//     this.ddd,
//     this.cepController,
//   });
// }
