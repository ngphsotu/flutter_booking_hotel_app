import 'package:flutter/material.dart';

class ReuseduceTextFormField extends StatefulWidget {
  final int? maxLine;
  final bool? enable;
  final bool obscureText;
  final String? hintText;
  final String? labelText;
  final String? errorText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Function? funcValidation;
  final Function(String)? onChanged;
  final TextInputType? keyboardType;
  final InputDecoration? decoration;
  final TextEditingController? controller;

  const ReuseduceTextFormField({
    super.key,
    this.maxLine = 1,
    this.decoration = const InputDecoration(),
    this.enable = true,
    this.obscureText = false,
    this.hintText,
    this.labelText,
    this.errorText,
    this.prefixIcon,
    this.suffixIcon,
    this.onChanged,
    this.controller,
    this.keyboardType,
    this.funcValidation,
  });

  @override
  State<ReuseduceTextFormField> createState() => _ReuseduceTextFormFieldState();
}

class _ReuseduceTextFormFieldState extends State<ReuseduceTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: widget.maxLine,
      onChanged: widget.onChanged,
      controller: widget.controller,
      obscureText: widget.obscureText,
      keyboardType: widget.keyboardType,
      decoration: InputDecoration(
        hintText: widget.hintText,
        labelText: widget.labelText,
        errorText: widget.errorText,
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.suffixIcon,
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.grey),
        ),
      ),
    );
  }
}
