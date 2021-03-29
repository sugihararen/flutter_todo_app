import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PrimaryTextFormField extends StatelessWidget {
  final String hintText;
  final TextEditingController textEditingController;
  final bool autofocus;
  final bool obscureText;
  final Function(String) validator;

  PrimaryTextFormField({
    @required this.hintText,
    @required this.textEditingController,
    this.autofocus,
    this.obscureText,
    @required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: hintText,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xffCECECE)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xffCECECE)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xffCECECE)),
        ),
      ),
      autofocus: autofocus ?? false,
      obscureText: obscureText ?? false,
      controller: textEditingController,
      validator: (String value) => validator(value),
    );
  }
}
