import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  Widget? prefixIcon;
  String? hintText;
  void Function(String)? onSubmitted;
  CustomInput({super.key, this.prefixIcon, this.hintText, this.onSubmitted});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onSubmitted: onSubmitted,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: prefixIcon,
        contentPadding: const EdgeInsets.symmetric(vertical: 16),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    );
  }

}