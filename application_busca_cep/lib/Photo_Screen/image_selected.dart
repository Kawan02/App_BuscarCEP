import 'package:flutter/material.dart';

class ImagemSelected extends StatelessWidget {
  String imgselected;
  ImagemSelected({Key? key, required this.imgselected}) : super(key: key);

  // String get img_selected => img_selected;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Scaffold(
        backgroundColor: Colors.black54,
        body: Center(
          child: SizedBox(
            height: 400,
            child: Image.asset(imgselected),
          ),
        ),
      ),
    );
  }
}
