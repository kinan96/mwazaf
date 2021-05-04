import 'package:flutter/material.dart';

class MyTextFormField extends StatelessWidget {
  final String hint;
  final IconData icon;
  final bool isPassword;
  final TextEditingController controller;
  final String Function(String) validator;

  const MyTextFormField(
      {Key key,
      this.hint,
      this.isPassword = false,
      this.icon,
      this.controller,
      this.validator})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        isDense: true,
        prefixIcon: Icon(
          icon,
          color: Colors.white,
          size: 28,
        ),
        hintText: hint,
        hintStyle: TextStyle(color: Colors.white),
      ),
    );
  }
}
