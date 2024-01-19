import 'package:flutter/material.dart';

class TextInputForm extends StatelessWidget {
  final String? hintText;
  final TextEditingController controller;
  final TextInputType inputType;
  final bool passwordTextStatus;

  const TextInputForm({
    Key? key,
    this.hintText,
    required this.controller,
    required this.inputType,
    this.passwordTextStatus = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      child: TextFormField(
        keyboardType: inputType,
        controller: controller,
        obscureText: passwordTextStatus,
        decoration: InputDecoration(
          hintText: hintText,
        ),
      ),
    );
  }
}