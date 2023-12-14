import 'package:application_busca_cep/src/controller/buscar_cep.dart';
import 'package:application_busca_cep/src/widgets/google_maps.dart';
import 'package:flutter/material.dart';

class CepFilter extends StatefulWidget {
  final BuscarCepController? buscarCepController;
  final TextEditingController controllerFilter;
  const CepFilter({super.key, this.buscarCepController, required this.controllerFilter});

  @override
  State<CepFilter> createState() => _CepFilterState();
}

class _CepFilterState extends State<CepFilter> {
  @override
  Widget build(BuildContext context) {
    return widget.buscarCepController!.isLoading.value
        ? const Center(child: CircularProgressIndicator())
        : ListView.builder(
            padding: const EdgeInsets.only(top: 10),
            shrinkWrap: true,
            itemCount: widget.buscarCepController!.listFilter(widget.controllerFilter).length,
            itemBuilder: (context, index) {
              final cepFilter = widget.buscarCepController!.listFilter(widget.controllerFilter)[index];
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
                        "CEP: ${cepFilter.cepController!.isEmpty ? "CEP vazio ou não encontrado" : cepFilter.cepController!}",
                      ),
                      Text("Criado em: ${cepFilter.dataTime}")
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
                    "${cepFilter.logradouro}, ${cepFilter.bairro}, ${cepFilter.cidade}, ${cepFilter.uf}. ${cepFilter.ddd}",
                  ),
                  trailing: IconButton(
                    onPressed: () async => await abrirGoogleMaps(cepFilter.cepController!, context),
                    icon: const Icon(
                      Icons.location_on,
                      color: Colors.greenAccent,
                      size: 30,
                    ),
                  ),
                  dense: true,
                ),
                onDismissed: (direction) async => await widget.buscarCepController!.deletarTarefa(cepFilter),
              );
            },
          );
  }
}
