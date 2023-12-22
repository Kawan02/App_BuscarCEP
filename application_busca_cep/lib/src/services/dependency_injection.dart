import 'package:application_busca_cep/src/controller/buscar_cep_controller.dart';
import 'package:application_busca_cep/src/controller/network_controller.dart';
import 'package:get/get.dart';

class DependecyInjection {
  static void init() {
    Get.put<NetworkController>(NetworkController(), permanent: true);
    Get.put(BuscarCepController());
  }
}
