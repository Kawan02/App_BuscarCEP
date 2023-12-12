import 'dart:async';

import 'package:url_launcher/url_launcher.dart';

FutureOr abrirGoogleMaps(String cep) async {
  String urlMap = "https://www.google.com/maps/place/$cep";
  if (await canLaunchUrl(Uri.parse(urlMap))) {
    await launchUrl(Uri.parse(urlMap));
  } else {
    throw 'Could not launch Maps';
  }
}
