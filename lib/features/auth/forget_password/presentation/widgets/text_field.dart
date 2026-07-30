import 'package:flutter/material.dart';
import 'package:tracking_app/core/constants/ui_style_helper.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final String hint;
  final String? errorText;
  final bool obscureText;
  final ValueChanged<String> onChanged;
  final TextEditingController? controller;

  const CustomTextField({
    super.key,
    required this.label,
    required this.hint,
    required this.onChanged,
    this.errorText,
    this.obscureText = false,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final hasError = errorText != null && errorText!.isNotEmpty;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.inputLabel),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          onChanged: onChanged,
          obscureText: obscureText,
          style: AppTextStyles.inputText,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: AppTextStyles.inputHint,
            filled: true,
            fillColor: AppColorsHelper.inputFill,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 14,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: hasError
                    ? AppColorsHelper.error
                    : AppColorsHelper.border,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: hasError
                    ? AppColorsHelper.error
                    : AppColorsHelper.border,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: hasError
                    ? AppColorsHelper.error
                    : AppColorsHelper.borderFocused,
              ),
            ),
          ),
        ),
        if (hasError) ...[
          const SizedBox(height: 4),
          Text(errorText!, style: AppTextStyles.errorText),
        ],
      ],
    );
  }
}
