import 'package:flutter/material.dart';
import 'package:tracking_app/core/constants/color_manager.dart';
import 'package:tracking_app/core/constants/font_manager.dart';

class CustomLabelField extends StatefulWidget {
  const CustomLabelField({
    super.key,
    required this.label,
    required this.controller,
    this.icon, // null = بدون icon
    this.hint,
    this.keyboardType,
    this.validator,
    this.readOnly = false,
  });

  final String label;
  final TextEditingController controller;
  final IconData? icon;
  final String? hint;
  final TextInputType? keyboardType;
  final FormFieldValidator<String>? validator;
  final bool readOnly;

  @override
  State<CustomLabelField> createState() => _CustomLabelFieldState();
}

class _CustomLabelFieldState extends State<CustomLabelField> {
  final FocusNode _focus = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focus.addListener(() => setState(() => _isFocused = _focus.hasFocus));
  }

  @override
  void dispose() {
    _focus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color iconColor = _isFocused
        ? AppColors.primary
        : AppColors.unSelectedIconColor;

    return TextFormField(
      focusNode: _focus,
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      readOnly: widget.readOnly,
      validator: widget.validator,
      style: TextStyle(
        fontSize: 14,
        color: widget.readOnly ? AppColors.hintColor : AppColors.black,
        fontFamily: FontConstants.interFamily,
      ),
      decoration: InputDecoration(
        labelText: widget.label,
        labelStyle: TextStyle(
          color: AppColors.hintColor,
          fontSize: 14,
          fontFamily: FontConstants.interFamily,
        ),
        floatingLabelStyle: TextStyle(
          color: AppColors.primary,
          fontSize: 14,
          fontFamily: FontConstants.interFamily,
          backgroundColor: AppColors.white,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        hintText: widget.hint,
        prefixIcon: widget.icon != null
            ? Icon(widget.icon, color: iconColor, size: 17)
            : null,
        filled: true,
        fillColor: AppColors.white,
        hintStyle: TextStyle(
          color: AppColors.unSelectedIconColor,
          fontSize: 14,
          fontFamily: FontConstants.interFamily,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 11,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColors.lightGrey, width: 0.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColors.primary, width: 1.2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColors.error, width: 0.5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColors.error, width: 1.2),
        ),
      ),
    );
  }
}
