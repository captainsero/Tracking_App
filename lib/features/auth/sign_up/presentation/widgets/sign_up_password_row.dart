import 'package:flutter/material.dart';
import 'package:tracking_app/config/validators/text_field_validator.dart';
import 'package:tracking_app/core/errors/validation_error_localizer.dart';
import 'package:tracking_app/core/constants/color_manager.dart';
import 'package:tracking_app/core/constants/values_manager.dart';
import 'package:tracking_app/generated/l10n.dart';
import 'sign_up_text_field.dart';

class SignUpPasswordRow extends StatefulWidget {
  final TextEditingController passwordController;
  final TextEditingController confirmController;

  const SignUpPasswordRow({
    super.key,
    required this.passwordController,
    required this.confirmController,
  });

  @override
  State<SignUpPasswordRow> createState() => _SignUpPasswordRowState();
}

class _SignUpPasswordRowState extends State<SignUpPasswordRow> {
  bool _obscurePass = true;
  bool _obscureConfirm = true;

  Widget _eyeIcon(bool obscure, VoidCallback onTap) => GestureDetector(
    onTap: onTap,
    child: Icon(
      obscure ? Icons.visibility_off_outlined : Icons.visibility_outlined,
      color: AppColors.hintColor,
      size: AppSize.s20,
    ),
  );

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);
    return Row(
      children: [
        Expanded(
          child: SignUpTextField(
            label: l10n.password,
            hint: l10n.enterPassword,
            controller: widget.passwordController,
            obscureText: _obscurePass,
            validator: (v) => AppTextFieldValidator.validatePassword(v)?.localize(l10n),
            suffixIcon: _eyeIcon(
              _obscurePass,
                  () => setState(() => _obscurePass = !_obscurePass),
            ),
          ),
        ),
        const SizedBox(width: AppSize.s12),
        Expanded(
          child: SignUpTextField(
            label: l10n.enterConfirmPassword,
            hint: l10n.enterConfirmPassword,
            controller: widget.confirmController,
            obscureText: _obscureConfirm,
            validator: (v) => AppTextFieldValidator.validateConfirmPassword(
              v,
              widget.passwordController.text,
            )?.localize(l10n),
            suffixIcon: _eyeIcon(
              _obscureConfirm,
                  () => setState(() => _obscureConfirm = !_obscureConfirm),
            ),
          ),
        ),
      ],
    );
  }
}