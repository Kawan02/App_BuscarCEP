import 'package:application_busca_cep/src/pages_routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _redirect();
  }

  Future _redirect() async {
    await Future.delayed(
      const Duration(seconds: 5),
      () {
        Get.offNamed(PagesRoutes.baseRoute);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.deepOrange, Colors.deepOrangeAccent, Colors.orange],
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.asset(
                "assets/imgs/correios.png",
                height: 80,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Buscar CEP",
              style: TextStyle(
                fontSize: 40,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 15),
            const CircularProgressIndicator.adaptive(
              valueColor: AlwaysStoppedAnimation(
                Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
