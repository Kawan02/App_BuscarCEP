// @dart=2.9
import 'package:application_busca_cep/widgets/connection_notifier.dart';
import 'package:flutter/material.dart';
import 'package:objectbox/objectbox.dart';
import 'package:path_provider/path_provider.dart';
// import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'MyApp.dart';
import 'database/objectbox.g.dart';

void main() async {
  // final hasConnection = InternetConnectionChecker().hasConnection;

  // WidgetsFlutterBinding.ensureInitialized();
  // final appDocumentDir = await getApplicationDocumentsDirectory();
  // final store =
  //     Store(getObjectBoxModel(), directory: '${appDocumentDir.path}/objectbox');

  runApp(
    MyApp(),
    // ConnectionNotifier(
    //   notifier: ValueNotifier(hasConnection),
    //   child: const MyApp(),
    // ),
  );
}
