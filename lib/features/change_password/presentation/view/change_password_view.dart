import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracking_app/core/constants/screen_size.dart';
import 'package:tracking_app/config/validators/text_field_validator.dart';
import 'package:tracking_app/features/change_password/presentation/view_model/change_password_cubit.dart';
import 'package:tracking_app/features/change_password/presentation/view_model/change_password_event.dart';
import 'package:tracking_app/features/change_password/data/models/change_password_request.dart';
import 'package:tracking_app/features/change_password/presentation/view_model/change_password_state.dart';
import 'package:tracking_app/generated/l10n.dart';
import 'package:tracking_app/core/errors/validation_error_localizer.dart';

class ChangePasswordView extends StatefulWidget {
  const ChangePasswordView({super.key});

  @override
  State<ChangePasswordView> createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<ChangePasswordView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _currentPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios),
        ),
        leadingWidth: 20,
        title: Text(S.of(context).password),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              spacing: 24,
              children: [
                BlocBuilder<ChangePasswordCubit, ChangePasswordState>(
                  buildWhen: (prev, curr) =>
                      prev.changePasswordState != curr.changePasswordState,
                  builder: (context, state) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          cursorColor: Theme.of(
                            context,
                          ).colorScheme.onSecondary,
                          controller: _currentPasswordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: S.of(context).currentPassword,
                            hintText: S.of(context).currentPassword,
                          ),
                          validator: (v) =>
                              AppTextFieldValidator.validatePassword(
                                v,
                              )?.localize(S.of(context)),
                        ),

                        if (state.changePasswordState.errorMessage != null &&
                            state.changePasswordState.isLoading != true)
                          Padding(
                            padding: const EdgeInsets.only(top: 6, left: 12),
                            child: Text(
                              state.changePasswordState.errorMessage!,
                              style: Theme.of(context).textTheme.bodySmall!
                                  .copyWith(
                                    color: Theme.of(context).colorScheme.error,
                                  ),
                            ),
                          ),
                      ],
                    );
                  },
                ),

                TextFormField(
                  cursorColor: Theme.of(context).colorScheme.onSecondary,
                  controller: _newPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: S.of(context).newPassword,
                    hintText: S.of(context).newPassword,
                  ),
                  validator: (v) => AppTextFieldValidator.validatePassword(
                    v,
                  )?.localize(S.of(context)),
                ),

                TextFormField(
                  cursorColor: Theme.of(context).colorScheme.onSecondary,
                  controller: _confirmPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: S.of(context).confirmPassword,
                    hintText: S.of(context).confirmPassword,
                  ),
                  validator: (value) =>
                      AppTextFieldValidator.validateConfirmPassword(
                        value,
                        _newPasswordController.text,
                      )?.localize(S.of(context)),
                ),

                const SizedBox(height: 24),

                BlocConsumer<ChangePasswordCubit, ChangePasswordState>(
                  listenWhen: (prev, curr) =>
                      prev.changePasswordState != curr.changePasswordState,
                  listener: (context, state) {
                    if (state.changePasswordState.isLoading != true &&
                        state.changePasswordState.data != null &&
                        state.changePasswordState.errorMessage == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(S.of(context).applySuccess),
                          backgroundColor: Theme.of(
                            context,
                          ).colorScheme.primary,
                        ),
                      );
                      Navigator.pop(context);
                    }
                  },
                  buildWhen: (prev, curr) =>
                      prev.changePasswordState.isLoading !=
                      curr.changePasswordState.isLoading,
                  builder: (context, state) {
                    return SizedBox(
                      width: ScreenSize.width,
                      child: ElevatedButton(
                        onPressed: state.changePasswordState.isLoading == true
                            ? null
                            : () {
                                if (_formKey.currentState!.validate()) {
                                  final req = ChangePasswordRequest(
                                    password: _currentPasswordController.text
                                        .trim(),
                                    newPassword: _newPasswordController.text
                                        .trim(),
                                  );

                                  context.read<ChangePasswordCubit>().doEvent(
                                    ChangePasswordEvent(passwords: req),
                                  );
                                }
                              },
                        child: state.changePasswordState.isLoading == true
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            : Text(S.of(context).apply),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
