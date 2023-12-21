import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? prefixIcon;
  final String? labelText;
  final String? hintText;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final bool? isDense;
  final InputBorder? border;
  final bool autofocus;
  const CustomTextField({
    super.key,
    required this.controller,
    this.inputFormatters,
    this.prefixIcon,
    this.labelText,
    this.hintText,
    this.validator,
    this.suffixIcon,
    this.isDense,
    this.border,
    this.autofocus = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      inputFormatters: inputFormatters,
      keyboardType: TextInputType.number,
      autofocus: autofocus,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        labelText: labelText,
        hintText: hintText,
        isDense: true,
        border: border,
        suffixIcon: suffixIcon,
      ),
    );
  }
}
