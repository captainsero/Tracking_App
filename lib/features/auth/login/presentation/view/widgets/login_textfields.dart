import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tracking_app/config/validators/text_field_validator.dart';
import 'package:tracking_app/generated/l10n.dart';

class LoginTextfields extends StatefulWidget {
  const LoginTextfields({
    super.key,
    required this.emailController,
    required this.passwordController,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  State<LoginTextfields> createState() => _LoginTextfieldsState();
}

class _LoginTextfieldsState extends State<LoginTextfields> {
  bool _isPasswordObscured = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: widget.emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            labelText: S.of(context).email,
            hintText: S.of(context).Enter_your_email,
          ),
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return S.of(context).emailIsRequired;
            }
            if (AppTextFieldValidator.validateEmail(value.trim()) != null) {
              return S.of(context).enterValidEmail;
            }
            return null;
          },
        ),
        SizedBox(height: 20.h),
        TextFormField(
          controller: widget.passwordController,
          obscureText: _isPasswordObscured,
          decoration: InputDecoration(
            labelText: S.of(context).Password,
            hintText: S.of(context).Enter_your_password,
            suffixIcon: IconButton(
              icon: Icon(
                _isPasswordObscured ? Icons.visibility_off : Icons.visibility,
                color: _isPasswordObscured
                    ? Colors.grey
                    : Theme.of(context).colorScheme.primary,
              ),
              onPressed: () {
                setState(() {
                  _isPasswordObscured = !_isPasswordObscured;
                });
              },
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return S.of(context).enterValidPassword;
            }
            if (AppTextFieldValidator.validatePassword(value.trim()) != null) {
              return S.of(context).enterValidPassword;
            }
            return null;
          },
        ),
      ],
    );
  }
}
