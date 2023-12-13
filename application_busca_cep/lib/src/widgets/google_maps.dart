// ignore_for_file: use_build_context_synchronously
import 'dart:async';
import 'package:application_busca_cep/src/respostas/respostas.dart';
import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

FutureOr abrirGoogleMaps(String cep, BuildContext context) async {
  String urlMap = "https://www.google.com/maps/place/$cep";
  if (await canLaunchUrl(Uri.parse(urlMap))) {
    await launchUrl(Uri.parse(urlMap));
  } else {
    throw await showErrorDialog("Não foi possível iniciar o Google Maps", context);
  }
}
