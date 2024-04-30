import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatefulWidget {
  final String text;
  final IconData icon;
  final bool isSecret;
  final List<TextInputFormatter>? inputFormatters;
  final String? initialValue;
  final bool isReadonly;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final TextInputType? textInputType;
  final GlobalKey<FormFieldState>? formFieldKey;

  const CustomTextField({
    super.key,
    required this.text,
    required this.icon,
    this.isSecret = false,
    this.inputFormatters,
    this.initialValue,
    this.isReadonly = false,
    this.validator,
    this.controller,
    this.textInputType,
    this.formFieldKey,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isObscured = false;

  @override
  void initState() {
    super.initState();
    isObscured = widget.isSecret;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextFormField(
        key: widget.formFieldKey,
        inputFormatters: widget.inputFormatters,
        obscureText: isObscured,
        readOnly: widget.isReadonly,
        initialValue: widget.initialValue,
        validator: widget.validator,
        controller: widget.controller,
        keyboardType: widget.textInputType,
        decoration: InputDecoration(
            isDense: true,
            prefixIcon: Icon(widget.icon),
            suffixIcon: widget.isSecret
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        isObscured = !isObscured;
                      });
                    },
                    icon: Icon(
                        isObscured ? Icons.visibility : Icons.visibility_off))
                : null,
            labelText: widget.text,
            hintText: widget.text,
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(18))),
      ),
    );
  }
}
