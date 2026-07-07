import 'package:flutter/material.dart';
import 'package:tracking_app/core/constants/color_manager.dart';
import 'package:tracking_app/core/constants/font_manager.dart';
import 'package:tracking_app/core/constants/style_manager.dart';
import 'package:tracking_app/core/constants/values_manager.dart';

class SignUpFileUploadField extends StatelessWidget {
  final String label;
  final String hint;
  final String? fileName;
  final VoidCallback onTap;

  const SignUpFileUploadField({
    super.key,
    required this.label,
    required this.hint,
    required this.onTap,
    this.fileName,
  });

  OutlineInputBorder _border(Color color) => OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSize.s8),
        borderSide: BorderSide(color: color),
      );

  @override
  Widget build(BuildContext context) {
    final bool hasFile = fileName != null && fileName!.isNotEmpty;
    return InputDecorator(
      decoration: InputDecoration(
        labelText: label,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelStyle: getRegularStyle(
          color: AppColors.hintColor,
          fontSize: FontSize.s12,
          fontFamily: FontConstants.interFamily,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppPadding.p16,
          vertical: AppPadding.p12,
        ),
        border: _border(AppColors.hintColor.withValues(alpha: 0.4)),
        enabledBorder: _border(AppColors.hintColor.withValues(alpha: 0.4)),
      ),
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Row(
          children: [
            Expanded(
              child: Text(
                hasFile ? fileName! : hint,
                style: getRegularStyle(
                  color:
                      hasFile ? AppColors.black : AppColors.hintColor,
                  fontSize: FontSize.s14,
                  fontFamily: FontConstants.interFamily,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Icon(
              hasFile
                  ? Icons.check_circle_outline_rounded
                  : Icons.upload_rounded,
              color: hasFile ? AppColors.success : AppColors.hintColor,
              size: AppSize.s20,
            ),
          ],
        ),
      ),
    );
  }
}
