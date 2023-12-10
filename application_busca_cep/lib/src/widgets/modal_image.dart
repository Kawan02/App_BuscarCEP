import 'dart:async';
import 'package:application_busca_cep/src/controller/buscar_cep.dart';
import 'package:application_busca_cep/src/model/cep_model.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'custom_text_field.dart';

final TextEditingController controllerUrl = TextEditingController();
final GlobalKey<FormState> _formKey = GlobalKey();

InkWell modalImage(String? imagem, BuildContext context, BuscarCepController buscarCepController) {
  return InkWell(
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        image: DecorationImage(
          image: image(imagem),
        ),
      ),
    ),
    onTap: () {
      showBarModalBottomSheet(
        context: context,
        builder: (context) {
          Size size = MediaQuery.of(context).size;
          return SizedBox(
            height: size.height * 0.7,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    "Adicionar imagem",
                    style: TextStyle(fontSize: 24),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: CustomTextField(
                      padding: EdgeInsets.zero,
                      labelText: "Coloque a url da imagem aqui...",
                      imageWidget: const Icon(Icons.image),
                      controller: controllerUrl,
                      formKey: _formKey,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 25),
                    child: ElevatedButton(
                      onPressed: () async {
                        // await buscarCepController.salvarTarefa(cepmodel);
                        // ignore: use_build_context_synchronously
                        Navigator.pop(context);
                      },
                      child: const Text("Salvar"),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      );
    },
  );
}

ImageProvider<Object> image(String? imagem) {
  if (imagem == null || imagem.isEmpty) {
    return const AssetImage("assets/imgs/correios.png");
  }
  return NetworkImage(imagem);
}

FutureOr showAlertDialog(BuildContext context, CepModel model, BuscarCepController buscarCepController, TextEditingController controller) async {
  return await showDialog(
    context: context,
    builder: (BuildContext ctx) {
      model.image = controllerUrl.text;
      return AlertDialog(
        title: Text(controller.text),
        content: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CircleAvatar(
              child: modalImage(model.image, ctx, buscarCepController),
              //     Container(
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(15),
              //     image: DecorationImage(
              //       image: image(model.image),
              //     ),
              //   ),
              // ),
            ),
            Text("CEP: ${model.cepController}", textAlign: TextAlign.center),
            Text("Logradouro: ${model.logradouro}", textAlign: TextAlign.center),
            Text("Bairro: ${model.bairro}", textAlign: TextAlign.center),
            Text("Cidade: ${model.cidade}", textAlign: TextAlign.center),
            Text("UF: ${model.uf}", textAlign: TextAlign.center),
            Text("DDD: ${model.ddd}", textAlign: TextAlign.center),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () async {
              await buscarCepController.salvarTarefa(model);
              controller.clear();
              controllerUrl.clear();
              // ignore: use_build_context_synchronously
              Navigator.of(ctx).pop();
            },
            child: const Text("OK"),
          ),
        ],
      );
    },
  );
}
