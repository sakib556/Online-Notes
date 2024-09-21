import 'package:flutter/material.dart';

class GlobalTextField extends StatelessWidget {
  const GlobalTextField(
      {super.key,
      required this.label,
      required this.hint,
      required this.controller});
  final String label;
  final String hint;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        label: Text(label),
        hintText: hint,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.black,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.red,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
