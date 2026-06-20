import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:tracking_app/generated/l10n.dart';

import '../../view_model/cubit/login_cubit.dart';

class LoginTextfields extends StatelessWidget {
  const LoginTextfields({super.key});

  // Same simple email-format check used to decide between
  // emailIsRequired / enterValidEmail below.
  static final RegExp _emailRegExp = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<LoginCubit>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          // TODO: confirm `emailController` is the real field name on LoginCubit
          controller: cubit.emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            labelText: 'Email',
            hintText: 'Enter you email',
            floatingLabelBehavior: FloatingLabelBehavior.always,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(color: Colors.grey),
            ),
          ),
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return S.of(context).emailIsRequired;
            }
            if (!_emailRegExp.hasMatch(value.trim())) {
              return S.of(context).enterValidEmail;
            }
            return null;
          },
        ),
        SizedBox(height: 20.h),
        TextFormField(
          // TODO: confirm `passwordController` is the real field name on LoginCubit
          controller: cubit.passwordController,
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'Password',
            hintText: 'Enter you password',
            floatingLabelBehavior: FloatingLabelBehavior.always,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(color: Colors.grey),
            ),
          ),
          validator: (value) {
            // NOTE: the provided keys.json only has `enterValidPassword`
            // ("Password needs uppercase, digit, and special char"), which
            // reads like a *signup* rule, not a *login* rule. For a login
            // screen you usually only want a "required" check here (the
            // server tells you if the password is wrong). Add a dedicated
            // key (e.g. "passwordIsRequired") if you want a cleaner message.
            if (value == null || value.isEmpty) {
              return S.of(context).enterValidPassword;
            }
            return null;
          },
        ),
      ],
    );
  }
}