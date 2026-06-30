import 'package:flutter/material.dart';
import 'package:tracking_app/core/constants/color_manager.dart';
import 'package:tracking_app/core/constants/font_manager.dart';
import 'package:tracking_app/core/constants/style_manager.dart';
import 'package:tracking_app/core/constants/values_manager.dart';

class SignUpDropdown<T> extends StatelessWidget {
  final String label;
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final void Function(T?) onChanged;
  final String? Function(T?)? validator;
  final Widget? prefixWidget;

  const SignUpDropdown({
    super.key,
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
    this.validator,
    this.prefixWidget,
  });

  OutlineInputBorder _border(Color color, {double width = 1}) =>
      OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSize.s8),
        borderSide: BorderSide(color: color, width: width),
      );

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      value: value,
      items: items,
      onChanged: onChanged,
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      icon: Icon(Icons.keyboard_arrow_down_rounded, color: AppColors.black),
      isExpanded: true,
      dropdownColor: AppColors.white,
      menuMaxHeight: 300,
      style: getRegularStyle(
        color: AppColors.black,
        fontSize: FontSize.s16,
        fontFamily: FontConstants.interFamily,
      ),
      decoration: InputDecoration(
        labelText: label,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        prefixIcon: prefixWidget != null
            ? Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppPadding.p12,
                  vertical: AppPadding.p10,
                ),
                child: prefixWidget,
              )
            : null,
        prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
        labelStyle: getMediumStyle(
          color: AppColors.hintColor,
          fontSize: FontSize.s14,
          fontFamily: FontConstants.interFamily,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppPadding.p16,
          vertical: AppPadding.p16,
        ),
        border: _border(AppColors.hintColor.withValues(alpha: .4)),
        enabledBorder: _border(AppColors.hintColor.withValues(alpha: .4)),
        focusedBorder: _border(AppColors.primary, width: AppSize.s1_5),
        errorBorder: _border(AppColors.error),
        focusedErrorBorder: _border(AppColors.error, width: AppSize.s1_5),
      ),
    );
  }
}
