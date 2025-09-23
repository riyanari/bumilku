import 'package:bumilku_app/theme/theme.dart';
import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;
  final String? suffixText;
  final int? maxLines;

  const CustomInputField({
    super.key,
    required this.controller,
    required this.label,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.onChanged,
    this.suffixText, // TAMBAHKAN
    this.maxLines, // TAMBAHKAN
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withValues(alpha:0.2),
                spreadRadius: 1,
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            validator: validator,
            onChanged: onChanged,
            maxLines: maxLines ?? 1,
            decoration: InputDecoration(
              labelText: label,
              labelStyle: primaryTextStyle.copyWith(fontSize: 12),
              suffixText: suffixText,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
            ),
          ),
        ),
        ValueListenableBuilder<TextEditingValue>(
          valueListenable: controller,
          builder: (context, value, child) {
            final error = validator != null ? validator!(value.text) : null;
            return error != null
                ? Padding(
              padding: const EdgeInsets.only(left: 16, top: 4, bottom: 8),
              child: Text(
                error,
                style: TextStyle(color: Colors.red.shade700, fontSize: 12),
              ),
            )
                : const SizedBox(height: 12);
          },
        ),
      ],
    );
  }
}