import 'package:flutter/material.dart';

class generateTextFormField extends StatelessWidget {
  TextEditingController controller;
  String hintName;
  // IconData iconData;

  generateTextFormField({
    super.key,
    required this.controller,
    required this.hintName,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
          hintText: hintName,
          labelText: "Enter $hintName",
          fillColor: Colors.white,
          filled: true),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please Enter $hintName';
        }
      },
    );
  }
}
