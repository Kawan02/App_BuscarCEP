import 'package:application_busca_cep/Photo_Screen/image_selected.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

String img = "assets/imgs/img.jpg";

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Screen"),
      ),
      body: Center(
        child: InkWell(
          onTap: () {
            Navigator.push(
                context,
                PageTransition(
                    child: ImagemSelected(img_selected: img), 
                    type: PageTransitionType.fade
                  ));
          },
          child: SizedBox(height: 200, child: Image.asset(img, fit: BoxFit.cover)),
        ),
      ),
    );
  }
}
