// @dart=2.9
import 'package:application_busca_cep/database/objectbox_database.dart';
import 'package:flutter/material.dart';
import 'MyApp.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ObjectBoxDatabase.create();

  runApp(const MyApp());
}
