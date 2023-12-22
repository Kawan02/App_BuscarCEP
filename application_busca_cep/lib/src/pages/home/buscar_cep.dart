import 'dart:async';
import 'dart:core';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:application_busca_cep/src/controller/buscar_cep_controller.dart';
import 'package:application_busca_cep/src/pages/cep/cep.dart';
import 'package:application_busca_cep/src/pages/cep/components/custom_text_fiel.dart';
import 'package:application_busca_cep/src/pages/cep/filter/cep_filter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class BuscarCep extends StatefulWidget {
  const BuscarCep({Key? key}) : super(key: key);

  @override
  State<BuscarCep> createState() => _BuscarCepState();
}

class _BuscarCepState extends State<BuscarCep> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final GlobalKey<FormState> _formKeyFilter = GlobalKey();
  final TextEditingController controller = TextEditingController();
  final TextEditingController controllerFilter = TextEditingController();
  bool listFilter = false;
  final cepFormatter = MaskTextInputFormatter(mask: "#####-###", filter: {"#": RegExp(r"[0-9]")});
  final BuscarCepController buscarCepController = BuscarCepController();

  FutureOr<void> consultar(BuscarCepController cep) async {
    FocusScope.of(context).unfocus();

    if (_formKey.currentState!.validate()) {
      await buscarCepController.searchAdress(
        cep: controller.text,
        context: context,
        buscarCepController: cep,
        controller: controller,
      );
    }
  }

  FutureOr<void> _filterCep(TextEditingController filter) async {
    return await showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Filtro"),
              GestureDetector(
                child: const MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: Icon(Icons.close, size: 20),
                ),
                onTap: () => Navigator.of(ctx).pop(),
              ),
            ],
          ),
          content: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Form(
              key: _formKeyFilter,
              child: CustomTextField(
                controller: controllerFilter,
                validator: (cepFilter) {
                  if (cepFilter == null || cepFilter.isEmpty) return "Informe o CEP";

                  return null;
                },
                inputFormatters: [cepFormatter],
                prefixIcon: const Icon(Icons.maps_home_work),
                labelText: "Insira um CEP",
                hintText: "Digite um CEP aqui...",
                isDense: true,
                autofocus: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
            ),
          ),
          actions: <Widget>[
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              padding: const EdgeInsets.only(bottom: 15.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
                onPressed: () {
                  FocusScope.of(ctx).unfocus();

                  if (_formKeyFilter.currentState!.validate()) {
                    setState(() {
                      listFilter = true;
                      buscarCepController.listFilter(controllerFilter.text);
                      Navigator.of(ctx).pop();
                    });
                  }
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.check),
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: Text(
                        'Pesquisar CEP',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  _refresh() {
    if (listFilter == false) {
      buscarCepController.encontrarTarefa();
    }

    buscarCepController.listFilter(controllerFilter.text);
  }

  @override
  void initState() {
    super.initState();
    _refresh();
  }

  @override
  void dispose() {
    super.dispose();
    _refresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AnimatedTextKit(
          pause: Duration.zero,
          repeatForever: true,
          animatedTexts: [
            FadeAnimatedText("Buscar CEP"),
          ],
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(listFilter == false ? Icons.filter_alt : Icons.filter_alt_off),
            onPressed: () async {
              if (listFilter != false) {
                setState(() {
                  listFilter = false;
                  controllerFilter.clear();
                });
                return;
              }
              await _filterCep(controllerFilter);
            },
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: Form(
                      key: _formKey,
                      child: CustomTextField(
                        controller: controller,
                        inputFormatters: [cepFormatter],
                        validator: (cep) {
                          if (cep == null || cep.isEmpty) return "Esse campo é obrigatorio";

                          return null;
                        },
                        prefixIcon: const Icon(Icons.maps_home_work),
                        labelText: "Insira um CEP",
                        hintText: "Digite um CEP aqui...",
                        suffixIcon: GetX<BuscarCepController>(
                          builder: (buscarCepController) {
                            return IconButton(
                              onPressed: buscarCepController.isLoading.value
                                  ? null
                                  : () async {
                                      await consultar(buscarCepController);
                                    },
                              icon: Icon(
                                Icons.search,
                                color: buscarCepController.isLoading.value ? Colors.grey : Colors.deepOrange,
                                size: 25,
                                semanticLabel: "Pesquisar",
                              ),
                            );
                          },
                        ),
                        isDense: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: GetX<BuscarCepController>(
              builder: (controller) {
                return controller.isLoading.value
                    ? const Center(
                        child: CircularProgressIndicator.adaptive(),
                      )
                    : controller.encontrarTarefa().isEmpty && listFilter == false
                        ? const Center(
                            child: Text("A lista de CEP está vazia (:"),
                          )
                        : controller.listFilter(controllerFilter.text).isEmpty && listFilter == true
                            ? const Center(
                                child: Text("CEP não econtrado, verifique se digitou corretamente (:"),
                              )
                            : listFilter == false
                                ? const Cep()
                                : CepFilter(
                                    controllerFilter: controllerFilter.text,
                                  );
              },
            ),
          ),
        ],
      ),
    );
  }
}
