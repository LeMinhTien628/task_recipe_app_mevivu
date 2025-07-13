import 'package:flutter/material.dart';

class AppSearchField extends StatelessWidget {
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final String hintText;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;

  const AppSearchField({
    super.key,
    this.controller,
    this.onChanged,
    this.hintText = "Tìm kiếm...",
    this.borderRadius = 10,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final textField = TextField(
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: const Icon(Icons.search),
        filled: true,
        fillColor: Colors.grey.shade200,
        contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide.none,
        ),
      ),
    );

    return padding != null
        ? Padding(padding: padding!, child: textField)
        : textField;
  }
}
