import 'package:application_busca_cep/database/objectbox.g.dart';
import 'package:objectbox/objectbox.dart';

class ObjectBoxDataBase {
  Store? _store;

  Future<Store> getStore() async {
    return _store ??= openStore();
  }
}
