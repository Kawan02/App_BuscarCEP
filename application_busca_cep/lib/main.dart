import 'package:application_busca_cep/src/database/objectbox_database.dart';
import 'package:application_busca_cep/src/services/dependency_injection.dart';
import 'package:flutter/material.dart';
import 'my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await ObjectBoxDatabase.create();
  DependecyInjection.init();

  runApp(const MyApp());
}
