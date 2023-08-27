import 'package:application_busca_cep/widgets/connection_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ConnectionPage extends StatefulWidget {
  const ConnectionPage({super.key});

  @override
  State<ConnectionPage> createState() => _ConnectionPageState();
}

class _ConnectionPageState extends State<ConnectionPage> {
  @override
  Widget build(BuildContext context) {
    var hasConnection = ConnectionNotifier.of(context)!.value;
    // Future<bool> assets = (await hasConnection ? "Conectado" : "Sem conexão com a internet") as Future<bool>;

    return const Scaffold(
      body: Center(
        child: Text(""),
      ),
    );
  }
}
