import 'package:application_busca_cep/database/objectbox.g.dart';
import 'package:application_busca_cep/model/cep_model.dart';
import 'package:objectbox/objectbox.dart';
import 'package:path_provider/path_provider.dart';

// class ObjectBoxDataBase {
//   Store? _store;

//   Future<Store> getStore() async {
//     return _store ??= openStore();
//   }
// }

class ObjectBoxDatabase {
  //É uma representação do objectbox
  late final Store store;

  //Fornece o acesso a um tipo específico. Como nesse caso, o objeto Tarefa.
  static late final Box<Tarefa> tarefaBox;

  ObjectBoxDatabase._create(this.store) {
    // Adicione qualquer código de configuração adicional,
    //por exemplo construir consultas para carregar informações na
    //inicialização de alguma tela.
  }

  /// Cria uma instância de ObjectBox para usar em todo o aplicativo.
  static Future<void> create() async {
    final docsDir = await getApplicationDocumentsDirectory();
    final store = openStore(directory: (docsDir.path));
    // openStore(directory: p.join(docsDir.path, "obx-example"));
    ObjectBoxDatabase._create(store);
    tarefaBox = store.box<Tarefa>();
  }
}
