import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tracking_app/config/validators/text_field_validator.dart';
import 'package:tracking_app/core/constants/values_manager.dart';
import 'package:tracking_app/core/router/route_path.dart';
import 'package:tracking_app/features/auth/forget_password/data/models/requests/reset_password_request.dart';
import 'package:tracking_app/features/auth/forget_password/presentation/helper/validator_helper.dart';
import 'package:tracking_app/features/auth/forget_password/presentation/view_model/cubit/forgot_password_cubit.dart';
import 'package:tracking_app/generated/l10n.dart';

class ResetPasswordView extends StatefulWidget {
  const ResetPasswordView({super.key, required this.forgotPasswordCubit});
  final ForgotPasswordCubit forgotPasswordCubit;

  @override
  State<ResetPasswordView> createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        title: Text(S.of(context).password),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppPadding.p20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                S.of(context).resetPassword,
                style: Theme.of(context).textTheme.headlineMedium,
              ),

              SizedBox(height: AppSize.s16),

              Text(
                S.of(context).resetPasswordDis,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge,
              ),

              SizedBox(height: AppSize.s30),

              BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
                buildWhen: (previous, current) =>
                    previous.resetPasswordState != current.resetPasswordState,
                builder: (context, state) {
                  return Column(
                    children: [
                      TextFormField(
                        controller: _newPasswordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: S.of(context).newPassword,
                          hintText: S.of(context).enterYourPassword,
                        ),
                        validator: (value) => validationMessage(
                          AppTextFieldValidator.validatePassword(value),
                        ),
                      ),

                      if (state.resetPasswordState.errorMessage != null &&
                          state.resetPasswordState.isLoading == true)
                        Text(
                          state.resetPasswordState.errorMessage ?? '',
                          style: Theme.of(context).textTheme.bodyLarge!
                              .copyWith(
                                color: Theme.of(context).colorScheme.error,
                              ),
                        ),
                    ],
                  );
                },
              ),

              SizedBox(height: AppSize.s30),

              TextFormField(
                controller: _confirmPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: S.of(context).confirmPassword,
                  hintText: S.of(context).confirmPassword,
                ),
                validator: (value) => validationMessage(
                  AppTextFieldValidator.validateConfirmPassword(
                    value,
                    _newPasswordController.text,
                  ),
                ),
              ),

              SizedBox(height: AppSize.s30),

              BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
                listenWhen: (previous, current) =>
                    previous.resetPasswordState != current.resetPasswordState,
                listener: (context, state) {
                  if (state.resetPasswordState.isLoading == false &&
                      state.resetPasswordState.data != null &&
                      state.resetPasswordState.errorMessage == null) {
                    context.go(RoutePath.login);
                  }
                },
                builder: (context, state) {
                  return SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: state.resetPasswordState.isLoading == true
                          ? null
                          : () async {
                              if (_formKey.currentState!.validate()) {
                                String newPassword =
                                    _newPasswordController.text;
                                context
                                    .read<ForgotPasswordCubit>()
                                    .resetPassword(
                                      ResetPasswordRequest(
                                        newPassword: newPassword,
                                      ),
                                    );
                              }
                            },
                      child: Text(S.of(context).continueButton),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}
