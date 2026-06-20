import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';
import 'package:tracking_app/config/base_state/base_state.dart';
import 'package:tracking_app/config/validators/text_field_validator.dart';
import 'package:tracking_app/core/constants/values_manager.dart';
import 'package:tracking_app/core/router/route_path.dart';
import 'package:tracking_app/features/auth/forget_password/presentation/helper/validator_helper.dart';
import 'package:tracking_app/features/auth/forget_password/presentation/view_model/cubit/forgot_password_cubit.dart';

class OtpCodeField extends StatefulWidget {
  const OtpCodeField({super.key, required this.forgotPasswordCubit});
  final ForgotPasswordCubit forgotPasswordCubit;

  @override
  State<OtpCodeField> createState() => _OtpCodeFieldState();
}

class _OtpCodeFieldState extends State<OtpCodeField> {
  final _formKey = GlobalKey<FormState>();
  final _pinController = TextEditingController();
  final _focusNode = FocusNode();

  @override
  void dispose() {
    _pinController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: AppSize.s50,
      height: AppSize.s70,
      textStyle: Theme.of(context).textTheme.titleMedium,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(RadiusSize.r10),
        border: Border.all(
          color: Theme.of(context).colorScheme.secondary,
          width: AppSize.s1,
        ),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      borderRadius: BorderRadius.circular(RadiusSize.r10),
      border: Border.all(
        color: Theme.of(context).colorScheme.primary,
        width: AppSize.s1,
      ),
    );

    final submittedPinTheme = defaultPinTheme.copyDecorationWith(
      borderRadius: BorderRadius.circular(RadiusSize.r10),
      border: Border.all(
        color: Theme.of(context).colorScheme.primary,
        width: AppSize.s1,
      ),
    );

    final errorPinTheme = defaultPinTheme.copyDecorationWith(
      borderRadius: BorderRadius.circular(RadiusSize.r10),
      color: Theme.of(context).colorScheme.onPrimary,
      border: Border.all(
        color: Theme.of(context).colorScheme.error,
        width: AppSize.s1,
      ),
    );

    return BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
      listenWhen: (previous, current) =>
          previous.verifyResetState != current.verifyResetState,
      listener: (context, state) {
        // navigate on success
        if (state.verifyResetState == BaseState(isLoading: false) &&
            state.verifyResetState.data != null &&
            state.verifyResetState.errorMessage == null) {
          context.push(
            RoutePath.resetPassword,
            extra: widget.forgotPasswordCubit,
          );
        }
      },
      buildWhen: (previous, current) =>
          previous.verifyResetState != current.verifyResetState,
      builder: (context, state) {
        return Form(
          key: _formKey,
          child: Pinput(
            controller: _pinController,
            focusNode: _focusNode,
            autofocus: true,
            length: 6,
            defaultPinTheme: defaultPinTheme,
            focusedPinTheme: focusedPinTheme,
            submittedPinTheme: submittedPinTheme,
            errorPinTheme: errorPinTheme,
            keyboardType: TextInputType.number,
            showCursor: true,
            pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
            forceErrorState: state.verifyResetState.errorMessage != null,
            errorText: state.verifyResetState.errorMessage,
            validator: (value) =>
                validationMessage(AppTextFieldValidator.validateOtpCode(value)),
            onChanged: (_) {
              if (state.verifyResetState.errorMessage != null) {
                widget.forgotPasswordCubit.clearError();
              }
            },
            onCompleted: (pin) async {
              if (_formKey.currentState!.validate()) {
                String resetCode = pin;
                await widget.forgotPasswordCubit.verifyReset(resetCode);
              }
            },
          ),
        );
      },
    );
  }
}
