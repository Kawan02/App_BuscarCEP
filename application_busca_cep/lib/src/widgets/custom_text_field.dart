import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatefulWidget {
  final List<TextInputFormatter>? inputFormatters;
  final TextEditingController? controller;
  final GlobalKey? formKey;
  final String? labelText;
  final String? hintText;
  final Widget? imageWidget;
  final EdgeInsetsGeometry padding;
  const CustomTextField({
    super.key,
    this.inputFormatters,
    this.controller,
    this.formKey,
    this.labelText,
    this.hintText,
    required this.padding,
    this.imageWidget,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding,
      child: Form(
        key: widget.formKey,
        child: TextFormField(
          validator: (String? text) {
            if (text == null || text.isEmpty) {
              return "Informe o CEP";
            }
            return null;
          },
          controller: widget.controller,
          inputFormatters: widget.inputFormatters,
          keyboardType: TextInputType.number,
          autofocus: true,
          decoration: InputDecoration(
            prefixIcon: widget.imageWidget,
            // const Icon(Icons.maps_home_work),
            labelText: widget.labelText,
            hintText: widget.hintText,
            isDense: true,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(18)),
          ),
        ),
      ),
    );
  }
}
