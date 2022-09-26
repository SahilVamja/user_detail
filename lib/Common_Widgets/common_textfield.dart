import 'package:flutter/material.dart';

class CommonTextField extends StatelessWidget {
  final String labelText;
  final dynamic validate;
  final dynamic type;
  final dynamic controller;

  const CommonTextField({Key? key, required this.labelText, this.validate, this.type, this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: TextFormField(
        controller: controller,
        keyboardType: type,
        decoration: InputDecoration(
            labelText: labelText, border: const OutlineInputBorder()),
        validator: validate,
      ),
    );
  }
}
