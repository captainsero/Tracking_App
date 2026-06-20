import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tracking_app/core/constants/font_manager.dart';
import 'package:tracking_app/core/constants/values_manager.dart';
import 'package:tracking_app/features/auth/forget_password/presentation/view_model/cubit/forgot_password_cubit.dart';
import 'package:tracking_app/features/auth/forget_password/presentation/widgets/otp_code_field.dart';
import 'package:tracking_app/generated/l10n.dart';

class VerifyResetView extends StatefulWidget {
  const VerifyResetView({super.key, required this.forgotPasswordCubit});

  final ForgotPasswordCubit forgotPasswordCubit;

  @override
  State<VerifyResetView> createState() => _VerifyResetViewState();
}

class _VerifyResetViewState extends State<VerifyResetView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: Icon(Icons.arrow_back_ios),
        ),
        title: Text(S.of(context).password),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppPadding.p20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,

          children: [
            Text(
              S.of(context).emailVerification,
              style: Theme.of(context).textTheme.headlineMedium,
            ),

            SizedBox(height: AppSize.s16),

            Text(
              S.of(context).emailVerificationDis,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
            ),

            SizedBox(height: AppSize.s30),

            OtpCodeField(forgotPasswordCubit: widget.forgotPasswordCubit),

            SizedBox(height: AppSize.s30),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  S.of(context).didnotReceiveCode,
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall!.copyWith(fontSize: FontSize.s16),
                ),
                TextButton(
                  onPressed: () async => await context.read().resendCode(),
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size(AppSize.s0, AppSize.s0),
                  ),
                  child: Text(
                    S.of(context).resend,
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      decorationColor: Theme.of(
                        context,
                      ).colorScheme.primary, // optional
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
