import 'package:flutter/material.dart';

class MTF extends StatelessWidget {
  final String hintText;
  final String labelText;
  final bool obscureText;
  final TextEditingController controller;
  final FocusNode? focusNode;

  const MTF({
    super.key,
    required this.hintText,
    required this.labelText,
    required this.obscureText,
    required this.controller,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: TextFormField(
        focusNode: focusNode,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(11)),
          hintText: hintText,
          labelText: labelText,
        ),
        obscureText: obscureText,
        controller: controller,
      ),
    );
  }
}
