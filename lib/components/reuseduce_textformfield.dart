import 'package:flutter/material.dart';

class ReuseduceTextFormField extends StatelessWidget {
  final String labelText;
  final Widget? prefixIcon;
  final TextInputType? keyboardType;

  final Function(String)? onChanged;

  const ReuseduceTextFormField({
    super.key,
    this.prefixIcon,
    this.keyboardType,
    this.onChanged,
    required this.labelText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: prefixIcon,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.deepOrange),
        ),
      ),
    );
  }
}
