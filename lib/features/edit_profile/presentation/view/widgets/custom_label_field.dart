import 'package:flutter/material.dart';
import 'package:tracking_app/core/constants/color_manager.dart';

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
  bool _hasValue = false;

  @override
  void initState() {
    super.initState();
    _focus.addListener(() => setState(() => _isFocused = _focus.hasFocus));
    widget.controller.addListener(
      () => setState(() => _hasValue = widget.controller.text.isNotEmpty),
    );
    // لو الـ controller فيه قيمة من الأول
    _hasValue = widget.controller.text.isNotEmpty;
  }

  @override
  void dispose() {
    _focus.dispose();
    super.dispose();
  }

  bool get _isFloating => _isFocused || _hasValue;

  @override
  Widget build(BuildContext context) {
    final Color borderColor = _isFocused
        ? AppColors.primary
        : Colors.grey.shade200;
    final Color labelColor = _isFocused
        ? AppColors.primary
        : Colors.grey.shade500;
    final Color iconColor = _isFocused
        ? AppColors.primary
        : Colors.grey.shade400;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        // ── TextFormField ────────────────────────────────────────────────
        TextFormField(
          focusNode: _focus,
          controller: widget.controller,
          keyboardType: widget.keyboardType,
          readOnly: widget.readOnly,
          validator: widget.validator,
          style: TextStyle(
            fontSize: 14,
            color: widget.readOnly ? Colors.grey.shade500 : Colors.black87,
            fontFamily: 'Inter',
          ),
          decoration: InputDecoration(
            hintText: _isFloating ? widget.hint : null,
            prefixIcon: widget.icon != null
                ? Icon(widget.icon, color: iconColor, size: 17)
                : null,
            filled: true,
            fillColor: const Color(0xFFF7F7F7),
            hintStyle: TextStyle(
              color: Colors.grey.shade400,
              fontSize: 14,
              fontFamily: 'Inter',
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 11,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey.shade200, width: 0.5),
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
        ),

        // ── Floating Label ───────────────────────────────────────────────
        AnimatedPositioned(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOut,
          top: _isFloating ? -9 : 13,
          left: widget.icon != null ? 42 : 12,
          child: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 180),
            style: TextStyle(
              fontSize: _isFloating ? 11 : 14,
              color: labelColor,
              fontFamily: 'Inter',
              backgroundColor: const Color(0xFFF7F7F7),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3),
              child: Text(widget.label),
            ),
          ),
        ),
      ],
    );
  }
}