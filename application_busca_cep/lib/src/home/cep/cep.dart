import 'package:application_busca_cep/src/controller/buscar_cep.dart';
import 'package:application_busca_cep/src/widgets/google_maps.dart';
import 'package:flutter/material.dart';

class Cep extends StatefulWidget {
  final BuscarCepController? buscarCepController;
  final bool filter;
  final TextEditingController? controllerFilter;
  const Cep({
    super.key,
    this.buscarCepController,
    this.filter = false,
    this.controllerFilter,
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
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.only(top: 10),
            shrinkWrap: true,
            itemCount: widget.filter
                ? widget.buscarCepController!.encontrarTarefa().length
                : widget.buscarCepController!.encontrarTodasTarefa(widget.controllerFilter!).length,
            itemBuilder: (context, index) {
              final cep = widget.filter
                  ? widget.buscarCepController!.encontrarTarefa()[index]
                  : widget.buscarCepController!.listFilter(widget.controllerFilter!)[index];

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
                    "${cep.logradouro}, ${cep.bairro}, ${cep.cidade}, ${cep.uf}. ${cep.ddd}",
                  ),
                  trailing: IconButton(
                    onPressed: () async {
                      await abrirGoogleMaps(cep.cepController!, context);
                    },
                    icon: const Icon(
                      Icons.location_on,
                      color: Colors.greenAccent,
                      size: 30,
                    ),
                  ),
                  dense: true,
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
