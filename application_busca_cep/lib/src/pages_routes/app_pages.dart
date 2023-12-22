import 'package:application_busca_cep/src/pages/home/buscar_cep.dart';
import 'package:application_busca_cep/src/pages/splash/splash_screen.dart';
import 'package:get/get.dart';

abstract class AppPages {
  static final pages = <GetPage>[
    GetPage(
      name: PagesRoutes.splashRoute,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: PagesRoutes.baseRoute,
      page: () => const BuscarCep(),
    ),
  ];
}

abstract class PagesRoutes {
  static const String splashRoute = "/splash";
  static const String baseRoute = "/";
}
