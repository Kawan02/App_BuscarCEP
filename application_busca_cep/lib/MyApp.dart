import 'dart:async';

import 'package:application_busca_cep/buscar_cep.dart';
import 'package:application_busca_cep/widgets/connection_notifier.dart';
import 'package:flutter/material.dart';
import 'package:objectbox/src/native/store.dart';
// import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'auth/login.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // late final StreamSubscription<InternetConnectionStatus> listener;
  // @override
  // void initState() {
  //   super.initState();
  //   listener = InternetConnectionChecker().onStatusChange.listen((status) {
  //     final notifier = ConnectionNotifier.of(context);
  //     notifier!.value = (status == InternetConnectionStatus.connected
  //         ? true
  //         : false) as Future<bool>;
  //   });
  // }

  // @override
  // void dispose() {
  //   listener.cancel();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BuscarCep(),
      // Login(),
    );
  }
}
