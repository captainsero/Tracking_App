import 'package:flutter/material.dart';

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
    this.borderRadius = 8,
  });

  final String label;
  final TextEditingController controller;
  final IconData? icon;
  final String? hint;
  final TextInputType? keyboardType;
  final FormFieldValidator<String>? validator;
  final bool readOnly;
  final double borderRadius;

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

  OutlineInputBorder _buildBorder(Color color, {double width = 1}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(widget.borderRadius),
      borderSide: BorderSide(color: color, width: width),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final inputTheme = theme.inputDecorationTheme;

    final Color activeColor = _isFocused
        ? colorScheme.primary
        : theme.hintColor;

    return TextFormField(
      focusNode: _focus,
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      readOnly: widget.readOnly,
      validator: widget.validator,
      style: theme.textTheme.titleSmall?.copyWith(
        color: widget.readOnly
            ? theme.hintColor
            : theme.textTheme.titleSmall?.color,
      ),
      decoration: InputDecoration(
        labelText: widget.label,
        labelStyle: inputTheme.labelStyle,
        floatingLabelStyle: inputTheme.floatingLabelStyle?.copyWith(
          color: colorScheme.primary,
          backgroundColor: theme.scaffoldBackgroundColor,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        hintText: widget.hint,
        prefixIcon: widget.icon != null
            ? Icon(widget.icon, color: activeColor, size: 17)
            : null,
        filled: true,
        fillColor: theme.scaffoldBackgroundColor,
        hintStyle: inputTheme.hintStyle,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 11,
        ),
        enabledBorder: _buildBorder(theme.hintColor.withOpacity(0.4)),
        focusedBorder: _buildBorder(colorScheme.primary, width: 1.5),
        errorBorder: _buildBorder(colorScheme.error),
        focusedErrorBorder: _buildBorder(colorScheme.error, width: 1.5),
      ),
    );
  }
}
