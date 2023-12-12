import 'package:application_busca_cep/src/controller/buscar_cep.dart';
import 'package:application_busca_cep/src/widgets/cep_modal.dart';
import 'package:application_busca_cep/src/widgets/google_maps.dart';
import 'package:flutter/material.dart';

class Cep extends StatefulWidget {
  final BuscarCepController? buscarCepController;
  const Cep({
    super.key,
    this.buscarCepController,
  });

  @override
  State<Cep> createState() => _CepState();
}

class _CepState extends State<Cep> {
  @override
  Widget build(BuildContext context) {
    return widget.buscarCepController!.isLoading.value
        ? const Center(child: CircularProgressIndicator())
        : ListView.builder(
            padding: const EdgeInsets.only(top: 10),
            shrinkWrap: true,
            itemCount: widget.buscarCepController?.encontrarTarefa().length,
            itemBuilder: (context, index) {
              final cep = widget.buscarCepController!.encontrarTarefa()[index];

              return Dismissible(
                background: Container(
                  color: Colors.red,
                  child: const Align(
                    alignment: Alignment(-0.9, 0),
                    child: Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  ),
                ),
                direction: DismissDirection.startToEnd,
                key: Key(DateTime.now().millisecondsSinceEpoch.toString()),
                child: ListTile(
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "CEP: ${cep.cepController!.isEmpty ? "CEP vazio ou não encontrado" : cep.cepController!}",
                      ),
                      Text("Criado em: ${cep.dataTime}")
                    ],
                  ),
                  leading: CircleAvatar(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        image: const DecorationImage(
                          image: AssetImage("assets/imgs/correios.png"),
                        ),
                      ),
                    ),
                  ),
                  subtitle: Text(
                    "${cep.logradouro!.isEmpty ? "Logradouro vazio ou não encontrado" : cep.logradouro}, ${cep.bairro!.isEmpty ? "Bairro vazio ou não encontrado" : cep.bairro}, ${cep.cidade!.isEmpty ? "Cidade vazia ou não encontrada" : cep.cidade}, ${cep.uf!.isEmpty ? "uf vazio ou não encontrado" : cep.uf}",
                  ),
                  trailing: Text("Criado em: ${cep.dataTime}"),
                  onLongPress: () async {
                    await abrirGoogleMaps(cep.cepController!);
                  },
                ),
                onDismissed: (direction) async {
                  await widget.buscarCepController!.deletarTarefa(cep);
                  setState(() {});
                },
              );
            },
          );
  }
}
