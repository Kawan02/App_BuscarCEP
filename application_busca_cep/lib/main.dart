import 'package:application_busca_cep/src/database/objectbox_database.dart';
import 'package:application_busca_cep/src/pages_routes/app_pages.dart';
import 'package:application_busca_cep/src/services/dependency_injection.dart';
import 'package:application_busca_cep/src/widgets/tema.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';

void main() async {
  DependecyInjection.init();

  WidgetsFlutterBinding.ensureInitialized();

  await ObjectBoxDatabase.create();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    PreferenciaTema.setTema();
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangePlatformBrightness() {
    PreferenciaTema.setTema();
    super.didChangePlatformBrightness();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: PreferenciaTema.tema,
      builder: (BuildContext context, Brightness tema, _) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          locale: const Locale('pt', 'BR'),
          supportedLocales: const [Locale('pt', 'BR')],
          theme: ThemeData(
            primarySwatch: Colors.deepOrange,
            brightness: tema,
          ),
          initialRoute: PagesRoutes.splashRoute,
          getPages: AppPages.pages,
        );
      },
    );
  }
}
