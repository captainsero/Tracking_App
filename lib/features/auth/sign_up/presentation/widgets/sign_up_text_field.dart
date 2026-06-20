import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tracking_app/config/validators/text_field_validator.dart';
import 'package:tracking_app/core/constants/color_manager.dart';
import 'package:tracking_app/core/constants/font_manager.dart';
import 'package:tracking_app/core/constants/style_manager.dart';
import 'package:tracking_app/core/constants/values_manager.dart';
import 'package:tracking_app/core/errors/validation_error_localizer.dart';
import 'package:tracking_app/generated/l10n.dart';

class SignUpTextField extends StatefulWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final bool obscureText;
  final Widget? suffixIcon;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
  final bool isNidField; // New: Special handling for National ID

  const SignUpTextField({
    super.key,
    required this.label,
    required this.hint,
    required this.controller,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.suffixIcon,
    this.maxLength,
    this.inputFormatters,
    this.isNidField = false,
  });

  @override
  State<SignUpTextField> createState() => _SignUpTextFieldState();
}

class _SignUpTextFieldState extends State<SignUpTextField> {
  OutlineInputBorder _border(Color color, {double width = 1}) => OutlineInputBorder(
    borderRadius: BorderRadius.circular(AppSize.s8),
    borderSide: BorderSide(color: color, width: width),
  );

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);

    final effectiveValidator = widget.validator ??
        (widget.isNidField
            ? (String? v) => AppTextFieldValidator.validateNid(v)?.localize(l10n)
            : null);

    final effectiveInputFormatters = [
      if (widget.isNidField) FilteringTextInputFormatter.digitsOnly,
      ...?widget.inputFormatters,
    ];

    final effectiveMaxLength = widget.isNidField ? 14 : widget.maxLength;

    return TextFormField(
      controller: widget.controller,
      validator: effectiveValidator,
      keyboardType: widget.isNidField ? TextInputType.number : widget.keyboardType,
      obscureText: widget.obscureText,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      maxLength: effectiveMaxLength,
      inputFormatters: effectiveInputFormatters.isNotEmpty ? effectiveInputFormatters : null,
      style: getRegularStyle(
        color: AppColors.black,
        fontSize: FontSize.s16,
        fontFamily: FontConstants.interFamily,
      ),
      decoration: InputDecoration(
        labelText: widget.label,
        hintText: widget.hint,
        suffixIcon: widget.suffixIcon,
        counterText: '',
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelStyle: getMediumStyle(
          color: AppColors.hintColor,
          fontSize: FontSize.s14,
          fontFamily: FontConstants.interFamily,
        ),
        hintStyle: getRegularStyle(
          color: AppColors.hintColor,
          fontSize: FontSize.s16,
          fontFamily: FontConstants.interFamily,
        ),
        errorStyle: getRegularStyle(
          color: AppColors.error,
          fontSize: FontSize.s12,
          fontFamily: FontConstants.interFamily,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppPadding.p16,
          vertical: AppPadding.p16,
        ),
        border: _border(AppColors.hintColor.withValues(alpha: 0.4)),
        enabledBorder: _border(AppColors.hintColor.withValues(alpha: 0.4)),
        focusedBorder: _border(AppColors.primary, width: AppSize.s1_5),
        errorBorder: _border(AppColors.error),
        focusedErrorBorder: _border(AppColors.error, width: AppSize.s1_5),
      ),
    );
  }
}