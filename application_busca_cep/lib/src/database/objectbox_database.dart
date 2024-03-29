import 'package:path_provider/path_provider.dart';
import 'package:application_busca_cep/src/database/objectbox.g.dart';
import 'package:application_busca_cep/src/model/cep_model.dart';

class ObjectBoxDatabase {
  //É uma representação do objectbox
  late final Store store;

  //Fornece o acesso a um tipo específico. Como nesse caso, o objeto Tarefa.
  static late final Box<CepModel> tarefaBox;
  static late final Query<CepModel> query;

  ObjectBoxDatabase._create(this.store) {
    // Adicione qualquer código de configuração adicional,
    // por exemplo construir consultas para carregar informações na inicialização de alguma tela.
  }

  /// Cria uma instância de ObjectBox para usar em todo o aplicativo.
  static Future<void> create() async {
    final docsDir = await getApplicationDocumentsDirectory();
    final store = await openStore(directory: (docsDir.path));
    ObjectBoxDatabase._create(store);
    tarefaBox = store.box<CepModel>();
    // tarefaBox.removeAll();
  }
}
