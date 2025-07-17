import 'package:flutter/material.dart';

class MTF extends StatefulWidget {
  final String hintText;
  final String labelText;
  final bool obscureText;
  final TextEditingController controller;
  final FocusNode? focusNode;
  final String? Function(String?)? validator;

  const MTF({
    super.key,
    required this.hintText,
    required this.labelText,
    required this.obscureText,
    required this.controller,
    this.focusNode,
    this.validator,
  });

  @override
  State<MTF> createState() => _MTFState();
}

class _MTFState extends State<MTF> {
  late bool _isObscured;

  @override
  void initState() {
    super.initState();
    _isObscured = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: TextFormField(
        focusNode: widget.focusNode,
        controller: widget.controller,
        validator: widget.validator,
        obscureText: _isObscured,
        decoration: InputDecoration(
          hintText: widget.hintText,
          labelText: widget.labelText,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(11)),

          // Show toggle icon only if it's a password field
          suffixIcon: widget.obscureText
              ? IconButton(
            icon: Icon(
              _isObscured ? Icons.visibility_off : Icons.visibility,
            ),
            onPressed: () {
              setState(() {
                _isObscured = !_isObscured;
              });
            },
          )
              : null,
        ),
      ),
    );
  }
}
